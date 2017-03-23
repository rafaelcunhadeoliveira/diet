//
//  ChestMeasureViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 09/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class ChestMeasureViewController: UIViewController {
    
    @IBOutlet weak var chestView: UIImageView!
    @IBOutlet weak var chestField: UITextField!
    
    
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
        let floatChestValue = Float(chestField.text!)
        self.actualMeasure.setChest(newchest: floatChestValue!)
        self.performSegue(withIdentifier: "toWaistMeasure", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WaistViewController{
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
