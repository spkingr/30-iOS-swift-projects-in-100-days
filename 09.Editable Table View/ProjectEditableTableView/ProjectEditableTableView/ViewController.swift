//
//  ViewController.swift
//  ProjectEditableTableView
//
//  Created by 刘庆文 on 12-19.
//  Copyright © 2017 Liuqingwen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell
{
    public static let CELL_ID = "Cell"
    
    @IBOutlet weak var labelTitle: UILabel!
}

class ViewController: UITableViewController
{
    private var dataList = [ "Google Mail", "Facebook", "Twitter", "Youtube",
                             "Telegram", "Google Maps", "WhatsApp", "Airbnb",
                             "Messenger", "Talking Tom" ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Editable Table View"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        if (self.dataList.count <= 0) {
            let emptyContent = UILabel()
            emptyContent.text = "No data is presented now, try it later!"
            emptyContent.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            emptyContent.numberOfLines = 0
            emptyContent.textAlignment = .center
            emptyContent.textColor = UIColor.red
            
            tableView.backgroundView = emptyContent
            tableView.separatorStyle = .none
            
            return 0
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [ UITableViewRowAction ]?
    {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: {action, indexPath in
            let origin = self.dataList[indexPath.row]
            let alert = UIAlertController(title: "Edit", message: "Origin: \(origin)", preferredStyle: .alert)
            alert.addTextField(configurationHandler: {textfield in
                textfield.text = origin
            })
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in
                if let text = alert.textFields?.first?.text {
                    if (!text.isEmpty && text != origin)
                    {
                        self.dataList[indexPath.row] = text
                        self.tableView.reloadData()
                    }
                }
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
    
            self.present(alert, animated: true)
        })
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: {action, indexPath in
            self.dataList.remove(at: indexPath.row)
            self.tableView.reloadData()
    
            if (self.dataList.count <= 0 && self.navigationItem.leftBarButtonItem?.title == "Done")
            {
                self.navigationItem.leftBarButtonItem?.title = "Edit"
            }
        })
        
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.CELL_ID, for: indexPath) as! TableViewCell
        cell.labelTitle.text = self.dataList[ indexPath.row ]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let item = self.dataList.remove(at: sourceIndexPath.row)
        self.dataList.insert(item, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return self.dataList.count > 0
    }
    
    @IBAction private func onEditClickHandler(_ sender: UIBarButtonItem)
    {
        if (self.dataList.count <= 0)
        {
            return
        }
        
        if (sender.title == "Edit")
        {
            sender.title = "Done"
            //self.tableView.isEditing = true
            self.tableView.setEditing(true, animated: true)
        } else {
            sender.title = "Edit"
            //self.tableView.isEditing = false
            self.tableView.setEditing(false, animated: true)
        }
    }
    
    @IBAction private func onAddClickHandler(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add", message: "Add a new one?", preferredStyle: .alert)
        alert.addTextField()
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in
            if let text = alert.textFields?.first?.text {
                if (!text.isEmpty)
                {
                    self.dataList.append(text)
                    self.tableView.reloadData()
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
