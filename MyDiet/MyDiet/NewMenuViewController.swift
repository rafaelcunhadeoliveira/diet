//
//  NewMenuViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha on 14/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class NewMenuViewController: UIViewController {

    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var id: String = ""
    var isNew = true
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var actualMenu: Menu = Menu(year: 0, month: 0, day: 0, id: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.datePickerMode = UIDatePickerMode.date
        timePicker.addTarget(self, action: #selector(dateTarget), for: UIControlEvents.valueChanged)
        let actualDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: actualDate)
        
        year =  components.year!
        month = components.month!
        day = components.day!
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dateTarget (sender: UIDatePicker){
        let date = sender.date
        let calendar = Calendar.current
        
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
    }
    @IBAction func nextButton(_ sender: Any) {
        let menuID = String(self.year) + String(self.month) + String(self.day)
        actualMenu = Menu(year: self.year, month: self.month, day: self.day, id: menuID)
        self.performSegue(withIdentifier: "mealsInMenu", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MealTableViewController{
            destination.actualMenu = self.actualMenu
            destination.isNew = self.isNew
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
