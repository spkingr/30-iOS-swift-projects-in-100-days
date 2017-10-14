//
// Created by 刘庆文 on 10-14.
// Copyright (c) 2017 Liuqingwen. All rights reserved.
//

import Foundation
import UIKit

class LabelCell:UITableViewCell
{
    public static let CELL_ID = "labelCell"
    
    @IBOutlet weak var labelLanguage:UILabel!
}

class RefreshTableViewController:UITableViewController
{
    private var dataList:[String] = []
    private var dataNew = ["Javascript", "Python", "Java", "Ruby", "PHP",
                           "C++", "CSS", "C#", "GO", "C", "Typescript",
                           "Shell", "Swift", "Scala", "Object-C", "Kotlin!!!"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Pull to Refresh"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addData(_:)))
        
        let refresh = UIRefreshControl()
        refresh.backgroundColor = UIColor.gray
        refresh.tintColor = UIColor.white
        refresh.attributedTitle = NSAttributedString(string: "Fetching data, waiting...", attributes: nil)
        refresh.addTarget(self, action: #selector(loadData(_:)), for: .valueChanged)
        self.refreshControl = refresh
        //self.tableView.backgroundView = refresh
    }
    
    @objc func addData(_ sender:Any?)
    {
        let alert = UIAlertController(title: "Add", message: "Add new one", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {textField in
            textField.placeholder = "Add..."
        })
        
        let actionDone = UIAlertAction(title: "Add", style: .default, handler: {_ in
            if let text = alert.textFields?.first?.text {
                if(!text.isEmpty) {
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
    
    @objc func loadData(_ refreshControl:UIRefreshControl)
    {
        print("Loading...")
        
        let count = arc4random_uniform((UInt32)(self.dataNew.count + 1))
        for _ in 0..<count {
            self.dataList.append(self.dataNew.remove(at: 0))
        }
        refreshControl.endRefreshing()
        
        self.tableView.reloadData()
    
        /*let alert = UIAlertController(title: "Result", message: count == 0 ? "No data added!" : "\(count) item(s) added!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(action)
        if let v = UIApplication.shared.keyWindow?.rootViewController {
            v.present(alert, animated: true)
        }*/
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        if self.dataList.count == 0 {
            let emptyView = UILabel()
            emptyView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            emptyView.numberOfLines = 0
            emptyView.textAlignment = .center
            emptyView.textColor = UIColor.red
            emptyView.text = "No data is available, please pull to refresh!"
            tableView.backgroundView = emptyView
            tableView.separatorStyle = .none
            return 0
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: LabelCell.CELL_ID, for: indexPath) as! LabelCell
        let language = self.dataList[indexPath.row]
        cell.labelLanguage.text = language
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}