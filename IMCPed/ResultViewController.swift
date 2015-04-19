//
//  ResultViewController.swift
//  IMCPed
//
//  Created by Douglas Mandarino on 4/19/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var result:Float!
    var age:Float!
    var isBoy:Bool!
    
    let iMCValues = IMCValues()
    let nf = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBars()
        
        nf.numberStyle = NSNumberFormatterStyle.DecimalStyle
        nf.maximumFractionDigits = 2
        
        println(nf.stringFromNumber(result))
        resultLabel.text = "\(nf.stringFromNumber(result)!)"
        
        result = NSString(string: nf.stringFromNumber(result)!).floatValue
        
        showIMCResult()
    }
    
    func showIMCResult() {
        var values = [Value]()
        if isBoy == true {
            values = iMCValues.getBoyList()
        } else {
            values = iMCValues.getGirlList()
        }
        for v in values {
            if v.age == self.age {
                if result > v.overweight {
                    messageLabel.text = "Acima do Peso.\nMedida ideal de \(v.standard)"
                    messageLabel.textColor = UIColor.orangeColor  ()
                }
                if result > v.obese {
                    messageLabel.text = "Obesidade.\nMedida ideal de \(v.standard)"
                    messageLabel.textColor = UIColor.redColor()
                }
            }
        }
    }
    
    private func customizeBars() {
        
        var nav = navigationController?.navigationBar
        
        let swiftColor = UIColor(red: 0/255, green:204/255, blue: 51/255, alpha: 0)
        nav!.barTintColor = swiftColor
        self.navigationController?.navigationBarHidden = false
        
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
}