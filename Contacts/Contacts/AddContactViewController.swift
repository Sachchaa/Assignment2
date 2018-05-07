//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Sachin Kanishka on 1/5/18.
//  Copyright © 2018 Sachin Kanishka. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    //vars in add contacts
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtHome: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var imgPerson: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //add contct button function
    //todo - have to add date
    @IBAction func btnAddContact(_ sender: UIButton) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let contact = Contact(context: context)
        contact.firstName = txtFName.text!
        contact.lastName = txtLName.text!
        contact.mobile = Int32(txtMobile.text!)!
        contact.home = Int32(txtHome.text!)!
        contact.address = txtAddress.text!
        contact.email = txtEmail.text!
        //contact.metDate = Date(txtDate.text!)!
        
        do {
            try context.save()
        }catch{}
    
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
        let alert = UIAlertController(title: "Add Contact", message: "Contact is added", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (alert:UIAlertAction!) -> Void in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
       
    
        
        
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
