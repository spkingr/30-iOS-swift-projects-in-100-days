//
//  ViewController.swift
//  ProjectLinesDrawingView
//
//  Created by 刘庆文 on 2-11.
//  Copyright © 2018 Liuqingwens. All rights reserved.
//

import UIKit

protocol DrawingDelegate
{
    var canUndo:Bool {get}
    var canRedo:Bool {get}
    
    func undo()
    func redo()
    func clear()
}

class ViewController: UIViewController
{
    @IBOutlet weak var buttonUndo:UIBarButtonItem!
    @IBOutlet weak var buttonRedo:UIBarButtonItem!
    @IBOutlet weak var buttonClear:UIBarButtonItem!
    
    private var drawingDelegate:DrawingDelegate? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let drawingView = self.view as? DrawingDelegate {
            self.drawingDelegate = drawingView
            self.navigationController?.isToolbarHidden = false //!Important!
        }
        
        self.updateButtons()
    }
    
    private func updateButtons()
    {
        self.buttonUndo.isEnabled = self.drawingDelegate?.canUndo ?? false
        self.buttonRedo.isEnabled = self.drawingDelegate?.canRedo ?? false
        self.buttonClear.isEnabled = self.buttonUndo.isEnabled
    }
    
    @IBAction func onUndoAction(_ sender:AnyObject?)
    {
        self.drawingDelegate?.undo()
        self.updateButtons()
    }
    
    @IBAction func onRedoAction(_ sender:AnyObject?)
    {
        self.drawingDelegate?.redo()
        self.updateButtons()
    }
    
    @IBAction func onClearAction(_ sender:AnyObject?)
    {
        self.drawingDelegate?.clear()
        self.updateButtons()
    }
    
    @IBAction func onSaveAction(_ sender:AnyObject?)
    {
        let alert = UIAlertController(title: "Save Image", message: "Specify the name for the image:", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "image file name"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.saveImage(alert)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    private func saveImage(_ alert: UIAlertController)
    {
        guard
                let textField = alert.textFields?.first,
                let fileName = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                !fileName.isEmpty else {
            self.showAlertWith(title: "Warning", information: "Please specify the correct file name and try again!")
            return
        }
        
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, UIScreen.main.scale)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageQuality = CGFloat(0.8)
        let imageExtension = "jpg"
        
        guard let imageData = image else {
            self.showAlertWith(title: "Error", information: "Clip data error! Try it later.")
            return
        }
        guard let jpegData = UIImageJPEGRepresentation(imageData, imageQuality) else {
            self.showAlertWith(title: "Error", information: "The data is corrupted!")
            return
        }
        
        guard let url = imageUrlFor(fileName: fileName, extension: imageExtension) else {
            self.showAlertWith(title: "Error", information: "")
            return
        }
        
        do{
            try jpegData.write(to: url, options: .atomic)
            self.showAlertWith(title: "Success", information: "Image successfully saved to the file: \(url.path)")
        }catch {
            self.showAlertWith(title: "Failure", information: "Cannot save image, error: \(error.localizedDescription)")
        }
    }
    
    private func showAlertWith(title:String, information message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        alert.addAction(doneAction)
        self.present(alert, animated: true)
    }
    
    private func imageUrlFor(fileName name: String, extension ext: String) -> URL?
    {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if var url = urls.first {
            url.appendPathComponent("\(name).\(ext)", isDirectory: false)
            return url
        }
        return nil
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.updateButtons()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.updateButtons()
    }
}
