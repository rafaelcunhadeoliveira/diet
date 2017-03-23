//
//  ThighsViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 10/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class ThighsViewController: UIViewController {
    @IBOutlet weak var thighsImage: UIImageView!
    @IBOutlet weak var leftThighField: UITextField!
    @IBOutlet weak var rightThighField: UITextField!
    
    var actualMeasure: Measure = Measure(year: 0, month: 0, day: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        let floatLeftThighValue = Float(leftThighField.text!)
        let floatRightThighValue = Float(rightThighField.text!)
        self.actualMeasure.setTighs(newLeftThigh: floatLeftThighValue!, newRightThigh: floatRightThighValue!)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let new_Measure = NSEntityDescription.insertNewObject(forEntityName: "Measures", into: context)
        
        new_Measure.setValue("rafael", forKey: "user")
        new_Measure.setValue(actualMeasure.chest, forKey: "chest")
        new_Measure.setValue(actualMeasure.waist, forKey: "waist")
        new_Measure.setValue(actualMeasure.hips, forKey: "hips")
        new_Measure.setValue(actualMeasure.leftArm, forKey: "leftArm")
        new_Measure.setValue(actualMeasure.rightArm, forKey: "rightArm")
        new_Measure.setValue(actualMeasure.leftThigh, forKey: "leftThigh")
        new_Measure.setValue(actualMeasure.rightThigh, forKey: "rightThigh")
        new_Measure.setValue(actualMeasure.year, forKey: "year")
        new_Measure.setValue(actualMeasure.month, forKey: "month")
        new_Measure.setValue(actualMeasure.day, forKey: "day")
        new_Measure.setValue(actualMeasure.weight, forKey: "weight")
        
        do{
            try context.save()
            print("The user is saved")
            
        }
        catch{
            //error
        }
        
        self.performSegue(withIdentifier: "backToHome", sender: sender)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
