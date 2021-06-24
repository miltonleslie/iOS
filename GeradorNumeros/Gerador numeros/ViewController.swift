//
//  ViewController.swift
//  Gerador numeros
//
//  Created by Milton Leslie Sanches on 2020-06-19.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var legendaResultado: UILabel!
    
    @IBAction func gerarNumero(_ sender: Any) {
        
        let numero = arc4random_uniform(11)

        legendaResultado.text = String(numero)
        //print(numero)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

