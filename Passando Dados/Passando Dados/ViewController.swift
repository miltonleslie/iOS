//
//  ViewController.swift
//  Passando Dados
//
//  Created by Milton Leslie Sanches on 2020-06-26.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nomeCampo: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "enviarDados" {
            
            let viewControllerDestino = segue.destination as! DetalhesViewController
            
            viewControllerDestino.textoRecebido = nomeCampo.text!
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    

}

