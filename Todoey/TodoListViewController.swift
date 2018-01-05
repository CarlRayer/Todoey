//
//  ViewController.swift
//  Todoey
//
//  Created by Carl on 05/01/2018.
//  Copyright © 2018 Carl. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike","Buy Eggos", "Destroy Demogorgon"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Tableview Dataource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])

      
        if    tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
            
            self.itemArray.append(textField.text!)
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
    
}

