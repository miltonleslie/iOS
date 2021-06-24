//
//  ViewController.swift
//  Cara ou Coroa
//
//  Created by Milton Leslie Sanches on 2020-06-26.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "jogarMoeda" {
            
            let vcDestino = segue.destination as! DetailsViewController
            
            vcDestino.numeroRandomico = Int( arc4random_uniform(2) )
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

