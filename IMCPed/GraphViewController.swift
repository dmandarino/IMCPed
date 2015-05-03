//
//  GraphViewController.swift
//  IMCPed
//
//  Created by Douglas Mandarino on 4/29/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import Foundation

import UIKit
import QuartzCore

class GraphViewController: UIViewController {

    //Label outlets
    
    @IBOutlet weak var graphView: GraphView!
    
    var IMC:Float!
    var age:Int!
    var isBoy:Bool!
    var height:Float!
    
    let iMCValues = IMCValues()
    
    override func viewDidLoad() {
        customizeBars()
        
        graphView.isBoy = Kid.sharedInstance.isBoy!
        isBoy = Kid.sharedInstance.isBoy!
        age = Kid.sharedInstance.age
        height = Kid.sharedInstance.height
        IMC = Kid.sharedInstance.IMC
        
        println(isBoy.description)
                println(age.description)
                println(height.description)
                println(IMC.description)
        
        showIMCResult()
    }
    
    func showIMCResult() {
        var bounds: CGRect = UIScreen.mainScreen().bounds
        var width:CGFloat = bounds.size.width
        var heightScreen:CGFloat = bounds.size.height
        
        var messageLabel = UILabel(frame: CGRectMake(0, heightScreen/2 + 50, width, heightScreen/2 ))
        messageLabel.textAlignment = NSTextAlignment.Center
        messageLabel.font = UIFont(name: "Noteworthy-Light", size: 22)!
        messageLabel.tag = 5
        messageLabel.numberOfLines = 3
        
        var values = [Value]()
        if isBoy == true {
            values = iMCValues.getBoyList()
        } else {
            values = iMCValues.getGirlList()
        }
        var v = values[age-2]
        var max = v.overweight * pow(height, 2)
        
        let maxString = String(format: "%.2f", max)
        let result = "\(maxString)"
        let imcString = String(format: "%.2f", Kid.sharedInstance.IMC!)
        
        messageLabel.text = String(format: NSLocalizedString("ideal", comment: "ideal"), imcString, maxString)
        messageLabel.textColor = UIColor(red: 0/255, green:204/255, blue: 51/255, alpha: 1)
        
        if IMC > v.overweight {
            messageLabel.text =  String(format: NSLocalizedString("overweight", comment: "overweight"), imcString, maxString)
            messageLabel.textColor = UIColor.orangeColor()
        }
        if IMC > v.obese {
            messageLabel.text = String(format: NSLocalizedString("obese", comment: "obese"), imcString, maxString)
            messageLabel.textColor = UIColor.redColor()
        }
         self.view.addSubview(messageLabel);
    }
    
    private func customizeBars() {
        
        var nav = navigationController?.navigationBar
        
        let swiftColor = UIColor(red: 0/255, green:204/255, blue: 51/255, alpha: 0)
        nav!.barTintColor = swiftColor
        
        nav!.tintColor = UIColor.whiteColor()
        nav!.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Noteworthy-Light", size: 22)!]
        
        self.navigationController?.navigationBarHidden = false
        
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

}