//
//  TableViewController.swift
//  ProjectTabBarView
//
//  Created by 刘庆文 on 2-11.
//  Copyright © 2018 Liuqingwens. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController
{
    private var dataList = [ "Google Mail", "Facebook", "Twitter", "Youtube",
                             "Telegram", "Google Maps", "WhatsApp", "Airbnb",
                             "Messenger", "Talking Tom" ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.dataList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return self.dataList.count > 0
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let item = self.dataList.remove(at: sourceIndexPath.row)
        self.dataList.insert(item, at: destinationIndexPath.row)
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
}
