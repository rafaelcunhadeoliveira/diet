//
//  NewItemViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha on 15/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class NewItemViewController: UIViewController {

    var itens: Array<String> = []
    var itemName: String = ""
    var itemQuantity: String = ""
    var itemUnity: String = ""
    var actualMeal: Meal = Meal(hour: 0, minute: 0, id: "")
    var actualMenu: Menu = Menu(year: 0, month: 0, day: 0, calories: 0, id: "")
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var unityField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }

//    @IBAction func SaveButton(_ sender: Any) {
//        items.append((nameField.text!, quantityField.text!,unityField.text!))
//        performSegue(withIdentifier: "saveItem", sender: self)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? MealItensTableViewController{
//            destination.items = self.items
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkValues() -> Bool{
        if(nameField.text != ""){
            itemName = nameField.text!
            if(unityField.text! != ""){
                itemUnity = unityField.text!
                do{
                    try Int(quantityField.text!)
                    itemQuantity = quantityField.text!
                    return true
                }
                catch{
                    //quantity not a number
                    print("quantity not a number")
                }
            }
            else{
                //item unity is empty
                print("item unity is empty")
            }
        }
        else{
            //item name is empty
            print("item name is empty")
        }
        return false
        
    }
    
    @IBAction func saveItem(_ sender: Any) {
        
        if(checkValues()){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let new_Measure = NSEntityDescription.insertNewObject(forEntityName: "Itens", into: context)
        
        new_Measure.setValue("rafael", forKey: "user")
        new_Measure.setValue(itemName, forKey: "name")
        new_Measure.setValue(itemQuantity, forKey: "quantity")
        new_Measure.setValue(itemUnity, forKey: "unity")
        new_Measure.setValue(actualMeal.id, forKey: "id")

        do{
            try context.save()
            print("The user is saved")
            
        }
        catch{
            //error
        }
        
        performSegue(withIdentifier: "saveItem", sender: self)
        }
        else{
            print("valores errados")
        }
    }
    	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MealItensTableViewController{
            destination.actualMeal = self.actualMeal
            destination.newItem = true
            destination.actualMenu = self.actualMenu
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
