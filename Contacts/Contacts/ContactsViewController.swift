//
//  ContactsViewController.swift
//  Contacts
//
//  Created by Sachin Kanishka on 1/5/18.
//  Copyright © 2018 Sachin Kanishka. All rights reserved.
//

import UIKit
import CoreData

class ContactsViewController: UITableViewController {
    
    //vars
    var contacts : [Contact] = []
    
    //show data when start the page
    override func viewWillAppear(_ animated: Bool) {
        //get the NSManagedObjectContext
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            
            contacts = try (context.fetch(Contact.fetchRequest())as! [Contact] )
        }
        catch{}
        
        //reload the table
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
            
            return contacts.count

    }
    
    //show first name and last name
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        //let text: String
        let con = self.contacts[indexPath.row]
        if con.lastName == nil || con.firstName == nil {
            con.lastName = " "
            con.firstName = " "
        }
        cell.textLabel?.text = con.firstName! + " " + con.lastName!
        
        return cell
    }

    //table controller
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete {
            // Delete the row from the data source
            let conta = contacts[indexPath.row]
            context.delete(conta)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
           // tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                contacts = try context.fetch(Contact.fetchRequest())
            }
            catch{}
         
        //edit contact 
        } else if editingStyle == .insert {
           
        }
        
        tableView.reloadData()
}
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "contactDetailsSegue") {
            let contactview = segue.destination as! ContactDetailsViewController
            let indexPath = tableView.indexPathForSelectedRow
            let contact = contacts[indexPath!.row]
            contactview.con = contact
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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

    
 

 }*/
