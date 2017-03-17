//
//  MealTableViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha on 14/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class MealTableViewController: UITableViewController {

    var actualMenu: Menu = Menu(year: 0, month: 0, day: 0, calories: 0, id: "")
    var actualMeal: Meal = Meal(hour: 0, minute: 0, id: "")
    var getID: Meal = Meal(hour: 0, minute: 0, id: "")
    var allMeals: Array<Meal> = []
    
    var hour: Int = 0
    var minute: Int = 0
    var type: String = ""
    
    var isNew: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(MealItensTableViewController.insert))
        
        if(isNew){

            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(MealItensTableViewController.Done))
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        do{
            
            let requestItem = NSFetchRequest<NSFetchRequestResult>(entityName: "Meals")
            requestItem.returnsObjectsAsFaults = false
            
            let resultsItem = try context.fetch(requestItem)
            if resultsItem.count > 0{
                for resultI in resultsItem as! [NSManagedObject]{
                    
                    if let id = resultI.value(forKey: "id"){
                        let mealID =  String(describing: id)
                        let idSplit = mealID.components(separatedBy: "/")
                        
                        if (idSplit[0] == actualMenu.id) {
                            if let mHour = resultI.value(forKey: "hour") {
                                let temp =  String(describing: mHour)
                                hour = Int(temp)!
                            }
                            if let mMinutes = resultI.value(forKey: "minute") {
                                let temp =  String(describing: mMinutes)
                                minute = Int(temp)!
                            }
                            if let mType = resultI.value(forKey: "type"){
                                type =  String(describing: mType)
                            }
                            actualMeal = Meal(hour: hour, minute: minute, id: mealID)
                            actualMeal.setType(type: type)
                            allMeals.append(actualMeal)
                        }
                    }
                }
            }
            
        }
        catch{
            //error
        }
    }
    
    func insert(){
        performSegue(withIdentifier: "newMeal", sender: self)
    }
    
    func Done(){
        performSegue(withIdentifier: "backToMenus", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewMealViewController{
            destination.actualMenu = self.actualMenu
        }
        if let destination = segue.destination as? MenuTableViewController{
            destination.actualMenu = self.actualMenu
        }
        if let destination = segue.destination as? MealItensTableViewController{
            destination.actualMeal = self.actualMeal
        }
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
        return allMeals.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MealTableViewCell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! MealTableViewCell
        
        var displayTime: String
        
        if(0 <= self.allMeals[indexPath.row].minute && self.allMeals[indexPath.row].minute < 10){
            let tempMinute = "0" + String(self.allMeals[indexPath.row].minute)
            displayTime = String(self.allMeals[indexPath.row].hour) + ":" + tempMinute
        }
        else{
            displayTime = String(self.allMeals[indexPath.row].hour) + ":" + String(self.allMeals[indexPath.row].minute)
        }

        cell.timeField.text = displayTime
        cell.typeField.text = self.allMeals[indexPath.row].type
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.actualMeal = allMeals[indexPath.row]
        self.performSegue(withIdentifier: "individualMeal", sender: indexPath.row)
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            let moc = getContext()
            var count = 0
            do{
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Meals")
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
            
            self.allMeals.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
 

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
