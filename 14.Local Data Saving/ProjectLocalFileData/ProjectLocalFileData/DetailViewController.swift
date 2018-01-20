//
// Created by 刘庆文 on 1-20.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var item:DataItem!
    private let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelStars: UILabel!
    @IBOutlet weak var labelBirthday: UILabel!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = self.item.name
        
        self.labelName.text = "Name: \(self.item.name)"
        self.labelStars.text = "Stars: \(self.item.stars)"
        self.labelBirthday.text = "Birthday: \(self.dateFormatter.string(from: self.item.birthday))"
        self.labelInfo.text = self.item.info ?? "-"
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [ String: Any ])
    {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageProfile.image = image
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true)
    }
    
    @IBAction func onActionCameraOrPickImage(_ sender:Any)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true)
        }else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true)
        }
    }
    
}
