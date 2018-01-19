//
//  ViewController.swift
//  ProjectPureCodeApp
//
//  Created by 刘庆文 on 1-18.
//  Copyright © 2018 Liuqingwen. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell
{
    static let ID = "MyTableViewCell"
    var labelTitle: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initCell()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) is not implemented here!")
    }
    
    private func initCell()
    {
        self.labelTitle = UILabel()
        self.labelTitle.numberOfLines = 1
        self.labelTitle.textColor = .blue
        self.labelTitle.font = UIFont.systemFont(ofSize: 16)
        self.labelTitle.text = "Cell"
        self.labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.labelTitle)
        
        var constrain = self.labelTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        constrain.isActive = true
        constrain = self.labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
        constrain.isActive = true
        /*constrain = self.labelTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        constrain.isActive = true
        constrain = self.labelTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8)
        constrain.isActive = true*/
    }
}

class MyViewController: UITableViewController
{
    private var dataList = [ "Google Mail", "Facebook", "Twitter", "Youtube",
                             "Telegram", "Google Maps", "WhatsApp", "Airbnb",
                             "Messenger", "Talking Tom" ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Pure Code"
        
        self.tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.ID)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.ID, for: indexPath) as! MyTableViewCell
        cell.labelTitle.text = self.dataList[ indexPath.row ]
        return cell
    }
}
