//
//  IndividualMeasureTableViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 22/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class IndividualMeasureTableViewController: UITableViewController {
    
    var actualMeasure: Measure = Measure(year: 0, month: 0, day: 0)
    var measures: [String] = ["Weight", "Chest", "Waist", "Hips", "Left Arm", "Rigth Arm", "Left Thigh", "Right Thigh"]
    var values: [Float] = []
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        values.append(actualMeasure.weight)
        values.append(actualMeasure.chest)
        values.append(actualMeasure.waist)
        values.append(actualMeasure.hips)
        values.append(actualMeasure.leftArm)
        values.append(actualMeasure.rightArm)
        values.append(actualMeasure.leftThigh)
        values.append(actualMeasure.rightThigh)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IndividualMeasureTableViewCell = tableView.dequeueReusableCell(withIdentifier: "IndividualMeasureCell", for: indexPath) as! IndividualMeasureTableViewCell
        
        
        cell.measureLabel.text = measures[indexPath.row]
        cell.valueLabel.text = String(values[indexPath.row])

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
