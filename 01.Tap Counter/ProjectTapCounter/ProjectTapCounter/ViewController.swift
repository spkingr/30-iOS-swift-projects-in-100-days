//
//  ViewController.swift
//  ProjectTapCounter
//
//  Created by 刘庆文 on 8-17.
//  Copyright © 2017 Liuqingwen. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{
    //@IBOutlet private weak var buttonReset: UIBarButtonItem!
    //@IBOutlet private weak var buttonTap: UIButton!
    @IBOutlet private weak var labelCounter: UILabel!
    
    private var counter = 0
    
    @IBAction private func onResetClick()
    {
        self.counter = 0
        self.labelCounter.text = "0"
    }
    
    @IBAction private func onTapClick()
    {
        self.counter += 1
        self.labelCounter.text = "\(self.counter)"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
