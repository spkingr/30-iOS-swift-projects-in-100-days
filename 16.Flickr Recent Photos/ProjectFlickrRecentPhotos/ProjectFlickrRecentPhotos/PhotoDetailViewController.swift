//
// Created by 刘庆文 on 1-26.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import UIKit

class PhotoDetailViewController:UITableViewController
{
    @IBOutlet weak var imagePhotoSource:UIImageView!
    @IBOutlet weak var labelTitle:UILabel!
    @IBOutlet weak var labelDateTaken:UILabel!
    @IBOutlet weak var buttonSave:UIButton!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    
    var dataStore: PhotoStore!
    var photo:Photo!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.title = "Photo: \(self.photo.id)"
        self.configControl()
    }
    
    private func configControl()
    {
        self.labelTitle.text = self.photo.title
        self.labelDateTaken.text = self.photo.dateTaken
        self.buttonSave.layer.cornerRadius = 4
        
        self.dataStore.loadImage(item: self.photo, type: .Source){ image in
            self.imagePhotoSource.image = image
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func saveImage(_ sender:AnyObject?)
    {
        if let image = self.imagePhotoSource.image {
            let (success, fileName) = self.dataStore.saveImage(image, with: self.photo)
            if success {
                self.showAlert(title: "Done", message: "Saving file successfully with name: \(fileName!)")
            } else {
                self.showAlert(title: "Error", message: "Failed to save file! Try later.")
            }
        }
    }
    
    private func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let actionDone = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alert.addAction(actionDone)
        self.present(alert, animated: true)
    }
}