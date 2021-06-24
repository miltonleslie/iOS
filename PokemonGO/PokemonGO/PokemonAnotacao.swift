//
//  PokemonAnotacao.swift
//  PokemonGO
//
//  Created by Milton Leslie Sanches on 2020-09-16.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnotacao: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    init(coordenadas: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordenadas
        self.pokemon = pokemon
    }
    
}
