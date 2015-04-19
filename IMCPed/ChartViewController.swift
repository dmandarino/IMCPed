
import UIKit
import QuartzCore

class ChartViewController: UIViewController, LineChartDelegate {

    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var label = UILabel()
    var lineChart: LineChart!
    
    var IMC:Float!
    var age:Float!
    var isBoy:Bool!
    
    let iMCValues = IMCValues()
    let nf = NSNumberFormatter()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nf.numberStyle = NSNumberFormatterStyle.DecimalStyle
        nf.maximumFractionDigits = 2
        
        println(nf.stringFromNumber(IMC))
        resultLabel.text = "\(nf.stringFromNumber(IMC)!)"
        
        IMC = NSString(string: nf.stringFromNumber(IMC)!).floatValue
        
        showIMCResult()
        
        var views: [String: AnyObject] = [:]
        
        label.text = "..."
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)
        views["label"] = label
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label]-|", options: nil, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-80-[label]", options: nil, metrics: nil, views: views))
        
        // simple arrays
        var data: [CGFloat] = [3, 4, -2, 11, 13, 15, 12, 5, 20, 23]
        var data2: [CGFloat] = [1, 3, 5, 13, 17, 36]
        
        // simple line with custom x axis labels
        var xLabels: [String] = ["6", "7", "8", "9", "10", "11", "12", "12", "12", "12"]
        
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
                if IMC > v.overweight {
                    messageLabel.text = "Acima do Peso.\nIMC ideal = \(v.standard)"
                    messageLabel.textColor = UIColor.orangeColor  ()
                }
                if IMC > v.obese {
                    messageLabel.text = "Obesidade.\nIMC ideal = \(v.standard)"
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
        label.text = "x: \(x)     y: \(yValues)"
    }
    
    
    
    /**
     * Redraw chart on device rotation.
     */
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if let chart = lineChart {
            chart.setNeedsDisplay()
        }
    }

}
