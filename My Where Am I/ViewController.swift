//
//  ViewController.swift
//  My Where Am I
//
//  Created by Jason Crawford on 7/1/16.
//  Copyright © 2016 Dax Apps. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        let userLocation:CLLocation = locations[0]
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation){ (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
//                if let p = placemarks?[0] {
                    
//                    var subThoroughfare = ""
                
                if placemarks!.count>0 {
                    let p = (placemarks![0])
                    
                    if (p.subThoroughfare != nil) {
                        
                        let subThoroughfare = p.subThoroughfare!
                    
                    
//                    if (p.subLocality != nil) {
                            
//                        _ = p.subLocality!
 
                    
                    
                    self.addressLabel.text = "\(subThoroughfare) \(p.thoroughfare!) \n \(p.subLocality) \n \(p.subAdministrativeArea!) \n \(p.postalCode!) \n \(p.country!)"
                    
                }
            }
            
        }
        
        
        
    }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

