//
//  ViewController.swift
//  ProjectTapHoldCounter
//
//  Created by 刘庆文 on 8-20.
//  Copyright © 2017 Liuqingwen. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{
    private var counter = 0 {
        didSet {
            self.labelCounter.text = "\(self.counter)"
        }
    }
    
    @IBOutlet private weak var labelCounter:UILabel!
    @IBOutlet private weak var buttonTap:UIButton!
    
    @IBAction private func onReset()
    {
        self.counter = 0
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.onLongPress))
        //longPressGesture.numberOfTapsRequired = 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.onTap))
        self.buttonTap.addGestureRecognizer(longPressGesture)
        self.buttonTap.addGestureRecognizer(tapGesture)
    }
    
    func onTap()
    {
        self.counter += 1
    }
    
    func onLongPress()
    {
        self.counter += 1
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
