//
//  GraphView.swift
//  IMCPed
//
//  Created by Douglas Mandarino on 4/29/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable public class GraphView: UIView {
    //1 - the properties for the gradient
    @IBInspectable public var startColor: UIColor = UIColor.redColor()
    @IBInspectable public var endColor: UIColor = UIColor.greenColor()
    
    var isBoy:Bool = Kid.sharedInstance.isBoy!
    var age:Int = Kid.sharedInstance.age!
    var imc:Float = Kid.sharedInstance.IMC!
    
    
    //GIRLS
    // ate 8 anos
    var graphGirlPoints1:[Float] = [15.6, 15.4, 15.2, 15.3, 14.3, 14.9, 15.6]
    var graphGirlOverPoints1:[Float] = [17.2, 16.8, 16.8, 17.0, 16.1, 17.1, 18.1]
    var graphGirlObesePoints1:[Float] = [18.6, 18.2, 18.3, 18.6, 17.4, 18.9, 20.3]
    //mais de 8 anos
    var graphGirlPoints2:[Float] = [16.3, 17.0, 17.6, 18.3, 18.9, 19.3, 19.6]
    var graphGirlOverPoints2:[Float] = [19.1, 20.1, 21.1, 22.1, 23.0, 23.8, 24.2]
    var graphGirlObesePoints2:[Float] = [21.7, 23.2, 24.5, 25.9, 27.7, 27.9, 28.8]
    
    
    //BOYS
    // ate 8 anos
    var graphBoysPoints1:[Float] = [16.0, 15.6, 15.4, 15.2, 14.5, 15.0, 15.6]
    var graphBoysOverPoints1:[Float] = [17.4, 17.0, 16.8, 16.6, 16.6, 17.3, 17.7]
    var graphBoysObesePoints1:[Float] = [18.6, 18.2, 18.0, 18.0, 18.0, 19.1, 20.3]
    
    //mais de 8 anos
    var graphBoysPoints2:[Float] = [16.1, 16.7, 17.2, 17.8, 18.5, 19.2, 19.9]
    var graphBoysOverPoints2:[Float] = [18.8, 19.6, 20.3, 21.1, 21.9, 22.7, 23.6]
    var graphBoysObesePoints2:[Float] = [21.4, 22.5, 23.7, 24.8, 25.9, 26.9, 27.7]

    
    
    var standardPoints = [Float]()
    var overPoints = [Float]()
    var obesePoints = [Float]()
    
    override public func drawRect(rect: CGRect) {
        let width = rect.width
        let height:CGFloat
        
        if age <= 8 {
            height = rect.height/0.4
        } else {
            height = rect.height/0.55
        }
        
        if self.isBoy == false {
            if self.age <= 8{
                standardPoints = graphGirlPoints1
                overPoints = graphGirlOverPoints1
                obesePoints = graphGirlObesePoints1
            } else {
                standardPoints = graphGirlPoints2
                overPoints = graphGirlOverPoints2
                obesePoints = graphGirlObesePoints2
            }
        } else {
            if self.age <= 8{
                standardPoints = graphBoysPoints1
                overPoints = graphBoysOverPoints1
                obesePoints = graphBoysObesePoints1
            } else {
                standardPoints = graphBoysPoints2
                overPoints = graphBoysOverPoints2
                obesePoints = graphBoysObesePoints2
            }
        }
    
        
        //set up background clipping area
        var path = UIBezierPath(roundedRect: rect,
            byRoundingCorners: UIRectCorner.AllCorners,
            cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()
        
        //2 - get the current context
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.CGColor, endColor.CGColor]
        
        //3 - set up the color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //4 - set up the color stops
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        //5 - create the gradient
        let gradient = CGGradientCreateWithColors(colorSpace,
            colors,
            colorLocations)
        
        //6 - draw the gradient
        var startPoint = CGPoint.zeroPoint
        var endPoint = CGPoint(x:0, y:self.bounds.height)
        CGContextDrawLinearGradient(context,
            gradient,
            startPoint,
            endPoint,
            0)
        
        //calculate the x point
        
        let margin:CGFloat = 20.0
        var columnXPoint = { (column:Int) -> CGFloat in
            //Calculate gap between points
            let spacer = (width - margin*2 - 4) /
                CGFloat((self.graphGirlObesePoints1.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        // calculate the y point
        
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        var maxValue = maxElement(obesePoints)
        if maxElement(obesePoints) < imc {
            maxValue = imc
        }
        var columnYPoint = { (graphPoint:Float) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) /
                CGFloat(maxValue) * graphHeight
            y = graphHeight + topBorder - y // Flip the graph
            return y
        }
        
        
        //=============================================================//
        // draw the line graph OBESE
        
        UIColor.orangeColor().setFill()
        UIColor.orangeColor().setStroke()
        
        //set up the points line
        var graphPath2 = UIBezierPath()
        //go to start of line
        graphPath2.moveToPoint(CGPoint(x:columnXPoint(0),
            y:columnYPoint(obesePoints[0])))
        
        //add points for each item in the graphPoints array
        //at the correct (x, y) for the point
        for i in 1..<obesePoints.count {
            let nextPoint = CGPoint(x:columnXPoint(i),
                y:columnYPoint(obesePoints[i]))
            graphPath2.addLineToPoint(nextPoint)
        }
        
        //Create the clipping path for the graph gradient
        
        //1 - save the state of the context (commented out for now)
        CGContextSaveGState(context)
        
        //2 - make a copy of the path
        var clippingPath2 = graphPath2.copy() as! UIBezierPath
        
        //3 - add lines to the copied path to complete the clip area
        clippingPath2.addLineToPoint(CGPoint(
            x: columnXPoint(obesePoints.count - 1),
            y:height))
        clippingPath2.addLineToPoint(CGPoint(
            x:columnXPoint(0),
            y:height))
        clippingPath2.closePath()
        
        //4 - add the clipping path to the context
        clippingPath2.addClip()
        
                let highestYPoint1 = columnYPoint(maxValue)
                startPoint = CGPoint(x:margin, y: highestYPoint1)
                endPoint = CGPoint(x:margin, y:self.bounds.height)
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        CGContextRestoreGState(context)
        
        graphPath2.lineWidth = 2.0
        graphPath2.stroke()
        
        //Draw the circles on top of graph stroke
        for i in 0..<graphGirlPoints1.count {
            var point = CGPoint(x:columnXPoint(i), y:columnYPoint(obesePoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalInRect:
                CGRect(origin: point,
                    size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        //=============================================================//

        
        //=============================================================//
        // draw the line graph OVER
        
        UIColor.yellowColor().setFill()
        UIColor.yellowColor().setStroke()
        
        //set up the points line
        var graphPath1 = UIBezierPath()
        //go to start of line
        graphPath1.moveToPoint(CGPoint(x:columnXPoint(0),
            y:columnYPoint(overPoints[0])))
        
        //add points for each item in the graphPoints array
        //at the correct (x, y) for the point
        for i in 1..<overPoints.count {
            let nextPoint = CGPoint(x:columnXPoint(i),
                y:columnYPoint(overPoints[i]))
            graphPath1.addLineToPoint(nextPoint)
        }
        
        //Create the clipping path for the graph gradient
        
        //1 - save the state of the context (commented out for now)
        CGContextSaveGState(context)
        
        //2 - make a copy of the path
        var clippingPath1 = graphPath1.copy() as! UIBezierPath
        
        //3 - add lines to the copied path to complete the clip area
        clippingPath1.addLineToPoint(CGPoint(
            x: columnXPoint(overPoints.count - 1),
            y:height))
        clippingPath1.addLineToPoint(CGPoint(
            x:columnXPoint(0),
            y:height))
        clippingPath1.closePath()
        
        //4 - add the clipping path to the context
        clippingPath1.addClip()
        
//        let highestYPoint2 = columnYPoint(maxValue)
//        startPoint = CGPoint(x:margin, y: highestYPoint2)
//        endPoint = CGPoint(x:margin, y:self.bounds.height)
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        CGContextRestoreGState(context)
        
        graphPath1.lineWidth = 2.0
        graphPath1.stroke()
        
        //Draw the circles on top of graph stroke
        for i in 0..<graphGirlPoints1.count {
            var point = CGPoint(x:columnXPoint(i), y:columnYPoint(overPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalInRect:
                CGRect(origin: point,
                    size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        //=============================================================//

        // draw the line graph STANDARD
        
        UIColor.whiteColor().setFill()
        UIColor.whiteColor().setStroke()
        
        //set up the points line
        var graphPath = UIBezierPath()
        //go to start of line
        graphPath.moveToPoint(CGPoint(x:columnXPoint(0),
            y:columnYPoint(standardPoints[0])))
        
        //add points for each item in the graphPoints array
        //at the correct (x, y) for the point
        for i in 1..<standardPoints.count {
            let nextPoint = CGPoint(x:columnXPoint(i),
                y:columnYPoint(standardPoints[i]))
            graphPath.addLineToPoint(nextPoint)
        }
        
        //Create the clipping path for the graph gradient
        
        //1 - save the state of the context (commented out for now)
        CGContextSaveGState(context)
        
        //2 - make a copy of the path
        var clippingPath = graphPath.copy() as! UIBezierPath
        
        //3 - add lines to the copied path to complete the clip area
        clippingPath.addLineToPoint(CGPoint(
            x: columnXPoint(standardPoints.count - 1),
            y:height))
        clippingPath.addLineToPoint(CGPoint(
            x:columnXPoint(0),
            y:height))
        clippingPath.closePath()
        
        //4 - add the clipping path to the context
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue)
        startPoint = CGPoint(x:margin, y: highestYPoint)
        endPoint = CGPoint(x:margin, y:self.bounds.height)
//
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        CGContextRestoreGState(context)
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        //Draw the circles on top of graph stroke
        for i in 0..<standardPoints.count {
            var point = CGPoint(x:columnXPoint(i), y:columnYPoint(standardPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalInRect:
                CGRect(origin: point,
                    size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
         //=============================================================//
        
        //Draw horizontal graph lines on the top of everything
        var linePath = UIBezierPath()
        
        //top line
        linePath.moveToPoint(CGPoint(x:margin, y: topBorder))
        linePath.addLineToPoint(CGPoint(x: width - margin,
            y:topBorder))
        
        //center line
        linePath.moveToPoint(CGPoint(x:margin,
            y: graphHeight/2 + topBorder))
        linePath.addLineToPoint(CGPoint(x:width - margin,
            y:graphHeight/2 + topBorder))
        
        //bottom line
        linePath.moveToPoint(CGPoint(x:margin,
            y:height - bottomBorder))
        linePath.addLineToPoint(CGPoint(x:width - margin,
            y:height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
        
        //==========================================================//
        //==========KID BMI ===============//
        UIColor.redColor().setFill()
        UIColor.redColor().setStroke()
        
        
        var constant = 0

        if age <= 8 {
            constant = 2
            age -= 2
        } else {
            constant = 9
            age -= 9
        }
        
        //Draw the circles on top of graph stroke
        var point = CGPoint(x:columnXPoint(age),
            y:columnYPoint(self.imc))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalInRect:
                CGRect(origin: point,
                    size: CGSize(width: 8.0, height: 8.0)))
            circle.fill()
        
        
        // =================== AGE LABEL ==============//
        
        for i in 0..<standardPoints.count {
            var label = UILabel(frame: CGRectMake(columnXPoint(i)-5, 225, 20, 12 ))
//            label.textAlignment = NSTextAlignment.Center
            label.text = "\(i+constant)";
            label.font = UIFont(name: "Arial", size: 12)
            label.textColor = UIColor.whiteColor()
            label.tag = 5;
            addSubview(label);
        }
        
        var label = UILabel(frame: CGRectMake(10, 15, 100, 12 ))
        label.textAlignment = NSTextAlignment.Center
        label.text = NSLocalizedString("BMI / Years", comment: "BMI / Years")
        label.font = UIFont(name: "Arial", size: 15)
        label.textColor = UIColor.whiteColor()
        label.tag = 5;
        addSubview(label);
    }
}