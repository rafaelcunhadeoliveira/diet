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
    var meals: Array<Meal>
    var totalCalories: Float

    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
        self.meals = []
        self.totalCalories = 0

    }
    
    func addMeal(newMeal: Meal){
        self.meals.append(newMeal)
    }
    func setTotalCalories(total: Float){
        self.totalCalories = total
    }
    
}
