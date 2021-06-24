//
//  ViewController.swift
//  Signos
//
//  Created by Milton Leslie Sanches on 2020-06-27.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var signos:[String] = []
    var significados:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure signos
        signos.append("Áries")
        signos.append("Touro")
        signos.append("Gêmeos")
        signos.append("Câncer")
        signos.append("Leão")
        signos.append("Virgem")
        signos.append("Libra")
        signos.append("Escorpião")
        signos.append("Sagitário")
        signos.append("Capricórnio")
        signos.append("Aquário")
        signos.append("Peixes")

        significados.append("É importante verificar que não somente todas as coisas cooperam para o bem daqueles que amam a Deus terão oportunidades.")
        significados.append("Crê em Deus e em seu filho Jesus Cristo.")
        significados.append("3")
        significados.append("4")
        significados.append("5")
        significados.append("6")
        significados.append("7")
        significados.append("8")
        significados.append("9")
        significados.append("10")
        significados.append("11")
        significados.append("12")

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celulaReuso = "celulaReuso"
        
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath)
        
        celula.textLabel?.text = signos[indexPath.row]
        
        return celula        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let alertaController = UIAlertController(title: "Significado do Signo", message: significados[ indexPath.row], preferredStyle: .alert)
        
        let acaoConfirmar = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertaController.addAction(acaoConfirmar)
        
        present( alertaController , animated: true, completion: nil )
        
        // print ( significadoSignos[ indexPath.row ] )
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

