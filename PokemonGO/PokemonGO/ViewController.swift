//
//  ViewController.swift
//  PokemonGO
//
//  Created by Milton Leslie Sanches on 2020-09-10.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    var contador = 0
    var coreDataPokemon: CoreDataPokemon!
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Solicita autorização do usuário para acessar posicionamento
        mapa.delegate = self
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        // Recuperar pokemons
        self.coreDataPokemon = CoreDataPokemon()
        self.pokemons = self.coreDataPokemon.recuperarTodosPokemons()
        
        // Exibir pokemons
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            
            if let coordenadas = self.gerenciadorLocalizacao.location?.coordinate {
                
                let totalPokemons = self.pokemons.count
                let indicePokemonAleatorio = arc4random_uniform(UInt32(totalPokemons))
                let pokemon = self.pokemons[ Int(indicePokemonAleatorio) ]
                
                let anotacao = PokemonAnotacao(coordenadas: coordenadas, pokemon: pokemon)
                
                var latAleatoria = Double( arc4random_uniform(400) )
                latAleatoria = ( latAleatoria - 100 ) / 200000.0

                var longAleatoria = Double( arc4random_uniform(400) )
                longAleatoria = ( longAleatoria - 100) / 200000.0
                
                anotacao.coordinate = coordenadas
                anotacao.coordinate.latitude  += latAleatoria
                anotacao.coordinate.longitude += longAleatoria
                
                self.mapa.addAnnotation(anotacao)
            }
            
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // exibe imagens nas anotações
        let anotacaoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)

        if annotation is MKUserLocation {
            anotacaoView.image = #imageLiteral(resourceName: "player")
        } else {
            let pokemon = (annotation as! PokemonAnotacao).pokemon
            anotacaoView.image = UIImage(named: pokemon.nomeImagem! )
        }
        
        var frame = anotacaoView.frame
        frame.size.height = 40
        frame.size.width = 40
        anotacaoView.frame = frame
        
        return anotacaoView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        let anotacao = view.annotation
        let pokemon = (view.annotation as! PokemonAnotacao).pokemon
        
        
        // Desmarca a anotação
        mapView.deselectAnnotation(anotacao, animated: true)
        // Anotação Selecionada - Ao clicar na Anotação passa por este método
        if anotacao is MKUserLocation {
            // Eu mesmo - Minha anotação
            return
        }
        
        if let coordAnotacao = anotacao?.coordinate {
            // Número 100 é a distância em altura
            let regiao = MKCoordinateRegion.init(center: coordAnotacao, latitudinalMeters: 200, longitudinalMeters: 200)
            mapa.setRegion(regiao, animated: true)
            
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            // Centraliza Mapa de acordo com a Anotação Clicada
            if let coord = self.gerenciadorLocalizacao.location?.coordinate {
                if self.mapa.visibleMapRect.contains(MKMapPoint(coord) ) {
                    // Captura o Pokemon
                    self.coreDataPokemon.salvarPokemon(pokemon: pokemon)
                    self.mapa.removeAnnotation( anotacao! )
                    
                    let alertController = UIAlertController(title: "Parabéns!",
                                                            message: "Você capturou o Pokemón: \(String(describing: pokemon.nome)) ",
                        preferredStyle: .alert )
                    let okay = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okay)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Você não pode Capturar!",
                                                           message: "Você precisa se aprocimar mais para capturar o Pokemón.",
                        preferredStyle: .alert )
                    let okay = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okay)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        // Mantém a coordenada do usuário no centro da tela do mapa
        // Recupera Coordenadas
        if contador < 3 {
            
            self.centralizar()

            contador += 1

        } else {
            gerenciadorLocalizacao.stopUpdatingLocation()
        }
            
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Solicitação de Autorização de Localização
        if status != .authorizedWhenInUse && status != .notDetermined {
            // Alerta
            let alertController = UIAlertController(title: "Permissão de localização", message: "Para que você possa caçar pokemons, precisamos da sua localização!! Por favor, habilite.", preferredStyle: .alert)
            
            let acaoConfiguracoes = UIAlertAction(title: "Abrir Configurações", style: .default, handler: { (alertaConfiguracoes) in
                if let configuracoes = NSURL(string: UIApplication.openSettingsURLString ){
                    UIApplication.shared.open(configuracoes as URL)
                }
            })
            
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func centralizar(){
        if let coordenadas = gerenciadorLocalizacao.location?.coordinate {
            // Número 100 é a distância em altura
            let regiao = MKCoordinateRegion.init(center: coordenadas, latitudinalMeters: 200, longitudinalMeters: 200)
            mapa.setRegion(regiao, animated: true)
            
        }
    }
    
    @IBAction func buttonCenter(_ sender: Any) {
        
        self.centralizar()
        
    }
    @IBAction func abrirPokedex(_ sender: Any) {
    }
    
}

