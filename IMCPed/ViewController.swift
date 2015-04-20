//
//  ViewController.swift
//  IMCPed
//
//  Created by Douglas Mandarino on 4/18/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var ruleImage: UIImageView!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var titlePage: UILabel!
    
    var isBoy:Bool = true
    var imc:Float = 00.00

    let blueColor = UIColor(red: 1/255, green:176/255, blue: 240/255, alpha: 0)
    let pinkColor = UIColor(red: 255/255, green:53/255, blue: 139/255, alpha: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        
        height.delegate = self
        weight.delegate = self
        
        titlePage.font = UIFont(name: "Noteworthy-Light", size: 22)
        customizeBars()
        configureDefaultSlider()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func girlButton(sender: AnyObject) {
        ruleImage.image = UIImage(named: "ruleF")
        view.addSubview(ruleImage)
        
        titlePage.text = "É uma menina!"
        titlePage.textColor = UIColor.magentaColor()
        isBoy = false
    }

    @IBAction func boyButton(sender: AnyObject) {
        ruleImage.image = UIImage(named:"ruleM")
        view.addSubview(ruleImage)
    
        titlePage.text = "É um menino!"
        titlePage.textColor = UIColor.blueColor()
        isBoy = true

    }
    
    func configureDefaultSlider() {
        slider.minimumValue = 2
        slider.maximumValue = 15
        slider.value = 8.0
        slider.continuous = true
        
    }
    
    @IBAction func setKidAge(sender: AnyObject) {
        let sliderInt = Int(slider.value)
//        var result:Float = Float(sliderInt)
//        
//        if (slider.value - result) >= 0.5 {
//           result += 1
//        }
//        
//        age.text = "\(result)"
        age.text = "\(sliderInt)"
    }
    
    @IBAction func calculate(sender: AnyObject) {
        if height.text != "" && weight.text != "" {
            var h:Float = (height.text as NSString).floatValue/100
            var w:Float = (weight.text as NSString).floatValue
                        
            imc = w/(pow(h, 2))
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowIMCSegue" {
            if let destinationVC = segue.destinationViewController as? ChartViewController{
                destinationVC.IMC = imc
                destinationVC.age = NSString(string: age.text!).integerValue
                destinationVC.isBoy = isBoy
                destinationVC.height = (height.text as NSString).floatValue/100
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    private func customizeBars() {
       
        var nav = navigationController?.navigationBar
        
        let swiftColor = UIColor(red: 0/255, green:204/255, blue: 51/255, alpha: 0)
        nav!.barTintColor = swiftColor
        self.navigationController?.navigationBarHidden = false
        
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

}

