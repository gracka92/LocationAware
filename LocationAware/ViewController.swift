//
//  ViewController.swift
//  LocationAware
//
//  Created by Gracjana Leonowicz on 05.10.2017.
//  Copyright © 2017 Gracjana Leonowicz. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        self.longitudeLabel.text = String(userLocation.coordinate.longitude)
        self.courseLabel.text = String(userLocation.course)
        self.speedLabel.text = String(userLocation.speed)
        self.altitudeLabel.text = String(userLocation.altitude)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil {
                print(error)

            } else {
                if let placemark = placemarks?[0] {
                    var subthoroughfare = " "
                    if placemark.subThoroughfare != nil {
                        subthoroughfare = placemark.subThoroughfare!
                    }
                    var thoroughfare = " "
                    if placemark.thoroughfare != nil {
                        thoroughfare = placemark.thoroughfare!
                    }
                    var subLocality = " "
                    if placemark.subLocality != nil {
                        subLocality = placemark.subLocality!
                    }
                    var subAdministrativeArea = " "
                    if placemark.subAdministrativeArea != nil {
                        subAdministrativeArea = placemark.subAdministrativeArea!
                    }
                    var postalCode = " "
                    if placemark.postalCode != nil {
                        postalCode = placemark.postalCode!
                    }
                    var country = " "
                    if placemark.country != nil {
                        country = placemark.country!
                    }
                    
                    let address =
                    """
                    \(subthoroughfare) \(thoroughfare)
                    \(subLocality)
                    \(subAdministrativeArea)
                    \(postalCode)
                    \(country)
                    """

                    self.addressLabel.text = address
                }
        
            }
            
        }
}
}


