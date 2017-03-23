//
//  IndividualMeasureViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 10/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class IndividualMeasureViewController: UIViewController {
    
    var actualMeasure: Measure = Measure(year: 0, month: 0, day: 0)
    @IBOutlet weak var chestField: UILabel!
    @IBOutlet weak var waistField: UILabel!
    @IBOutlet weak var hipsField: UILabel!
    @IBOutlet weak var leftArmField: UILabel!
    @IBOutlet weak var rightArmField: UILabel!
    @IBOutlet weak var leftThighField: UILabel!
    @IBOutlet weak var rightThighField: UILabel!
    @IBOutlet weak var weightField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chestField.text = String(actualMeasure.chest)
        waistField.text = String(actualMeasure.waist)
        hipsField.text = String(actualMeasure.hips)
        leftArmField.text = String(actualMeasure.leftArm)
        rightArmField.text = String(actualMeasure.rightArm)
        leftThighField.text = String(actualMeasure.leftThigh)
        rightThighField.text = String(actualMeasure.rightThigh)
        weightField.text = String(actualMeasure.weight)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
