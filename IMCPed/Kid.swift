//
//  Kid.swift
//  IMCPed
//
//  Created by Douglas Mandarino on 4/30/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import Foundation

class Kid {
    
    var IMC:Float?
    var age:Int?
    var isBoy:Bool?
    var height:Float?
    
    class var sharedInstance :Kid {
        struct Singleton {
            static let instance = Kid()
        }
        return Singleton.instance
    }
}