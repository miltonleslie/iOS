//
//  ViewController.swift
//  Onde Estou
//
//  Created by Milton Leslie Sanches on 2020-08-17.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    
    @IBOutlet weak var valocidadeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var enderecoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let localizacaoUsuario = locations.last!
        let latitude = localizacaoUsuario.coordinate.latitude
        let longitude = localizacaoUsuario.coordinate.longitude
        
        self.latitudeLabel.text = latitude.description
        self.longitudeLabel.text = longitude.description
        self.valocidadeLabel.text = localizacaoUsuario.speed.description
        self.valocidadeLabel.layer.cornerRadius = 35
        self.valocidadeLabel.layer.masksToBounds = true
        
        let deltaLat : CLLocationDegrees = 0.01
        let deltaLon : CLLocationDegrees = 0.01
        
        let localizacao = CLLocationCoordinate2DMake(latitude, longitude)
        let areaExibicao: MKCoordinateSpan = MKCoordinateSpan( latitudeDelta: deltaLat, longitudeDelta: deltaLon)
        let regiao : MKCoordinateRegion = MKCoordinateRegion( center: localizacao, span: areaExibicao)
        mapa.setRegion( regiao, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(localizacaoUsuario) { (detalhesLocal, erro) in
            
            if (erro == nil) {

                if let dadosLocal = detalhesLocal?.first {
                
                    var thoroughfare = ""
                    if dadosLocal.thoroughfare != nil {
                        thoroughfare = dadosLocal.thoroughfare!
                    }
                    var subThoroughfare = ""
                    if dadosLocal.subThoroughfare != nil {
                        subThoroughfare = dadosLocal.subThoroughfare!
                    }
                    var locality = ""
                    if dadosLocal.locality != nil {
                        locality = dadosLocal.locality!
                    }
                    var subLocality = ""
                    if dadosLocal.subLocality != nil {
                        subLocality = dadosLocal.subLocality!
                    }
                    var postalCode = ""
                    if dadosLocal.postalCode != nil {
                        postalCode = dadosLocal.postalCode!
                    }
                    var country = ""
                    if dadosLocal.country != nil {
                        country = dadosLocal.country!
                    }
                    var administrativeArea = ""
                    if dadosLocal.administrativeArea != nil {
                        administrativeArea = dadosLocal.administrativeArea!
                    }
                    var subAdministrativeArea = ""
                    if dadosLocal.subAdministrativeArea != nil {
                        subAdministrativeArea = dadosLocal.subAdministrativeArea!
                    }

                    self.enderecoLabel.text = thoroughfare + " - " +
                                              subThoroughfare + " / " +
                                              locality + " / " +
                                              country
                    
                    print(
                        "\n / thoroughfare:" + thoroughfare +
                        "\n / subThoroughfare:" + subThoroughfare +
                        "\n / locality:" + locality +
                        "\n / subLocality:" + subLocality +
                        "\n / postalCode:" + postalCode +
                        "\n / country:" + country +
                        "\n / administrativeArea:" + administrativeArea +
                        "\n / subAdministrativeArea:" + subAdministrativeArea
                    )
                    
                    
                    
                }
            } else {
                
            }
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .authorizedWhenInUse {
            let alertaController = UIAlertController(title: "Permissão de localização", message: "Necessário permissão para acesso a sua localização.", preferredStyle: .alert)
            
            let acaoConfiguracao = UIAlertAction(title: "Abrir configurações", style: .default) { (alertaConfiguracoes) in
                
                if let configuracoes = NSURL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open( configuracoes as URL )
                }
                
                
            }
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertaController.addAction( acaoConfiguracao )
            alertaController.addAction( acaoCancelar )
            
            present( alertaController, animated: true, completion: nil )
            
        }
        
    }

}

