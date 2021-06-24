//
//  Filme.swift
//  Meus Filmes
//
//  Created by Milton Leslie Sanches on 2020-06-27.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit


class Filme {
    
    var titulo: String!
    var descricao: String!
    var imagem: UIImage!
 
    init(titulo: String, descricao: String, imagem: UIImage){
        
        self.titulo = titulo
        self.descricao = descricao
        self.imagem = imagem
    }
    
}
