//
//  ViewController.swift
//  ProjectPhotoPicker
//
//  Created by 刘庆文 on 9-8.
//  Copyright © 2017 Liuqingwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    private var images:[String] = []
    private var tableViewController : StaticTableViewController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let tableView = self.childViewControllers.first { it in
            it is StaticTableViewController
        }
        self.tableViewController = tableView as! StaticTableViewController
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction private func actionTakePhoto(_ sender:UIBarButtonItem)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            print("Camera is available!")
    
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            imagePicker.title = "Take photo for the table view"
    
            self.present(imagePicker, animated: true, completion: nil)
            
        }else {
            let alert = UIAlertController(title: "Oops", message: "Camera is unavailable now, try it later.", preferredStyle: .alert)
            let actionDone = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(actionDone)
            self.present(alert, animated: true)
        }
    }
    
    @IBAction private func actionSelectPhoto(_ sender:UIBarButtonItem)
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.title = "Select image for table view"
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [ String: Any ])
    {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.tableViewController.imagePhoto.image = selectedImage
            self.tableViewController.textTitle.text = ""
            self.tableViewController.textTitle.becomeFirstResponder()
        }
        
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true)
    }
}
