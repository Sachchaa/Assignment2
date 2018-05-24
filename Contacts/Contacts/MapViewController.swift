//
//  MapViewController.swift
//  Contacts
//
//  Created by Sachin Kanishka on 23/5/18.
//  Copyright © 2018 Sachin Kanishka. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //vars
    var contacts : [Contact] = []
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    //view contacts in map
    override func viewDidLoad() {
        super.viewDidLoad()
        var addressArray = [String]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            //
            contacts = try (context.fetch(Contact.fetchRequest())as! [Contact] )
            for index in 0 ... contacts.count-1{
                addressArray.append(contacts[index].address!)
            }
        }
        catch{}
        
        //create the search request
        let searchRequest = MKLocalSearchRequest()
        for index in 0 ... addressArray.count-1{
         searchRequest.naturalLanguageQuery = addressArray[index]
         
            let activeSearch = MKLocalSearch(request: searchRequest)
            activeSearch.start {(response, error) in
                UIApplication.shared.endIgnoringInteractionEvents()
                if response == nil {
                    
                    print("Error")
                }
                else {
                    //getting data
                    let latitude = response?.boundingRegion.center.latitude
                    let longitude = response?.boundingRegion.center.longitude
                    
                    //create annotation
                    let annotation = MKPointAnnotation()
                    let name = self.contacts[index].firstName! + " " + self.contacts[index].lastName!
                    annotation.title = name
                    annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                    self.mapView.addAnnotation(annotation)
                    
                    //zooming in on annotation
                    let coordinate :CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                    let span = MKCoordinateSpanMake(0.5, 0.5)
                    let region = MKCoordinateRegionMake(coordinate, span)
                    self.mapView.setRegion(region, animated: true)
                }
                
            }
            
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
