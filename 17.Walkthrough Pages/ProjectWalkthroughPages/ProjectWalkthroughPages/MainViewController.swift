//
//  ViewController.swift
//  ProjectWalkthroughPages
//
//  Created by 刘庆文 on 2-6.
//  Copyright © 2018 Liuqingwens. All rights reserved.
//

import UIKit


class MainViewController: UIViewController
{
    static let KEY_HAS_WALK_THROUGH = "hasWalkThrough"
    
    @IBOutlet weak var labelInfo:UILabel!
    @IBOutlet weak var buttonClear:UIButton!
    @IBOutlet weak var constraintButtonClear:NSLayoutConstraint!
    @IBOutlet weak var constraintLabelInfo:NSLayoutConstraint!
    
    private var isWalkThroughPageDone = false
    private var pageData:[PageData] = {
        var pageData = [PageData]()
        pageData.append(PageData(title: "iOS 7 (September 2013)", image: "ios7", info: "The world, once more, is flat: iOS 7 marks the most extensive design change in the history of the platform. With a flat, simplistic, and colorful redesign, Jony Ive took command of the design on iOS, too."))
        pageData.append(PageData(title: "iOS 8 (September 2014)", image: "ios8", info: "Once again, Apple brought its desktop and mobile platforms closer together: the Continuity concept made it possible to read and write iMessages or answer phone calls on your iPhone and your Mac. All in all, iOS 8 focused heavily on making the platform more extensible and open: third-party apps could now add their own Notification Center Widgets and more easily access the photo library."))
        pageData.append(PageData(title: "iOS 9 (September 2015)", image: "ios9", info: "Proactivity is a core topic in iOS 9: the system is now more aware of contextual information like time or location. Suggesting the right apps, websites, music and news stories are all examples of iOS trying to better predict its users' needs."))
        pageData.append(PageData(title: "iOS 10 (September 2016)", image: "ios10", info: "iOS 10 promoted iMessage to more than just a simple app: Stickers and a separate App Store transform it into a full-blown platform, wide open to third-party developers.Speaking of opening iOS to developers, Siri can now interact with non-Apple apps from the App Store and the new Home app lets you control your smart home."))
        pageData.append(PageData(title: "iOS 11 (September 2017)", image: "ios11", info: "Along with iOS 11 came a rework of the App Store: a new design and regular editorial content should help users find apps more easily. iOS 11 came with lots of improvements like a customizable Control Center, the Quick Type keyboard, and new features for the Photos app."))
        return pageData
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.isWalkThroughPageDone = UserDefaults.standard.bool(forKey: MainViewController.KEY_HAS_WALK_THROUGH)
        self.labelInfo.text = self.isWalkThroughPageDone ? "You are always here!" : "At last, you are here."
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    
        if self.isWalkThroughPageDone {
            self.constraintButtonClear.constant = -self.view.bounds.width
            self.constraintLabelInfo.constant = self.view.bounds.width
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if self.isWalkThroughPageDone {
            self.buttonClear.layer.cornerRadius = 4
            self.buttonClear.center.x -= self.view.bounds.width
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: {
                self.constraintButtonClear.constant = 0
                self.constraintLabelInfo.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            return
        }
        
        self.isWalkThroughPageDone = true
        if let walkThroughPageViewController = self.storyboard?.instantiateViewController(withIdentifier: PageViewController.STORYBOARD_ID) as? PageViewController {
            walkThroughPageViewController.pageData = self.pageData
            self.present(walkThroughPageViewController, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClearHistoryAction(_ sender: AnyObject?)
    {
        UserDefaults.standard.removeObject(forKey: MainViewController.KEY_HAS_WALK_THROUGH)
        let alert = UIAlertController(title: nil, message: "The data is removed, restart app to find all.", preferredStyle: .actionSheet)
        let doneAction = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alert.addAction(doneAction)
        self.present(alert, animated: true)
    }
}
