//
//  ViewController.swift
//  ProjectBasicTableView
//
//  Created by 刘庆文 on 9-1.
//  Copyright © 2017 Liuqingwen. All rights reserved.
//

import UIKit

class CustomTableCell:UITableViewCell
{
    @IBOutlet weak var labelApp:UILabel!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet private weak var tableView:UITableView!
    @IBAction private func onEditClickHandler(_ sender:UIBarButtonItem)
    {
        guard let index = self.tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        let alert = UIAlertController(title: "Edit", message: "Edit the app name", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {textField in
            textField.text = self.dataList[index]
        })
        let actionDone = UIAlertAction(title: "OK", style: .default, handler: {_ in
            if let text = alert.textFields?.first?.text {
                if(!text.isEmpty)
                {
                    self.dataList[index] = text
                    self.tableView.reloadData()
                }
            }
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionDone)
        alert.addAction(actionCancel)
        self.present(alert, animated: true)
    }
    @IBAction private func onAddClickHandler(_ sender:UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add", message: "Add new app name", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {textField in
            textField.placeholder = "Add new app"
        })
        let actionDone = UIAlertAction(title: "Add", style: .default, handler: {_ in
            if let text = alert.textFields?.first?.text {
                if(!text.isEmpty)
                {
                    self.dataList.append(text)
                    self.tableView.reloadData()
                }
            }
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionDone)
        alert.addAction(actionCancel)
        self.present(alert, animated: true)
    }
    
    private static let CELL_NAME = "cell"
    private var dataList = ["Google Mail", "Facebook", "Twitter", "Youtube",
                            "Telegram", "Google Maps", "WhatsApp", "Airbnb",
                            "Messenger", "Talking Tom"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.CELL_NAME, for: indexPath) as! CustomTableCell
        cell.labelApp.text = self.dataList[indexPath.row]
        return cell
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
