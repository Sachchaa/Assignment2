//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Sachin Kanishka on 8/5/18.
//  Copyright © 2018 Sachin Kanishka. All rights reserved.
//

import UIKit
import CoreData
//import MessageUI

class ContactDetailsViewController: UIViewController {

    
    //vars
    var con : Contact?
    var cont = [NSManagedObject]()
    
    //IBoutlet
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var call: UIButton!
    @IBOutlet weak var msg: UIButton!
    
    //show data on contact view page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            //
            cont = try (context.fetch(Contact.fetchRequest())as! [Contact])
            let fname = con?.firstName
            let lname = con?.lastName
            contactName.text = fname! + " " + lname!
            lblMobile.text = String(con!.mobile)
            lblHome.text = String(con!.home)
            lblEmail.text = con!.email
            lblAddress.text = con!.address
            let image = UIImage(data: con!.image!)
            imgPerson.image = image
        }
        catch{}
        
        // Do any additional setup after loading the view.
    }
    
    //data show when open the page
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            //
            cont = try (context.fetch(Contact.fetchRequest())as! [Contact])
            let fname = con?.firstName
            let lname = con?.lastName
            contactName.text = fname! + " " + lname!
            lblMobile.text = String(con!.mobile)
            lblHome.text = String(con!.home)
            lblEmail.text = con!.email
            lblAddress.text = con!.address
            let image = UIImage(data: con!.image!)
            imgPerson.image = image
        }
        catch{}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // MARK: - Navigation

   //send data to edit contact page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "editContactSegue") {
            let contactview = segue.destination as! EditContactsViewController
            contactview.contact = con
        }
    }
    
    //codings for call and massege buttons. they are not woeking. 
 
     /*
    @IBAction func btnMsg(_ sender: UIButton) {
        
        let msgVC = MFMessageComposeViewController()
        
        msgVC.recipients = [lblMobile.text!]
        msgVC.messageComposeDelegate = self
        
        self.present(msgVC, animated: true, completion: nil )
        
        //self.presentedViewController(msgVC, animated: true, completion: nil)
    
        
    }
    
    @IBAction func btnCall(_ sender: UIButton) {
  
        if let url = URL(string: "tel://\(String(con!.mobile))") {
            UIApplication.shared.canOpenURL(url)
        }
      
    
    
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
    }
 
 */
    
    
}
