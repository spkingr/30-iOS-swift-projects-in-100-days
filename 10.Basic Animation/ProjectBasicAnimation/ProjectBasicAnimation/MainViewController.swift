//
// Created by 刘庆文 on 12-20.
// Copyright (c) 2017 Liuqingwen. All rights reserved.
//

import Foundation
import UIKit

class MainViewController:UIViewController
{
    public var username:String = ""
    
    @IBOutlet weak var labelName:UILabel!
    @IBOutlet weak var labelWelcome:UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.labelName.text = "Hi, \(self.username)"
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    
        self.labelName.alpha = 0.0
        self.labelWelcome.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.labelName.center.x += self.view.bounds.width
        self.labelWelcome.center.x -= self.view.bounds.width
        
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: [], animations: {
            self.labelName.alpha = 1.0
            self.labelWelcome.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn], animations: {
            self.labelName.center.x -= self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.curveEaseOut], animations: {
            self.labelWelcome.center.x += self.view.bounds.width
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}