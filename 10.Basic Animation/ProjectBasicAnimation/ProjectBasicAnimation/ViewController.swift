//
//  ViewController.swift
//  ProjectBasicAnimation
//
//  Created by 刘庆文 on 12-20.
//  Copyright © 2017 Liuqingwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var labelHeading:UILabel!
    @IBOutlet weak var labelTip:UILabel!
    @IBOutlet weak var textUsername:UITextField!
    @IBOutlet weak var textPassword:UITextField!
    @IBOutlet weak var buttonLogin:UIButton!
    
    private var username:String {
        get {
            return self.textUsername.text!
        }
    }
    private var password:String {
        get {
            return self.textPassword.text!
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.labelTip.alpha = 0.0
        self.buttonLogin.layer.cornerRadius = 6.0
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        self.labelHeading.alpha = 0.0
        self.textUsername.alpha = 0.0
        self.textPassword.alpha = 0.0
        self.buttonLogin.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.labelHeading.center.y -= self.view.bounds.width
        self.textUsername.center.x -= self.view.bounds.width
        self.textPassword.center.x += self.view.bounds.width
    
        self.labelHeading.alpha = 1.0
        self.textUsername.alpha = 1.0
        self.textPassword.alpha = 1.0
        
        super.viewDidAppear(animated)
    
        UIView.animate(withDuration: 1.5, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.labelHeading.center.y += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, animations: {
            self.textUsername.center.x += self.view.bounds.width
            self.textPassword.center.x -= self.view.bounds.width
        }, completion: { _ in
            self.textUsername.becomeFirstResponder()
        })
        UIView.animate(withDuration: 1.0, delay: 1.5, options: [], animations: {
            self.buttonLogin.alpha = 1.0
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        //important!!!
        self.view.endEditing(true)
        
        if identifier == "SegueToMain" {
            if self.username.isEmpty || self.password != "abc123" {
                self.labelTip.alpha = 1.0
                UIView.animate(withDuration: 0.5, delay: 2.0, animations: {
                    self.labelTip.alpha = 0.0
                })
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "SegueToMain" {
            let mainView = segue.destination as! MainViewController
            mainView.username = self.username
        }
    
        super.prepare(for: segue, sender: sender)
    }
}
