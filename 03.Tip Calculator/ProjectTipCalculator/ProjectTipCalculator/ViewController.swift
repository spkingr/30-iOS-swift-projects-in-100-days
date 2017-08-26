//
//  ViewController.swift
//  ProjectTipCalculator
//
//  Created by 刘庆文 on 8-23.
//  Copyright © 2017 Liuqingwen. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{
    private var value = 0.0 {
        didSet {
            if(self.value == 0.0)
            {
                self.textPay.text = nil
            }else
            {
                self.textPay.text = "$\(self.value.format(".2"))"
            }
            self.refreshCalculator()
        }
    }
    
    private func refreshCalculator()
    {
        let tip = self.value * Double(self.percent) / 100.0
        let total = self.value + tip
        self.labelTip.text = "$\(tip.format(".2"))"
        self.labelTotal.text = "$\(total.format(".2"))"
    }
    
    private var percent:Int {
        get {
            let roundedV = self.sliderTip.value.rounded()
            return Int(roundedV)
        }
    }
    
    @IBOutlet private weak var textPay:UITextField! {
        didSet {
            self.textPay.delegate = self
        }
    }
    @IBOutlet private weak var labelTipPercent:UILabel!
    @IBOutlet private weak var labelTip:UILabel!
    @IBOutlet private weak var labelTotal:UILabel!
    @IBOutlet weak var sliderTip:UISlider! //should not be private for extension functions
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        let numberToolBar = UIToolbar()
        numberToolBar.barStyle = .default
        numberToolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            , UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(ViewController.onKeyboardDone))]
        numberToolBar.sizeToFit()
        self.textPay.inputAccessoryView = numberToolBar
    }
    
    func onKeyboardDone()
    {
        if let text = self.textPay.text {
            if(!text.isEmpty)
            {
                if let value = Double(text) {
                    self.value = value
                }else {
                    self.value = 0.0
                }
            }else
            {
                self.value = 0.0
            }
        }
        self.textPay.resignFirstResponder()
        
        self.sliderTip.isEnabled = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction private func onSliderValueChange(_ sender: UISlider)
    {
        self.labelTipPercent.text = "Tip (\(self.percent)%)"
        self.refreshCalculator()
    }
}

extension ViewController:UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.text = ""
        self.sliderTip.isEnabled = false
    }
}

extension Double
{
    func format(_ format:String)->String
    {
        return String(format: "%\(format)f", self) //f for double, d for integer
    }
}
