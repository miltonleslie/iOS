//
//  ViewController.swift
//  Frases do Dia
//
//  Created by Milton Leslie Sanches on 2020-06-19.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var legendaResultado: UILabel!
    
    
    @IBAction func buttonNovaFrase(_ sender: Any) {
        
        var frases: [String] = []
        
        frases.append("O Senhor é meu pastor e nada me faltará. Salmo 23:1")
        frases.append("Deus é o nosso refúgio e fortaleza. Salmo 46:1")
        frases.append("No principio era o verbo e o verbo estava com Deus e o Verbo era Deus. João 1:1")

        let numeroAleatorio = arc4random_uniform(3)
        
        legendaResultado.text = frases[Int(numeroAleatorio)]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

