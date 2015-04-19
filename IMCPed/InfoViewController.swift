//
//  InfoViewController.swift
//  IMCPed
//
//  Created by Douglas Mandarino on 4/18/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    
    
    @IBOutlet weak var ruleImage: UIImageView!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    
    let blueColor = UIColor(red: 1/255, green:176/255, blue: 240/255, alpha: 0)
    let pinkColor = UIColor(red: 255/255, green:53/255, blue: 139/255, alpha: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBars()
    }
    
    private func customizeBars() {
        
        var nav = navigationController?.navigationBar
        
        let swiftColor = UIColor(red: 0/255, green:204/255, blue: 51/255, alpha: 0)
        nav!.barTintColor = swiftColor
        self.navigationController?.navigationBarHidden = false
        
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
}