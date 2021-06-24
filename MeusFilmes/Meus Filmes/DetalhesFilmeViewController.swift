//
//  DetalhesFilmeViewController.swift
//  Meus Filmes
//
//  Created by Milton Leslie Sanches on 2020-06-27.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import Foundation
import UIKit

class DetalhesFilmeViewController: UIViewController {
    
    @IBOutlet weak var filmeImageView: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descricalLabel: UILabel!
    var filme: Filme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmeImageView.image = filme.imagem
        tituloLabel.text = filme.titulo
        descricalLabel.text = filme.descricao
    }
    
}
