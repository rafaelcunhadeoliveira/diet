//
//  NewMealViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha on 14/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class NewMealViewController: UIViewController {

    var hour: Int = 0
    var minutes: Int = 0
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var actualMenu: Menu = Menu(year: 0, month: 0, day: 0)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.datePickerMode = UIDatePickerMode.time
        timePicker.addTarget(self, action: #selector(dateTarget), for: UIControlEvents.valueChanged)
        let actualDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: actualDate)
        
        hour =  components.hour!
        minutes = components.minute!
        // Do any additional setup after loading the view.
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
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? WeightViewController{
//            destination.actualMeasure = self.actualMeasure
//        }
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
