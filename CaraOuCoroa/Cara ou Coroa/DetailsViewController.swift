//
//  DetailsViewController.swift
//  Cara ou Coroa
//
//  Created by Milton Leslie Sanches on 2020-06-26.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var numeroRandomico: Int!
    
    @IBOutlet weak var moedaImagem: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if numeroRandomico == 0 { // cara
            moedaImagem.image = #imageLiteral(resourceName: "moeda_coroa")
            // moedaImagem.image = #imageLiteral(resourceName: "moeda_coroa")
        } else { // coroa
            moedaImagem.image = #imageLiteral(resourceName: "moeda_cara")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
