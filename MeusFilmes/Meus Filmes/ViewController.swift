//
//  ViewController.swift
//  Meus Filmes
//
//  Created by Milton Leslie Sanches on 2020-06-27.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var filmes: [Filme] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var filme: Filme
        
        filme = Filme(titulo: "007 - Spectre", descricao: "Descricao1 ", imagem: #imageLiteral(resourceName: "filme1"))
        filmes.append( filme )
        
        filme = Filme(titulo: "Star Wars", descricao: "Descricao2 ", imagem: #imageLiteral(resourceName: "filme2"))
        filmes.append( filme )

        filme = Filme(titulo: "Impacto Mortal", descricao: "Descricao3 ", imagem: #imageLiteral(resourceName: "filme3"))
        filmes.append( filme )

        filme = Filme(titulo: "Deadpool", descricao: "Descricao4 ", imagem: #imageLiteral(resourceName: "filme4"))
        filmes.append( filme )

        filme = Filme(titulo: "O Regresso", descricao: "Descricao5 ", imagem: #imageLiteral(resourceName: "filme5"))
        filmes.append( filme )

        filme = Filme(titulo: "A Herdeira", descricao: "Descricao6 ", imagem: #imageLiteral(resourceName: "filme6"))
        filmes.append( filme )

        filme = Filme(titulo: "Caçadores de emoção", descricao: "Descricao7 ", imagem: #imageLiteral(resourceName: "filme7"))
        filmes.append( filme )

        filme = Filme(titulo: "Regresso do Mal", descricao: "Descricao8 ", imagem: #imageLiteral(resourceName: "filme8"))
        filmes.append( filme )

        filme = Filme(titulo: "Tarzan", descricao: "Descricao9 ", imagem: #imageLiteral(resourceName: "filme9"))
        filmes.append( filme )

        filme = Filme(titulo: "Hardcore", descricao: "Descricao10 ", imagem: #imageLiteral(resourceName: "filme10"))
        filmes.append( filme )

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let filme: Filme = filmes[ indexPath.row ]
        let celulaReuso = "celulaReuso"
                
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath) as! FilmeCelula
        
        celula.filmeImageView.image = filme.imagem
        celula.tituloLabel.text = filme.titulo
        celula.descricaoLabel.text = filme.descricao

        /*
        celula.filmeImageView.layer.cornerRadius = 42 // 84 / 2 metade do tamanho da Imagem
        celula.filmeImageView.clipsToBounds = true
        */
        
        
        /* celula.textLabel?.text = filme.titulo
        celula.imageView?.image = filme.imagem */
        
        return celula
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detalheFilme" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let filmeSelecionado = self.filmes[ indexPath.row ]
                
                let viewControllerDestino = segue.destination as! DetalhesFilmeViewController
                viewControllerDestino.filme = filmeSelecionado
                
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

