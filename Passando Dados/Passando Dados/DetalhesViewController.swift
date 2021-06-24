//
//  DetalhesViewController.swift
//  Passando Dados
//
//  Created by Milton Leslie Sanches on 2020-06-26.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {

    @IBOutlet weak var resultadoLegenda: UILabel!

    var textoRecebido: String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultadoLegenda.text = textoRecebido
        
    }

}
