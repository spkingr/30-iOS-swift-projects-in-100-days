//
//  ViewController.swift
//  ProjectSimpleImageViewer
//
//  Created by 刘庆文 on 1-14.
//  Copyright © 2018 Liuqingwen. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIScrollViewDelegate
{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var textUrl:UITextField!
    @IBOutlet weak var labelScale:UILabel!
    
    //private var imageUrl = "https://farm5.staticflickr.com/4619/24817524277_3b035e35cb_c.jpg"
    private let urlSession = URLSession(configuration: .default)
    private let formatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    @IBAction func loadImage()
    {
        self.textUrl.resignFirstResponder()
        if let url = self.textUrl.text {
            //self.imageUrl = url
            self.loadImageFrom(url: url)
        }
    }
    
    @IBAction func hideKeyboard()
    {
        self.textUrl.resignFirstResponder()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.configView()
        //self.loadImageFrom(url: self.imageUrl)
    }
    
    private func configView()
    {
        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1
        self.scrollView.maximumZoomScale = 5
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat)
    {
        self.labelScale.text = "\(self.formatter.string(from: NSNumber(value: Float(scale)))!)"
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return self.imageView
    }
    
    private func loadImageFrom(url:String)
    {
        if let url = URL(string: url) {
            self.urlSession.dataTask(with: url){ data, response, error in
                if
                        let response = response as? HTTPURLResponse, response.statusCode == 200,
                        let data = data, error == nil,
                        let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }else{
                    DispatchQueue.main.async {
                        self.showAlertWith(title: "Error", info: "Error while loading, Error: \(error?.localizedDescription ?? "Invalid path")")
                    }
                }
            }.resume()
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
