//
//  Menu.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 13/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

class Menu: NSObject{
    var year: Int
    var month: Int
    var day: Int
    var meals: Array

    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
        self.chest = 0
        self.waist = 0
        self.hips = 0
        self.leftArm = 0
        self.rightArm = 0
        self.leftThigh = 0
        self.rightThigh = 0
        self.weight = 0
    }
    
    func setChest(newchest: Float){
        self.chest = newchest
    }
    
    func setWaist(newwaist: Float){
        self.waist = newwaist
    }
    
    func setHips(newHips: Float){
        self.hips = newHips
    }
    
    func setWeight(newWeight: Float){
        self.weight = newWeight
    }
    
    func setArms(newLeftArm: Float, newRightArm: Float){
        self.leftArm = newLeftArm
        self.rightArm = newRightArm
    }
    func setTighs(newLeftThigh: Float, newRightThigh: Float){
        self.leftThigh = newLeftThigh
        self.rightThigh = newRightThigh
    }
    
    
    
    
    
    
    
}
