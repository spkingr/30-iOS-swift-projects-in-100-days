//
//  ViewController.swift
//  ProjectNetworkImage
//
//  Created by 刘庆文 on 12-30.
//  Copyright © 2017 Liuqingwen. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{
    @IBOutlet weak var imagePhoto:UIImageView!
    @IBOutlet weak var textUrl:UITextField!
    @IBOutlet weak var buttonLoad:UIButton!
    
    private var isLoading = false
    private var urlSession = URLSession(configuration: .default)
    private var urlPath:String {
        get {
            return self.textUrl.text ?? ""
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.buttonLoad.layer.cornerRadius = 4.0
        self.textUrl.becomeFirstResponder()
    }
    
    @IBAction func loadImage(_ sender:Any?)
    {
        if self.isLoading {
            self.showAlertWith(title: "Info", info: "Image is loading now, please wait.")
            return
        }
        
        self.imagePhoto.image = UIImage(named: "photoalbum")
        
        if self.urlPath.isEmpty {
            self.showAlertWith(title: "Error", info: "You should specify the image url before load image!")
            return
        }
        
        if let url = URL(string: self.urlPath) {
            self.isLoading = true
            self.urlSession.dataTask(with: url) {data, response, error in
                if
                        let response = response as? HTTPURLResponse, response.statusCode == 200,
                        let data = data, error == nil,
                        let image = UIImage(data: data) {
                    DispatchQueue.main.async() {
                        self.isLoading = false
                        self.imagePhoto.image = image
                    }
                } else {
                    self.isLoading = false
                    DispatchQueue.main.async() {
                        self.showAlertWith(title: "Error", info: "Cannot load image from the url: \(error?.localizedDescription ?? "invalidate path").")
                    }
                }
            }.resume()
        } else {
            self.showAlertWith(title: "Error", info: "Invalidate url path, please check and retry again!")
        }
    }
    
    private func showAlertWith(title:String, info:String)
    {
        let alert = UIAlertController(title: title, message: info, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
