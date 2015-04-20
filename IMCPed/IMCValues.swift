//
//  IMCValues.swift
//  IMCPed
//
//  Created by Douglas Mandarino on 4/19/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import Foundation

class IMCValues {
 
    var boyList = [Value]()
    var girlList = [Value]()

    //BOY LIST!!!
    var v2M = Value(age: 2, standard: 16.0, overweight: 17.4, obese: 18.6)
    var v3M = Value(age: 3, standard: 15.6, overweight: 17.0, obese: 18.2)
    var v4M = Value(age: 4, standard: 15.4, overweight: 16.8, obese: 18.0)
    var v5M = Value(age: 5, standard: 15.2, overweight: 16.6, obese: 18.0)
    var v6M = Value(age: 6, standard: 14.5, overweight: 16.6, obese: 18.0)
    var v7M = Value(age: 7, standard: 15, overweight: 17.3, obese: 19.1)
    var v8M = Value(age: 8, standard: 15.6, overweight: 16.7, obese: 20.3)
    var v9M = Value(age: 9, standard: 16.1, overweight: 18.8, obese: 21.4)
    var v10M = Value(age: 10, standard: 16.7, overweight: 19.6, obese: 22.5)
    var v11M = Value(age: 11, standard: 17.2, overweight: 20.3, obese: 23.7)
    var v12M = Value(age: 12, standard: 17.8, overweight: 21.1, obese: 24.8)
    var v13M = Value(age: 13, standard: 18.5, overweight: 21.9, obese: 25.9)
    var v14M = Value(age: 14, standard: 19.2, overweight: 22.7, obese: 26.9)
    var v15M = Value(age: 15, standard: 19.9, overweight: 23.6, obese: 27.7)
    
    func getBoyList() ->[Value] {
        boyList.append(v2M)
        boyList.append(v3M)
        boyList.append(v4M)
        boyList.append(v5M)
        boyList.append(v6M)
        boyList.append(v7M)
        boyList.append(v8M)
        boyList.append(v9M)
        boyList.append(v10M)
        boyList.append(v11M)
        boyList.append(v12M)
        boyList.append(v13M)
        boyList.append(v14M)
        boyList.append(v15M)
        
        return boyList
    }
    
    //GIRL LIST!!!
    var v2F = Value(age: 2, standard: 15.6, overweight: 17.2, obese: 18.6)
    var v3F = Value(age: 3, standard: 15.4, overweight: 16.8, obese: 18.2)
    var v4F = Value(age: 4, standard: 15.2, overweight: 16.8, obese: 18.3)
    var v5F = Value(age: 5, standard: 15.3, overweight: 17.0, obese: 18.6)
    var v6F = Value(age: 6, standard: 14.3, overweight: 16.1, obese: 17.4)
    var v7F = Value(age: 7, standard: 14.9, overweight: 17.1, obese: 18.9)
    var v8F = Value(age: 8, standard: 15.6, overweight: 18.1, obese: 20.3)
    var v9F = Value(age: 9, standard: 16.3, overweight: 19.1, obese: 21.7)
    var v10F = Value(age: 10, standard: 17.0, overweight: 20.1, obese: 23.2)
    var v11F = Value(age: 11, standard: 17.6, overweight: 21.1, obese: 24.5)
    var v12F = Value(age: 12, standard: 18.3, overweight: 22.1, obese: 25.9)
    var v13F = Value(age: 13, standard: 18.9, overweight: 23.0, obese: 27.7)
    var v14F = Value(age: 14, standard: 19.3, overweight: 23.8, obese: 27.9)
    var v15F = Value(age: 15, standard: 19.6, overweight: 24.2, obese: 28.8)
    
    func getGirlList() ->[Value] {
        girlList.append(v2F)
        girlList.append(v3F)
        girlList.append(v4F)
        girlList.append(v5F)
        girlList.append(v6F)
        girlList.append(v7F)
        girlList.append(v8F)
        girlList.append(v9F)
        girlList.append(v10F)
        girlList.append(v11F)
        girlList.append(v12F)
        girlList.append(v13F)
        girlList.append(v14F)
        girlList.append(v15F)
        
        return girlList
    }

}