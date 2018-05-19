//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Sachin Kanishka on 1/5/18.
//  Copyright © 2018 Sachin Kanishka. All rights reserved.
//

import UIKit

//
class AddContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //vars in add contacts
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtHome: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var btnImage: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //add image to image button
    @IBAction func addImage(_ sender: UIButton) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    //do nothing when cancel the photo select
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //set image to button when add it
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let conImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        btnImage.setBackgroundImage(conImage, for: .normal)
    }
    
    //function to validate email address using regex
    func isValidateEmail(txtEmail:String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+\\@[A-Za-z0-9.-]+\\.[A-Za-z]+"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: txtEmail)
        
    }
    
    //add contct button function
    //todo - have to add date
    @IBAction func btnAddContact(_ sender: UIButton) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let contact = Contact(context: context)
        var errorMsg : String = ""
        var imageOK : Bool
        var fNameOK : Bool
        var lNameOK : Bool
        var mobOK : Bool
        var homeOK : Bool
        var addOK : Bool
        var emailOK : Bool
        
        
        //validate image button
        if btnImage.currentBackgroundImage != nil && btnImage.currentBackgroundImage != #imageLiteral(resourceName: "add image") {
            imageOK = true
        }
        else {
            imageOK = true
        }
        
        //validate first name
        if txtFName.text != "" {
            fNameOK = true
            
        }
        else {
            errorMsg = "Invalid Conatct first name"
            fNameOK = false
        }
        
        //validate last name
        if txtLName.text != ""{
            lNameOK = true
           
        }
     /*   else if txtLName.text == "" {
            contact.lastName = ""
            lNameOK = true
           
        } */
        else {
            errorMsg = "Invalid Conatct last name"
            lNameOK = false
        }
        
        //validate mobile number
        if txtMobile.text != "" && (txtMobile.text!).count == 10 {
            mobOK = true
            
        }
        else {
            errorMsg = "Invalid Mobile number"
            mobOK = false
        }
        
        //validate home number
        if txtHome.text != "" && (txtHome.text!).count == 10 {
            homeOK = true
            
        }
        else {
            errorMsg = "Invalid Home number"
            homeOK = false
        }
        
        //validate address suburb
        if txtAddress.text != "" {
             addOK = true
            
        }
        else {
            errorMsg = "Invalid address"
            addOK = false
        }
        
        //validate email address and calling validate email function
        if txtEmail.text != "" && isValidateEmail(txtEmail: txtEmail.text!) == true {
            emailOK = true
            
        }
        else {
            errorMsg = "Invalid email address"
            emailOK = false
        }
        
        
  /*
        //validate date
        let dateMet = txtDate.text
        let date = Date()
        let calender = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let metDate = formatter.date(from : dateMet!)
        
        let year = calender.component(.year, from: date)
        let month = calender.component(.month, from: date)
        let day = calender.component(.day, from: date)
        let componants = calender.component(<#T##component: Calendar.Component##Calendar.Component#>, from: <#T##Date#>)
        
        let today = calender.dateComponents(com, from: date)
        
        
        
        if txtDate.text != "" && metDate < ) {
           contact.metDate = metDate
        }
        else {
            errorMsg = "Invalid date"
        }
    
    */
      
        if imageOK == true && fNameOK == true && lNameOK == true && mobOK == true && homeOK == true && addOK == true && emailOK == true {
            do {
 /*
                 let alert = UIAlertController(title: "Add Contacts", message: "contact Added Successfully !! ", preferredStyle: UIAlertControllerStyle.alert)
                 alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (alert:UIAlertAction!) -> Void in
                 }))
                self.present(alert, animated: true, completion: nil)
 */
 
                let imagedata : Data = UIImagePNGRepresentation(btnImage.currentBackgroundImage!)!
                contact.image = imagedata
                contact.firstName = txtFName.text!
                contact.lastName = txtLName.text!
                contact.mobile = Int32(txtMobile.text!)!
                contact.home = Int32(txtHome.text!)!
                contact.address = txtAddress.text!
                contact.email = txtEmail.text!
                
                try context.save()
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                navigationController?.popViewController(animated: true)
            }
            catch{}
        }
            
        else if imageOK == false || imageOK == true && fNameOK == false && lNameOK == false || lNameOK == true && mobOK == false && homeOK == false && addOK == false && emailOK == false {
            
            let alert = UIAlertController(title: "Add Contacts", message: "Please Enter Details", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (alert:UIAlertAction!) -> Void in
            }))
            self.present(alert, animated: true, completion: {print("test")})
            
        }
            
        else {
            let alert = UIAlertController(title: "Add Contacts", message: errorMsg, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (alert:UIAlertAction!) -> Void in
            }))
            self.present(alert, animated: true, completion: {print("test")})
            
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
