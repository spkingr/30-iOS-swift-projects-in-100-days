//
//  ViewController.swift
//  ProjectKeychain
//
//  Created by 刘庆文 on 5-3.
//  Copyright © 2018 Liuqingwens. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, ShowAlert
{
    @IBOutlet weak var textEmail:UITextField!
    @IBOutlet weak var textPassword:UITextField!
    
    private enum TextFieldID:Int
    {
        case email = 1
        case password = 2
    }
    
    private static let SEGUE_SIGN_IN = "SegueSignIn"
    
    func signIn()
    {
        self.view.endEditing(true)
    
        guard let email = self.textEmail.text,
              email.contains("@"),
              email[email.index(of: "@")!...].contains(".") else {
            self.showAlert(title: "Error", content: "Email is invalid!")
            return
        }
    
        guard let password = self.textPassword.text, password.count > 0 else {
            self.showAlert(title: "Error", content: "Password cannot be empty!")
            return
        }
        
        do {
            try AuthControl.signIn(email: email, password: password)
        } catch {
            return
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        self.signIn()
        
        if identifier == SignInViewController.SEGUE_SIGN_IN {
            return AuthControl.isSignIn
        }
        return true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.textEmail.tag = SignInViewController.TextFieldID.email.rawValue
        self.textEmail.delegate = self
        self.textPassword.tag = SignInViewController.TextFieldID.password.rawValue
        self.textPassword.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = true
        
        if let (email, password) = AuthControl.getEmailPassword() {
            self.textEmail.text = email
            self.textPassword.text = password
        } else {
            self.textEmail.text = nil
            self.textPassword.text = nil
        }
        
        super.viewWillAppear(animated)
    }
    
    @IBAction func endEdit(_ sender: AnyObject?)
    {
        self.view.endEditing(true)
    }
}

extension SignInViewController:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        guard let text = textField.text, text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0  else{
            return false
        }
        
        switch textField.tag {
            case SignInViewController.TextFieldID.email.rawValue:
                self.textPassword.becomeFirstResponder()
            case SignInViewController.TextFieldID.password.rawValue:
                self.signIn()
                if AuthControl.isSignIn {
                    self.performSegue(withIdentifier: SignInViewController.SEGUE_SIGN_IN, sender: self)
                }
            default:
                return false
        }
        
        return true
    }
}

protocol ShowAlert
{
    func showAlert(title:String, content:String)
}

extension ShowAlert where Self : UIViewController
{
    func showAlert(title: String, content: String)
    {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alert.addAction(doneAction)
        self.present(alert, animated: true)
    }
}