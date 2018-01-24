//
//  JsonTableViewController.swift
//  ProjectJsonDataTable
//
//  Created by 刘庆文 on 1-23.
//  Copyright © 2018 Liuqingwens. All rights reserved.
//

import UIKit

class TableViewCell:UITableViewCell
{
    static let CELL_ID = "TableViewCell"
    
    @IBOutlet weak var imageProfile:UIImageView!
    @IBOutlet weak var labelID:UILabel!
    @IBOutlet weak var labelDate:UILabel!
    @IBOutlet weak var labelTitle:UILabel!
}

class JsonTableViewController:UITableViewController
{
    private var isLoading = false
    var dataStore:DataStore!
    
    @IBAction func refresh(_ sender:AnyObject?)
    {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.dataStore.loadData { result in
            switch result {
                case .Failure(let error) :
                    DispatchQueue.main.async {
                        self.navigationItem.rightBarButtonItem?.isEnabled = true
                        self.showAlert(title: "Error!", message: "Information: \(error)")
                    }
                    break
                case .Success(let items) :
                    self.dataStore.data.removeAll()
                    self.dataStore.data.append(contentsOf: items)
                    DispatchQueue.main.async {
                        self.navigationItem.rightBarButtonItem?.isEnabled = true
                        self.tableView.reloadData()
                    }
                    break
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.CELL_ID, for: indexPath) as! TableViewCell
        let data = self.dataStore.data[indexPath.row]
        cell.labelID.text = "ID: \(data.id)"
        cell.labelTitle.text = data.title.isEmpty ? "Untitled" : data.title
        cell.labelDate.text = data.dateTaken
        
        if let image = data.imageProfile {
            cell.imageProfile.image = image
        }else{
            self.dataStore.loadImage(item: data) {id, image in
                DispatchQueue.main.async {
                    if data.id == id {
                        cell.imageProfile.image = image
                    }
                }
            }
        }
        
        return cell
    }
}
