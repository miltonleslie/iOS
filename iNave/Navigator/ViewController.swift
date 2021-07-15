//
//  ViewController.swift
//  Navegator
//
//  Created by Milton Leslie on 2021-07-02.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressNumberLabel: UILabel!    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var mapa: MKMapView!
    var locman = CLLocationManager()
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var directionNumberLabel: UILabel!
    
    @IBAction func openWebsite(_ sender: Any) {
        openMLeslie()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locman.delegate = self
        locman.desiredAccuracy = kCLLocationAccuracyBest
        locman.requestWhenInUseAuthorization()
        locman.startUpdatingLocation()
        locman.headingFilter = 5
        locman.headingOrientation = .portrait
        locman.startUpdatingHeading()
        
        
        mapa.showsCompass = false
        let compassButton = MKCompassButton(mapView: mapa)
        compassButton.compassVisibility = .visible
        mapa.addSubview(compassButton)
        // Positioning
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        compassButton.trailingAnchor.constraint(equalTo: mapa.trailingAnchor, constant: -12).isActive = true
        compassButton.topAnchor.constraint(equalTo: mapa.topAnchor, constant: 12).isActive = true
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Array with User location
        let userLocation = locations.last
        let latitude = userLocation?.coordinate.latitude
        let longitude = userLocation?.coordinate.longitude
        
        //let longitudeOE =
        let longitudeOE = longitude! > 0 ? "E" : "O"
        let latitudeNS = latitude! > 0 ? "N" : "S"

        latitudeLabel.text = String(format: "%.6f", latitude!) + "\u{22}" + latitudeNS
        longitudeLabel.text = String(format: "%.6f", longitude!) + "\u{22}" + longitudeOE
        
        
        //  speed meters/second to kilometers/hour 3.6 || miles per hour 2.23694 || nautical miles per hour 1.94384
        let speed = userLocation!.speed * 3.6
        velocityLabel.text = String(format: "%.1f", speed ) // meters per second

        altitudeLabel.text = String(format: "%.1f", userLocation!.altitude)
        
        centerUser()
        
        CLGeocoder().reverseGeocodeLocation(userLocation!) { (localDetails, erro) in
            if erro == nil { // if e=&& ou=||
                if let localData = localDetails?.first {
                    
                    var throughfare = ""
                    if localData.thoroughfare != nil {
                        throughfare = localData.thoroughfare!
                    }
                    
                    var subThroughfare = ""
                    if localData.subThoroughfare != nil {
                        subThroughfare = localData.subThoroughfare!
                    }
                    
                    var locality = ""
                    if localData.locality != nil {
                        locality = localData.locality!
                    }

                    /* var subLocality = ""
                    if localData.subLocality != nil {
                        subLocality = localData.subLocality!
                    } */

                    /* var postalCode = ""
                    if localData.postalCode != nil {
                        postalCode = localData.postalCode!
                    } */

                    var country = ""
                    if localData.country != nil {
                        country = localData.country!
                    }

                    var administrativeArea = ""
                    if localData.administrativeArea != nil {
                        administrativeArea = localData.administrativeArea!
                    }

                    /* var subAdministrativeArea = ""
                    if localData.subAdministrativeArea != nil {
                        subAdministrativeArea = localData.subAdministrativeArea!
                    } */
                    
                    self.addressLabel.text = throughfare
                    self.addressNumberLabel.text = subThroughfare
                    //self.bairro.text = subLocality
                    self.cityLabel.text = locality
                    self.stateLabel.text = administrativeArea
                    self.countryLabel.text = country
                    //self.cep.text = postalCode
                    
                }
            } else {
                //print(erro!)
            }

        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            
            let alertController = UIAlertController(title: "Location services", message: "Turning on location services allows this app to show you where you are on the map!", preferredStyle: .alert)
            
            let actionController = UIAlertAction(title: "Open config", style: .default, handler: { (alertConfig) in
                
                if let config = NSURL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(config as URL) {
                        UIApplication.shared.open( config as URL , completionHandler: { (success) in
                        })
                    }
                }
                
            })
            
            let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alertController.addAction( actionController )
            alertController.addAction( actionCancel )
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // Compass
        func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
            var h = newHeading.magneticHeading
            let h2 = newHeading.trueHeading // -1 if no location info
            //print("\(h) \(h2) ")
            if h2 >= 0 {
                h = h2
            }
            let cards = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
            func degToName(_ d:Double) -> String {
                let divCount = cards.count
                let angularRange = 360.0 / Double(divCount)
                let bucket = Int((d + angularRange/2.0)/angularRange)
                return cards[bucket % divCount]
            }
            let dir = degToName(h)
            if self.directionLabel.text != dir {
                self.directionLabel.text = dir
            }
            // Direction Number
            var dirx = String(format: "%.0f", h2 )
            if h2 == 0 {
                dirx = "000"
            } else if h2<10 {
                dirx = "00" + dirx
            } else if h2 < 100 {
                dirx = "0" + dirx
            } // if e=&& ou=||
            self.directionNumberLabel.text = dirx
        }
        
        func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
            //print("he asked me, he asked me")
            return true // if you want the calibration dialog to be able to appear
        }

    
    // Show Website MLeslie
    func openMLeslie(){

        if let url = URL(string: "https://mleslie.com.br/index.php") {
                UIApplication.shared.open(url)
            }

    }
    
    func centerUser(){
        if let coordenadas = locman.location?.coordinate {
            // Número 100 é a distância em altura
            let regiao = MKCoordinateRegion.init(center: coordenadas, latitudinalMeters: 400, longitudinalMeters: 400)
            mapa.setRegion(regiao, animated: true)
        }
    }

}
