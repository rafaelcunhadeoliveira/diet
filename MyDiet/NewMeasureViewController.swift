//
//  NewMeasureViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 09/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class NewMeasureViewController: UIViewController {
    @IBOutlet weak var pickerView: UIDatePicker!
    
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var actualMeasure: Measure = Measure(year: 0, month: 0, day: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.datePickerMode = UIDatePickerMode.date
        pickerView.addTarget(self, action: #selector(dateTarget), for: UIControlEvents.valueChanged)
        let actualDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: actualDate)
        
        year =  components.year!
        month = components.month!
        day = components.day!
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
    
    
    @IBAction func goToChestMeasure(_ sender: Any) {
        actualMeasure = Measure(year: self.year, month: self.month, day: self.day)
        self.performSegue(withIdentifier: "toWeight", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WeightViewController{
            destination.actualMeasure = self.actualMeasure
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
