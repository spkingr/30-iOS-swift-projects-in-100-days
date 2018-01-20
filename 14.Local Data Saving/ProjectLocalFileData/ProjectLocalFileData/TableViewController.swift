//
//  TableViewController.swift
//  ProjectLocalFileData
//
//  Created by 刘庆文 on 1-20.
//  Copyright © 2018 Liuqingwens. All rights reserved.
//

import UIKit

let ID_CELL = "Cell"
let ID_SEGUE = "ShowDetailViewSegue"

class TableViewCell:UITableViewCell
{
    @IBOutlet weak var labelName:UILabel!
    @IBOutlet weak var labelBirthday:UILabel!
    @IBOutlet weak var labelStars:UILabel!
}

class TableViewController: UITableViewController
{
    private let dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Random Items"
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return DataStore.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID_CELL, for: indexPath) as! TableViewCell
        let item = DataStore.items[indexPath.row]
        cell.labelName.text = item.name
        cell.labelBirthday.text = self.dateFormatter.string(from: item.birthday)
        cell.labelStars.text = "\(item.stars)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            DataStore.items.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == ID_SEGUE {
            let detailViewController = segue.destination as! DetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow{
                detailViewController.item = DataStore.items[ indexPath.row]
            }
        }
    }
    
    @IBAction func onActionAddNewItem(_ sender:Any)
    {
        DataStore.createNewItem()
        self.tableView.reloadData()
    }
}
