
import UIKit
import QuartzCore

class ChartViewController: UIViewController, LineChartDelegate {

    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imcLabel: UILabel!
    
//    var label = UILabel()
    var lineChart: LineChart!
    
    var IMC:Float!
    var age:Int!
    var isBoy:Bool!
    var height:Float!
    
    let iMCValues = IMCValues()
    let nf = NSNumberFormatter()
    
    var list = [Value]()
    var l2 = [Value]()
    var sList = [CGFloat]()
    var ovList = [CGFloat]()
    var obList = [CGFloat]()
    var ageList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()

        label.font = UIFont(name: "Noteworthy-Light", size: 22)
        resultLabel.font = UIFont(name: "Noteworthy-Light", size: 22)
        messageLabel.font = UIFont(name: "Noteworthy-Light", size: 22)
        imcLabel.font = UIFont(name: "Noteworthy-Light", size: 22)

        nf.numberStyle = NSNumberFormatterStyle.DecimalStyle
        nf.maximumFractionDigits = 2
        
        resultLabel.text = "\(nf.stringFromNumber(IMC)!)"
        
        IMC = NSString(string: nf.stringFromNumber(IMC)!).floatValue
        
        showIMCResult()
        
        var views: [String: AnyObject] = [:]
        
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)
        views["label"] = label
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label]-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[label]", options: nil, metrics: nil, views: views))
        
        // simple arrays
        if isBoy == true {
            list = iMCValues.getBoyList()
        } else {
            list = iMCValues.getGirlList()
        }
        
        for (var i = 0 ; i < list.count/2 ; i+=2) {
            l2.append(list[i])
        }
        
        for l in l2 {
            sList.append(CGFloat(l.standard))
            ovList.append(CGFloat(l.overweight))
            obList.append(CGFloat(l.obese))
            ageList.append(Int(l.age).description)
        }
        
        var data = sList
        var data2 = ovList
        var data3 = obList
        
        // simple line with custom x axis labels
//        var xLabels = ageList
        var xLabels = ["6", "8", "10", "12", "14"]
        
        lineChart = LineChart()
        lineChart.animation.enabled = true
        lineChart.area = true
        lineChart.x.labels.visible = true
        lineChart.x.grid.count = 10
        lineChart.y.grid.count = 10
        lineChart.x.labels.values = xLabels
        lineChart.y.labels.visible = true
        lineChart.addLine(data)
        lineChart.addLine(data2)
        lineChart.addLine(data3)
        
        lineChart.setTranslatesAutoresizingMaskIntoConstraints(false)
        lineChart.delegate = self
        self.view.addSubview(lineChart)
        views["chart"] = lineChart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[chart]-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[label]-[chart(==200)]", options: nil, metrics: nil, views: views))
        
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
                
                var max = v.overweight * pow(height, 2)
                let num = NSNumberFormatter()
                num.numberStyle = NSNumberFormatterStyle.DecimalStyle
                num.maximumFractionDigits = 2
                
                max = NSString(string: nf.stringFromNumber(max)!).floatValue
                
                if IMC > v.overweight {
                    messageLabel.text = "Acima do Peso\nIMC ideal = \(v.standard)\nPeso ideal até = \(max) Kg"
                    messageLabel.textColor = UIColor.orangeColor  ()
                }
                if IMC > v.obese {
                    messageLabel.text = "Obesidade\nIMC ideal = \(v.standard)\nPeso ideal até = \(max) Kg"
                    messageLabel.textColor = UIColor.redColor()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    /**
     * Line chart delegate method.
     */
    func didSelectDataPoint(x: CGFloat, yValues: Array<CGFloat>) {
    
    }
    
}
