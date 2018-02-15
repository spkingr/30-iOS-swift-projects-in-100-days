//
// Created by 刘庆文 on 2-11.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import UIKit

class TextViewController:UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var labelHeader:UILabel!
    @IBOutlet weak var labelTyped:UILabel!
    @IBOutlet weak var textInput:UITextField!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        self.labelTyped.text?.append(string)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if self.textInput.isFirstResponder {
            self.textInput.resignFirstResponder()
        }
        return true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(onViewTapHandler))
        self.view.addGestureRecognizer(gestureTap)
        
        self.textInput.delegate = self
    }
    
    @objc func onViewTapHandler(_ sender:AnyObject?)
    {
        self.view.endEditing(false)
        if self.textInput.isFirstResponder {
            self.textInput.resignFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if self.textInput.isFirstResponder {
            self.textInput.resignFirstResponder()
        }
        self.textInput.text = nil
        self.labelHeader.alpha = 0
        self.labelTyped.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [.curveEaseInOut],animations: {
            self.labelHeader.alpha = 1.0
            self.labelTyped.alpha = 1.0
        }, completion: nil)
    }
}
