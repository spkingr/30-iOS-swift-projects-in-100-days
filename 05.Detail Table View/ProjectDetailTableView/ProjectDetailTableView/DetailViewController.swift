//
// Created by 刘庆文 on 9-2.
// Copyright (c) 2017 Liuqingwen. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController:UIViewController
{
    var appName:String? = nil
    var appDesc:String? = nil
    
    @IBOutlet weak var labelDescription:UILabel!
    @IBOutlet weak var labelAppName:UILabel!
    @IBOutlet weak var buttonLike:UIButton!
    @IBOutlet weak var buttonDislike:UIButton!
    
    private let normalColor = UIColor(colorLiteralRed: 0.8, green: 0.2, blue: 0.0, alpha: 1.0)
    private let highlightColor = UIColor(colorLiteralRed: 0.0, green: 0.8, blue: 0.2, alpha: 1.0)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = self.appName
        self.labelAppName.text = self.appName
        self.labelDescription.text = self.appDesc ?? "Nothing."
        
        self.buttonLike.backgroundColor = self.highlightColor
        self.buttonDislike.backgroundColor = self.normalColor
    }
    
    @IBAction private func onButtonClick(_ sender:UIButton)
    {
        if sender == self.buttonLike {
            self.buttonLike.backgroundColor = self.highlightColor
            self.buttonDislike.backgroundColor = self.normalColor
        }else{
            self.buttonLike.backgroundColor = self.normalColor
            self.buttonDislike.backgroundColor = self.highlightColor
        }
    }
}