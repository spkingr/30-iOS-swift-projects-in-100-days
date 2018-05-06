//
// Created by 刘庆文 on 5-3.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import UIKit

class MainViewController:UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.topItem?.backBarButtonItem?.title = "Sign Out"
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
        
        super.viewWillAppear(animated)
    }
    
    @IBAction func signOut(_ sender: AnyObject?)
    {
        AuthControl.signOut()
        
        self.backToSignInView()
    }
    
    private func backToSignInView()
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
}