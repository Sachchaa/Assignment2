//
//  EditContactsViewController.swift
//  Contacts
//
//  Created by Sachin Kanishka on 7/5/18.
//  Copyright © 2018 Sachin Kanishka. All rights reserved.
//

import UIKit
import CoreData

class EditContactsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var contact: Contact?
    var con = [NSManagedObject]()
    
    //vars
    @IBOutlet weak var imgPerson: UIButton!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtHome: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMetDay: UITextField!
    
    //add image from gallery
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
        imgPerson.setBackgroundImage(conImage, for: .normal)
    }
    
    //show data in text fields
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            //
            con = try (context.fetch(Contact.fetchRequest())as! [Contact] )
            //ToDo - date
            txtFName.text = contact!.firstName
            txtLName.text = contact!.lastName
            txtMobile.text = String(contact!.mobile)
            txtHome.text = String(contact!.home)
            txtEmail.text = contact!.email
            txtAddress.text = contact!.address
            let image = UIImage(data: contact!.image!)
            imgPerson.setBackgroundImage(image, for: .normal)
            
            
        }
        catch{}
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //update contact button
    @IBAction func updateContact(_ sender: UIButton) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            con = try (context.fetch(Contact.fetchRequest()) as! [Contact] )
            let imageData : Data = UIImagePNGRepresentation(imgPerson.currentBackgroundImage!)!
            contact?.image = imageData
            contact?.firstName = txtFName.text!
            contact?.lastName = txtLName.text!
            contact?.mobile = Int32(txtMobile.text!)!
            contact?.home = Int32(txtHome.text!)!
            contact?.address = txtAddress.text!
            contact?.email = txtEmail.text!
            
            try context.save()
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
             navigationController?.popViewController(animated: true)
        }
        catch{}
        
        }
   
    
    // MARK: - Navigation

    //send data to Contact details page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let contactview = segue.destination as! ContactDetailsViewController
        contactview.con = contact
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
