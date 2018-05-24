//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Sachin Kanishka on 8/5/18.
//  Copyright © 2018 Sachin Kanishka. All rights reserved.
//

import UIKit
import CoreData

class ContactDetailsViewController: UIViewController {
    var con : Contact?
    var cont = [NSManagedObject]()
    
    //vars
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblFriendsSince: UILabel!

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
   


}
