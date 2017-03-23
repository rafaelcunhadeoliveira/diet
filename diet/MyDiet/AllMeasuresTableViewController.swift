//
//  AllMeasuresTableViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 10/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class AllMeasuresTableViewController: UITableViewController {
    
    var allMeasures: Array<Measure> = []
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var chest: Float = 0
    var waist: Float = 0
    var hips: Float = 0
    var leftArm: Float = 0
    var rightArm: Float = 0
    var leftThigh: Float = 0
    var rightThigh: Float = 0
    var weight: Float = 0
    var actualMeasure: Measure = Measure(year: 0, month: 0, day: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(AllMeasuresTableViewController.insert))
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        do{
            
            let requestMeasure = NSFetchRequest<NSFetchRequestResult>(entityName: "Measures")
            requestMeasure.returnsObjectsAsFaults = false
            
            let resultsMeasure = try context.fetch(requestMeasure)
            if resultsMeasure.count > 0{
                for resultM in resultsMeasure as! [NSManagedObject]{
                    if let mYear = resultM.value(forKey: "year") {
                        let temp =  String(describing: mYear)
                        year = Int(temp)!
                        
                    }
                    if let mMonth = resultM.value(forKey: "month") {
                        let temp =  String(describing: mMonth)
                        month = Int(temp)!
                    }
                    if let mDay = resultM.value(forKey: "day"){
                        let temp =  String(describing: mDay)
                        day = Int(temp)!
                    }
                    if let mChest = resultM.value(forKey: "chest"){
                        let temp =  String(describing: mChest)
                        chest = Float(temp)!
                    }
                    if let mWaist = resultM.value(forKey: "waist"){
                        let temp =  String(describing: mWaist)
                        waist = Float(temp)!
                    }
                    if let mHips = resultM.value(forKey: "hips"){
                        let temp =  String(describing: mHips)
                        hips = Float(temp)!
                    }
                    if let mRightArm = resultM.value(forKey: "rightArm"){
                        let temp =  String(describing: mRightArm)
                        rightArm = Float(temp)!
                    }
                    if let mLeftArm = resultM.value(forKey: "leftArm"){
                        let temp =  String(describing: mLeftArm)
                        leftArm = Float(temp)!
                    }
                    if let mLeftThigh = resultM.value(forKey: "leftThigh"){
                        let temp =  String(describing: mLeftThigh)
                        leftThigh = Float(temp)!
                    }
                    if let mRightThigh = resultM.value(forKey: "rightThigh"){
                        let temp =  String(describing: mRightThigh)
                        rightThigh = Float(temp)!
                    }
                    if let mWeigt = resultM.value(forKey: "weight"){
                        let temp =  String(describing: mWeigt)
                        weight = Float(temp)!
                    }
                    
                    let actualMeasure = Measure(year: year, month: month, day: day)
                    actualMeasure.setChest(newchest: chest)
                    actualMeasure.setWaist(newwaist: waist)
                    actualMeasure.setHips(newHips: hips)
                    actualMeasure.setArms(newLeftArm: leftArm, newRightArm: rightArm)
                    actualMeasure.setTighs(newLeftThigh: leftThigh, newRightThigh: rightThigh)
                    actualMeasure.setWeight(newWeight: weight)
                    self.allMeasures.insert(actualMeasure, at: 0)
                    
                    
                }
            }
            
        }
        catch{
            //error
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    func insert(){
        performSegue(withIdentifier: "newMeasure", sender: self)
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
        return allMeasures.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AllMeasuresTableViewCell = tableView.dequeueReusableCell(withIdentifier: "measureCell", for: indexPath) as! AllMeasuresTableViewCell
        let monthName = self.convert(month: allMeasures[indexPath.row].month)
        cell.monthField.text = monthName
        cell.yearField.text = String(allMeasures[indexPath.row].year)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.actualMeasure = allMeasures[indexPath.row]
        self.performSegue(withIdentifier: "goToIndividual", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? IndividualMeasureTableViewController{
            destination.actualMeasure = self.actualMeasure
        }
    }
    

    
    func convert(month: Int) -> String{
        switch month {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"

        default:
            print("erro")
        }
        return""
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let moc = getContext()
            var count = 0
            do{
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Measures")
                request.returnsObjectsAsFaults = false
                
                let results = try moc.fetch(request)
                if results.count > 0{
                    for result in results as! [NSManagedObject]{
                        if(count == indexPath.row){
                            moc.delete(result)
                        }
                        count += 1
                    }
                }
            }
            catch{}
            
            do {
                try moc.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
            
            self.allMeasures.remove(at: indexPath.row)
            tableView.reloadData()
        }
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
