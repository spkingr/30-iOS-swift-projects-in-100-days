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
                    self.dataListDesc.append("App: \(text) has no description added yet.")
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
    private var dataListDesc = ["Gmail is an easy to use email app that saves you time and keeps your messages safe. Get your messages instantly via push notifications, read and respond online & offline, and find any message quickly.",
                                "Facebook Mentions is currently only available to verified public figures. To gain access to Mentions, visit http://facebook.com/mentions.",
                                "From breaking news and entertainment to sports, politics, and everyday interests, when it happens in the world, it happens on Twitter first. See all sides of the story. Join the conversation. Watch live streaming events. Twitter is what’s happening in the world and what people are talking about right now.",
                                "Get the official YouTube app for Android phones and tablets. See what the world is watching -- from the hottest music videos to what’s trending in gaming, entertainment, news, and more. Subscribe to channels you love, share with friends, and watch on any device.",
                                "Pure instant messaging — simple, fast, secure, and synced across all your devices. Over 100 million active users in two and a half years.",
                                "Going somewhere? Go with Maps, the official app you can rely on for real-time GPS navigation, traffic, transit, and details about millions of places, such as reviews and popular times.",
                                "WhatsApp Messenger is a FREE messaging app available for Android and other smartphones. WhatsApp uses your phone's Internet connection (4G/3G/2G/EDGE or Wi-Fi, as available) to let you message and call friends and family. Switch from SMS to WhatsApp to send and receive messages, calls, photos, videos, documents, and Voice Messages.",
                                "Unforgettable trips start with Airbnb. Find adventures in faraway places or your hometown, and access unique homes, experiences, and places around the world. Book everything your trip needs, or start earning money as a host. ",
                                "Messenger will help you to open your favourite messenger apps like Facebook, Twitter, Viber, Whatsapp, Hangouts and much more. With Messenger App, you have access to a world of chat and communication. No more searching for messenger apps. Get notifications about new apps for you.",
                                "All Talking Tom wants to do is get a glimpse of the beautiful Talking Angela! Help Tom out by giving him the words he needs to woo her. Tom will repeat whatever you say. He'll even sing! He might need your help picking out presents to give her too. Are you ready to play Cupid?"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.CELL_NAME, for: indexPath) as! CustomTableCell
        cell.labelApp.text = self.dataList[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [ UITableViewRowAction ]?
    {
        let actionDelete = UITableViewRowAction(style: .destructive, title: "Delete", handler: { action, index in
            let alert = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: .alert)
            let actionDone = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.dataList.remove(at: index.row)
                self.dataListDesc.remove(at: index.row)
                self.tableView.reloadData()
            })
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(actionDone)
            alert.addAction(actionCancel)
            self.present(alert, animated: true)
        })
        let actionEdit = UITableViewRowAction(style: .normal, title: "Edit", handler: { action, index in
            let alert = UIAlertController(title: "Edit", message: "Edit the app name", preferredStyle: .alert)
            alert.addTextField(configurationHandler: {textField in
                textField.text = self.dataList[index.row]
            })
            let actionDone = UIAlertAction(title: "OK", style: .default, handler: {_ in
                if let text = alert.textFields?.first?.text {
                    if(!text.isEmpty && text != self.dataList[index.row])
                    {
                        self.dataList[index.row] = text
                        self.tableView.reloadData()
                    }
                }
            })
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(actionDone)
            alert.addAction(actionCancel)
            self.present(alert, animated: true)
        })
        return [actionDelete, actionEdit]
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        if (segue.identifier == "detailSegue")
        {
            guard let index = self.tableView.indexPathForSelectedRow?.row else {
                return
            }
            let detailView = segue.destination as? DetailViewController
            detailView?.appName = self.dataList[index]
            detailView?.appDesc = self.dataListDesc[index]
        }
    }
}
