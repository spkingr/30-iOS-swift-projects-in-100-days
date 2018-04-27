//
//  ViewController.swift
//  ProjectCocoaPods
//
//  Created by 刘庆文 on 4-27.
//  Copyright © 2018 Liuqingwens. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController
{
    @IBOutlet weak var sliderTime:UISlider!
    private var time:Double {
        return Double(self.sliderTime.value)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func onLoad()
    {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
        
        DispatchQueue.global(qos: .userInitiated).async{
            
            Thread.sleep(forTimeInterval: self.time)
            
            DispatchQueue.main.async{
                hud.hide(animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
