//
//  MenuTableViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha on 14/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class MenuTableViewController: UITableViewController {
    
    var allMenus: Array<Menu> = []
    var actualMenu: Menu = Menu(year: 0, month: 0, day: 0, calories: 0, id: "")
    var isNew: Bool = false
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var id: String = ""
    var calories: Float = 0
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if(isNew){
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(MealItensTableViewController.Done))
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(MenuTableViewController.insert))
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        do{
            
            let requestItem = NSFetchRequest<NSFetchRequestResult>(entityName: "Menus")
            requestItem.returnsObjectsAsFaults = false
            
            let resultsItem = try context.fetch(requestItem)
            if resultsItem.count > 0{
                for resultI in resultsItem as! [NSManagedObject]{
                    
                    if let user = resultI.value(forKey: "user"){
                        let userMenu =  String(describing: user)
                        
                        if ("rafael" == userMenu) {
                            if let menuYear = resultI.value(forKey: "year") {
                                let temp =  String(describing: menuYear)
                                year = Int(temp)!
                            }
                            if let menuMonth = resultI.value(forKey: "month") {
                                let temp =  String(describing: menuMonth)
                                month = Int(temp)!
                            }
                            if let menuDay = resultI.value(forKey: "day") {
                                let temp =  String(describing: menuDay)
                                day = Int(temp)!
                            }
                            if let menuID = resultI.value(forKey: "id"){
                                id =  String(describing: menuID)
                            }
                            if let menuCalories = resultI.value(forKey: "totalCalories") {
                                let temp =  String(describing: menuCalories)
                                calories = Float(temp)!
                            }
                            
                            let actualMenu: Menu = Menu(year: year, month: month, day: day, calories: calories, id: id)
                            allMenus.insert(actualMenu, at: 0)
                        }
                    }
                }
            }
            
        }
        catch{
            //error
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func insert(){
        self.isNew = true
        performSegue(withIdentifier: "newMenu", sender: self)
    }
    
    func Done(){
        performSegue(withIdentifier: "backHome", sender: self)
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
        return allMenus.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        let monthName = self.convert(month: allMenus[indexPath.row].month)

        cell.monthLabel.text = monthName
        cell.yearLabel.text = String(allMenus[indexPath.row].year)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.actualMenu = allMenus[indexPath.row]
        self.isNew = false
        self.performSegue(withIdentifier: "individualMenu", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MealTableViewController{
            destination.actualMenu = self.actualMenu
            destination.isNew = self.isNew
        }
        if let destination = segue.destination as? NewMenuViewController{
            destination.actualMenu = self.actualMenu
            destination.isNew = self.isNew
        }
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
            var mealcount = 0
            var itencount = 0
            do{
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Menus")
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
                let mealsrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Meals")
                mealsrequest.returnsObjectsAsFaults = false
                
                let mealsresults = try moc.fetch(mealsrequest)
                if mealsresults.count > 0{
                    for result in mealsresults as! [NSManagedObject]{
                        if(mealcount == indexPath.row){
                            moc.delete(result)
                        }
                        mealcount += 1
                    }
                }
                let itensrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Itens")
                itensrequest.returnsObjectsAsFaults = false
                
                let itensresults = try moc.fetch(itensrequest)
                if itensresults.count > 0{
                    for result in itensresults as! [NSManagedObject]{
                        if(itencount == indexPath.row){
                            moc.delete(result)
                        }
                        itencount += 1
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
            
            self.allMenus.remove(at: indexPath.row)
            tableView.reloadData()
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
