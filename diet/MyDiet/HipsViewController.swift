//
//  HipsViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 10/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class HipsViewController: UIViewController {

    @IBOutlet weak var hipsImage: UIImageView!
    @IBOutlet weak var hipsField: UITextField!
    
    
    var actualMeasure: Measure = Measure(year: 0, month: 0, day: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextAction(_ sender: Any) {
        let floatHipsValue = Float(hipsField.text!)
        self.actualMeasure.setHips(newHips: floatHipsValue!)
        self.performSegue(withIdentifier: "toArms", sender: sender)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArmsViewController{
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
