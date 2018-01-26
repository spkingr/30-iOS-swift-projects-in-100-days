//
//  PhotoListViewController.swift
//  ProjectJsonDataTable
//
//  Created by 刘庆文 on 1-23.
//  Copyright © 2018 Liuqingwens. All rights reserved.
//

import UIKit

/*
Photo table view cell, the image if the tiny thumbnail("url_sq") from Flickr
*/
class PhotoTableViewCell:UITableViewCell
{
    static let CELL_ID = "PhotoTableViewCell"
    
    @IBOutlet weak var imageProfile:UIImageView!
    @IBOutlet weak var labelID:UILabel!
    @IBOutlet weak var labelDate:UILabel!
    @IBOutlet weak var labelTitle:UILabel!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    
    var indexPathRecord:IndexPath!
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.updateImage(nil)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.updateImage(nil)
    }
    
    func updateImage(_ image:UIImage?)
    {
        if image == nil {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        self.imageProfile.image = image
    }
}

/*
Photo List View Controller
*/
class PhotoListViewController:UITableViewController
{
    static let ID_SEGUE = "PhotoDetailSegue"
    var dataStore: PhotoStore!
    
    private var isLoading = false
    
    @IBAction func refresh(_ sender:AnyObject?)
    {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.dataStore.loadData{success, error in
            if success {
                self.tableView.reloadData()
            } else {
                self.showAlert(title: "Error!", message: "Information: \(error?.localizedDescription ?? "Unknown error!")")
            }
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.isLoading = false
        }
    }
    
    private func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionDone = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alert.addAction(actionDone)
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.refresh(nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataStore.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.CELL_ID, for: indexPath) as! PhotoTableViewCell
        cell.indexPathRecord = indexPath
        
        let data = self.dataStore.data[indexPath.row]
        cell.labelID.text = "ID: \(data.id)"
        cell.labelTitle.text = data.title.isEmpty ? "Untitled" : data.title
        cell.labelDate.text = data.dateTaken
        
        self.dataStore.loadImage(item: data, type: .Profile) { image in
            if cell.indexPathRecord.row == indexPath.row {
                cell.updateImage(image ?? UIImage(named: DEFAULT_IMAGE_NAME))
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == PhotoListViewController.ID_SEGUE {
            let photoDetailController = segue.destination as! PhotoDetailViewController
            photoDetailController.dataStore = self.dataStore
            if let selectedIndex = self.tableView.indexPathForSelectedRow {
                photoDetailController.photo = self.dataStore.data[selectedIndex.row]
            }
        }
    }
}
