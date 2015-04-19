//
//  value.swift
//  IMCPed
//
//  Created by Douglas Mandarino on 4/19/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import Foundation

class Value {
    var age:Float
    var standard:Float
    var overweight:Float
    var obese:Float
    
    init (age:Float, standard:Float, overweight:Float, obese:Float){
        self.age = age
        self.standard = standard
        self.obese = obese
        self.overweight = overweight
    }
}