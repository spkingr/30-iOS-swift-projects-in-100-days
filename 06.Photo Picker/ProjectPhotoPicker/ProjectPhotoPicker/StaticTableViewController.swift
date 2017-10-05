//
// Created by 刘庆文 on 10-5.
// Copyright (c) 2017 Liuqingwen. All rights reserved.
//

import Foundation
import UIKit

class StaticTableViewController : UITableViewController, UITextFieldDelegate
{
    @IBOutlet weak var imagePhoto : UIImageView!
    @IBOutlet weak var textTitle : UITextField!
    @IBOutlet weak var labelDescription : UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.textTitle.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}