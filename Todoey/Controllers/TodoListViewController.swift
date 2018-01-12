//
//  ViewController.swift
//  Todoey
//
//  Created by Carl on 05/01/2018.
//  Copyright © 2018 Carl. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

 //  var itemArray = ["Find Mike","Buy Eggos", "Destroy Demogorgon"]
    
    var itemArray = [Item]()
    
    
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        print(dataFilePath!)

        loadItems()

        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] { // retrieve user defaults
//            itemArray = items // handles scenarios where userdefaults not yet initialized
//        }
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        //tenary operator
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])

//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }
//        else {
//            itemArray[indexPath.row].done = false
//        }
//
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        
        
        tableView.reloadData()
        
        // leave the row deselected
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        // add an alert
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        // add an action
        
        
        // NOTE we are in an enclosure block
        // NOTE (stuff) represents the alert
        let action = UIAlertAction(title: "Add Item", style: .default) { (stuff) in
            // what will happen once the user clicks the Add Item button on our UIAlert
            // this inside enclosure statement, only activated after addTextField is run

            // 'self' keyword needed as we're inside an enclosure
            print(stuff.title!)
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            
            // remember, we add self as we're inside a closure
           // self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
            
        }
        
        // and another enclosure block
        // alerttextfield variable represents the textfield
        // note problems on sequencing
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField // transfers value to textfield which has more scope
            print(textField.text!)
            print("Now")
            }

            
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Maniulation Methods
    
    func saveItems() {
        
        //create an encoder to persist data into a file
        let encoder = PropertyListEncoder()
        
        
        //notice self as we're inside an enclosure (code written when user clicks button) [self removed as now inside a function, not an enclosure)
        //dataFilepath at correct level of scope
        //we use try blocks as there can be errors when writing to a file ...
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array \(error)")
        }
        
        
    }
    
    // notice the ? after try, turns results of Data statement into an optional
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
                
            } catch {
            print("Error encoding item array \(error)")
            }
        }
        
    }
    
}

