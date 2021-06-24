//
//  ViewController.swift
//  Salvar dados
//
//  Created by Milton Leslie Sanches on 2020-06-29.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults.standard.set("azul", forKey: "corFundo")
        //let texto = UserDefaults.standard.object(forKey: "corFundo")
        //print(texto)
        
        //var comidas: [String] = ["Lasanha","Pizza","Torta"]
        //UserDefaults.standard.set(comidas, forKey: "comidas")
        
        //UserDefaults.standard.removeObject(forKey: "corFundo")
        
        let retorno = UserDefaults.standard.object(forKey: "corFundo")
        print(retorno)
        
    }


}

