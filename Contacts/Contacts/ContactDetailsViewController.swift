//
//  ContactDetailsViewController.swift
//  Contacts
//
//  Created by Sachin Kanishka on 8/5/18.
//  Copyright © 2018 Sachin Kanishka. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    var con : Contact? 
    
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblFriendsSince: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let fname = con?.firstName
        let lname = con?.lastName
        contactName.text = fname! + " " + lname!
        lblMobile.text = String(con!.mobile)
        lblHome.text = String(con!.home)
        lblEmail.text = con!.email
        lblAddress.text = con!.address
        let image = UIImage(data: con!.image!)
        imgPerson.image = image
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    
    

    
  /*  func getData(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            //
            contacts = try (context.fetch(Contact.fetchRequest())as! [Contact] )
            contactName.text? = 
        }
            
        catch{}
        
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let con = contacts[UITableViewCell.row]
        cell.textLabel?.text = con.firstName! + " " + con.lastName!
        return cell */
        
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
