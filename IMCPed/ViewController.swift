//
//  ViewController.swift
//  IMCPed
//
//  Created by Douglas Mandarino on 4/18/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var ruleImage: UIImageView!
    @IBOutlet weak var scaleImage: UIImageView!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var babyImage: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    var age:Int = 2;
    
    var isBoy:Bool = true
    var imc:Float = 00.00

    let blueColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
    let pinkColor = UIColor(red: 204/255, green: 0/255, blue: 153/255, alpha: 1)
    
    let agePickerValues = [NSLocalizedString("2 years", comment: "2 years"), NSLocalizedString("3 years", comment: "3 years"),NSLocalizedString("4 years", comment: "4 years"),NSLocalizedString("5 years", comment: "5 years"),NSLocalizedString("6 years", comment: "6 years"),NSLocalizedString("7 years", comment: "7 years"),NSLocalizedString("8 years", comment: "8 years"),NSLocalizedString("9 years", comment: "9 years"),NSLocalizedString("10 years", comment: "10 years"),NSLocalizedString("11 years", comment: "11 years"),NSLocalizedString("12 years", comment: "12 years"),NSLocalizedString("13 years", comment: "13 years"),NSLocalizedString("14 years", comment: "14 years"),NSLocalizedString("15 years", comment: "15 years")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        height.delegate = self
        weight.delegate = self
        agePicker.delegate = self
        
        agePicker.transform = CGAffineTransformMakeScale(0.7, 0.6);
        
        
        self.title = NSLocalizedString("title", comment: "title")
        titlePage.font = UIFont(name: "Noteworthy-Light", size: 22)
        titlePage.text = NSLocalizedString("boy", comment: "boy")
        println(titlePage.text)
        customizeBars()
    }
    
    override func viewWillAppear(animated: Bool) {
        Kid.sharedInstance.isBoy = self.isBoy
        Kid.sharedInstance.IMC = 0
        Kid.sharedInstance.age = 2
        Kid.sharedInstance.height = 0
        adjustViewLayout(UIScreen.mainScreen().bounds.size)
    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        adjustViewLayout(size)
    }
    func adjustViewLayout(size: CGSize) {
        println("height: \(size.height), width: \(size.width)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return agePickerValues.count
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 65.0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return agePickerValues[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        var strings = split(agePickerValues[row]) {$0 == " "}
        age = strings[0].toInt()!
        
        if row >= 1 && row < 3{
            babyImage.image = UIImage(named:"baby2")
            if !isBoy {
                babyImage.image = UIImage(named:"baby2-girl")
            }
        } else if row >= 3 && row < 10 {
            babyImage.image = UIImage(named:"kid")
            if !isBoy {
                babyImage.image = UIImage(named:"kid-girl")
            }
        } else if row >= 10 {
            babyImage.image = UIImage(named:"teen")
            if !isBoy {
                babyImage.image = UIImage(named:"teen-girl")
            }
        } else {
            babyImage.image = UIImage(named:"baby1")
            if !isBoy {
                babyImage.image = UIImage(named:"baby1-girl")
            }
        }
        view.addSubview(babyImage)
        self.view.endEditing(true)
    }

    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = agePickerValues[row]
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Noteworthy-Light", size: 6.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        return myTitle
    }
    
    @IBAction func girlButton(sender: AnyObject) {
        ruleImage.image = UIImage(named:"heightGirl-01")
        scaleImage.image = UIImage(named:"weightGirl-01")
        view.addSubview(ruleImage)
        view.addSubview(scaleImage)
        
        if age > 2 && age < 5{
            babyImage.image = UIImage(named:"baby2-girl")
        } else if age >= 5 && age < 12 {
            babyImage.image = UIImage(named:"kid-girl")
        } else if age >= 12 {
            babyImage.image = UIImage(named:"teen-girl")
        } else {
            babyImage.image = UIImage(named:"baby1-girl")
        }

        view.addSubview(babyImage)
        titlePage.text = NSLocalizedString("girl", comment: "girl")

        titlePage.textColor = pinkColor
        isBoy = false
    }

    @IBAction func boyButton(sender: AnyObject) {
        ruleImage.image = UIImage(named:"heightBoy-01")
        scaleImage.image = UIImage(named:"weightBoy-01")
        view.addSubview(ruleImage)
        view.addSubview(scaleImage)
        
        titlePage.text = age.description
        
        if age > 2 && age < 5{
            babyImage.image = UIImage(named:"baby2")
        } else if age >= 5 && age < 12 {
            babyImage.image = UIImage(named:"kid")
        } else if age >= 12 {
            babyImage.image = UIImage(named:"teen")
        } else {
            babyImage.image = UIImage(named:"baby1")
        }

        view.addSubview(babyImage)
        titlePage.text = NSLocalizedString("boy", comment: "boy")
        titlePage.textColor = blueColor
        isBoy = true
    }
    
    @IBAction func calculate(sender: AnyObject) {
        if height.text != "" && weight.text != "" {
            var h:Float = (height.text as NSString).floatValue/100
            var w:Float = (weight.text as NSString).floatValue
                        
            imc = w/(pow(h, 2))
            
            Kid.sharedInstance.IMC = imc
            Kid.sharedInstance.age = self.age
            Kid.sharedInstance.height = h
        }
        Kid.sharedInstance.isBoy = self.isBoy
        Kid.sharedInstance.age = self.age
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "ShowIMCSegue"{
            let vc = segue.destinationViewController as! GraphViewController
            vc.IMC = imc
            vc.age = age
            vc.isBoy = isBoy
            vc.height = (height.text as NSString).floatValue/100
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
        nav!.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Noteworthy-Light", size: 22)!]
        
        self.navigationController?.navigationBarHidden = false
        
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

}

