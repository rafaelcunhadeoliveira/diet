//
//  WeightViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 13/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController {
    @IBOutlet weak var weightField: UITextField!
    var actualMeasure: Measure = Measure(year: 0, month: 0, day: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButton(_ sender: Any) {
        let floatWeightValue = Float(weightField.text!)
        self.actualMeasure.setWeight(newWeight: floatWeightValue!)
        self.performSegue(withIdentifier: "chestMeasure", sender: sender)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChestMeasureViewController{
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
