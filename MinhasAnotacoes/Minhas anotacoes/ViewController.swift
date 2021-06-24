//
//  ViewController.swift
//  Minhas anotacoes
//
//  Created by Milton Leslie Sanches on 2020-06-29.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textoCampo: UITextView!
    let chave = "minhaAnotacao"
        
    @IBAction func salvarAnotacao(_ sender: Any) {
        
        if let texto = textoCampo.text {
            UserDefaults.standard.set(texto, forKey: chave)
        }
        
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Usuário pressionou a tela")
        view.endEditing(true)
    }

    func recuperarAnotacao() -> String {

        if let textoRecuperado = UserDefaults.standard.object(forKey: chave) {
            
            return textoRecuperado as! String
        }
        return ""
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textoCampo.text = recuperarAnotacao()

    }
    

}
