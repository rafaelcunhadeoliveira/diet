//
//  NewMealViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha on 14/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class NewMealViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var hour: Int = 0
    var minutes: Int = 0
    var types: Array<String> = ["Breakfast", "Brunch", "Lunch", "Dinner", "Snack", "Supper"]
    var type: String = "Breakfast"
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var typePicker: UIPickerView!
    
    var actualMenu: Menu = Menu(year: 0, month: 0, day: 0, calories: 0, id: "")
    var actualMeal: Meal = Meal(hour: 0, minute: 0, id: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.datePickerMode = UIDatePickerMode.time
        timePicker.addTarget(self, action: #selector(dateTarget), for: UIControlEvents.valueChanged)
        let actualDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: actualDate)
        
        hour =  components.hour!
        minutes = components.minute!
        
        typePicker.dataSource = self
        typePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        type = types[row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dateTarget (sender: UIDatePicker){
        let date = sender.date
        let calendar = Calendar.current
        
        hour = calendar.component(.hour, from: date)
        minutes = calendar.component(.minute, from: date)
    }
    //    @IBAction func nextButton(_ sender: Any) {
    //        actualMenu = Menu(year: self.year, month: self.month, day: self.day)
    //        self.performSegue(withIdentifier: "toWeight", sender: sender)
    //    }
    
    
    //goToItens
    @IBAction func nextButton(_ sender: Any) {
        let tempID = actualMenu.id + "/" + String(self.hour) + String(self.minutes) + self.type
        actualMeal = Meal(hour: self.hour, minute: self.minutes,id: tempID)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let new_Measure = NSEntityDescription.insertNewObject(forEntityName: "Meals", into: context)
        
        new_Measure.setValue("rafael", forKey: "user")
        new_Measure.setValue(self.hour, forKey: "hour")
        new_Measure.setValue(self.minutes, forKey: "minute")
        new_Measure.setValue(self.type, forKey: "type")
        new_Measure.setValue(self.actualMeal.id, forKey: "id")
        
        do{
            try context.save()
            print("The user is saved")
            
        }
        catch{
            //error
        }
        
        self.performSegue(withIdentifier: "goToItens", sender: sender)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MealItensTableViewController{
            destination.actualMeal = self.actualMeal
            destination.newItem = true
            destination.actualMenu = self.actualMenu
        }
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
