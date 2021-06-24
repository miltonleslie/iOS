//
//  TarefaUserDefaults.swift
//  Lista de Tarefas
//
//  Created by Milton Leslie Sanches on 2020-07-23.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit

class TarefaUserDefaults {
    
    let chave = "ListaTarefas"
    var tarefas: [String] = []
    
    func salvar(tarefa: String){
        
        // Recuperar Tarefas já Salvas
        tarefas = listar()
        
        // Salvar Tarefa
        tarefas.append( tarefa )
        UserDefaults.standard.set( tarefa, forKey: chave)
        
    }
    
    func listar() -> Array<String> {
        
        let dados = UserDefaults.standard.object(forKey: chave)
        
        if dados != nil {
            return dados as! Array<String>
        } else {
            return []
        }
        
    }
    
    
}
