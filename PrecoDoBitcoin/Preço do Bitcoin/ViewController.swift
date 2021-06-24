//
//  ViewController.swift
//  Preço do Bitcoin
//
//  Created by Milton Leslie Sanches on 2020-09-26.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var precoBitcoin: UILabel!
    @IBOutlet weak var botaoAtualizar: UIButton!
    @IBAction func atualizarPreco(_ sender: Any) {
        
        self.recuperarPrecoBitcoin()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.recuperarPrecoBitcoin()
        
    }

    
    func formatarPreco(preco: NSNumber) -> String {
        
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let precoFinal = nf.string(from: preco ){
            return precoFinal
        }
        
        return "0,00"
        
    }
    
    
    func recuperarPrecoBitcoin(){
        
        self.botaoAtualizar.setTitle("Atualizando...", for: .normal)
        
        if let url = URL(string: "https://blockchain.info/ticker") {
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
                if erro == nil {
                    if let dadosRetorno = dados {
                        do {
                            if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: []) as? [String: Any] {
                                if let brl = objetoJson["BRL"] as? [String: Any] {
                                    if let preco = brl["buy"] as? Double {
                                        let precoFormatado = self.formatarPreco(preco: NSNumber(value: preco))
                                        DispatchQueue.main.async(execute: {
                                            self.precoBitcoin.text = "R$" + precoFormatado
                                            self.botaoAtualizar.setTitle("Atualizar", for: .normal)
                                        })
                                        // print(precoFormatado)
                                    }
                                }
                            }
                        } catch {
                            print("erro ao buscar dados")
                        }
                    }
                } else {
                    
                }

            }
            tarefa.resume()
        } /* fim if */
        
    }

}

