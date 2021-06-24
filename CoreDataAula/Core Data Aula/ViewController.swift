//
//  ViewController.swift
//  Core Data Aula
//
//  Created by Milton Leslie Sanches on 2020-09-01.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // Criar requisição - SELECT
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Produto")
        
        // Ordenar de AZ e ZA
        let ordenacaoAZ = NSSortDescriptor(key: "descricao", ascending: true)
        let ordenacaoZA = NSSortDescriptor(key: "preco", ascending: false)

        // Criar filtros
        //let predicate = NSPredicate(format: "descricao == %@", "Mackbook Pro 15")
        //let predicate = NSPredicate(format: "descricao contains %@", "Mackbook Pro")
        //let predicate = NSPredicate(format: "descricao contains [c] %@", "Mackbook Pro") // case sensitive
        //let predicate = NSPredicate(format: "descricao beginswith [c] %@", "B") // case sensitive
        //let predicate = NSPredicate(format: "preco >= %@", "200.00")

        //let filtroDescricao = NSPredicate(format: "descricao contains [c] %@", "Pro")
        //let filtroPreco = NSPredicate(format: "preco >= %@", "200.00")
        
        // let combinacaoFiltro = NSCompoundPredicate(andPredicateWithSubpredicates: [filtroDescricao,filtroPreco] )
        //let combinacaoFiltro = NSCompoundPredicate(orPredicateWithSubpredicates: [filtroDescricao,filtroPreco] )
        
        //let predicate = NSPredicate(format: "descricao == %@", "Macbook Pro 13")
        
        // Aplicar filtros criados à requisição
        requisicao.sortDescriptors = [ordenacaoAZ,ordenacaoZA]
        // Apply filtro
        //requisicao.predicate = predicate
        //requisicao.predicate = combinacaoFiltro
        
        do {
            let produtos = try context.fetch(requisicao)
            
            if produtos.count > 0 {
                
                for produto in produtos as! [NSManagedObject] {
                    
                    if let descricao = produto.value(forKey: "descricao") {
                        if let cor = produto.value(forKey: "cor"){
                            if let preco = produto.value(forKey: "preco") {
                                print( String(describing: descricao) + " / " + String(describing: cor ) + " / " + String(describing: preco) )
                                
                                //Atualizar Produto - UPDATE
                                /*
                                produto.setValue(133.33, forKey: "preco")
                                produto.setValue("Macbook Pro 13", forKey: "descricao")
                                produto.setValue("LightGray", forKey: "cor")

                                do {
                                    try context.save()
                                    print("Sucesso save!")
                                } catch {
                                    print("Erro save.")
                                } */
                                
                                // Remover - DELETE
                                /*context.delete( produto )
                                do {
                                    try context.save()
                                    print("Sucesso!")
                                } catch {
                                    print("Erro.")
                                }*/
                                
                                
                            }
                        }
                    }
                    
                }
                
            } else {
                print("Nenhum produto encontrado")
            }
        } catch {
            print("Erro ao recuperar os produtos!")
        }
        
        
        /*
        // Criar Entidade Produto
        let produto = NSEntityDescription.insertNewObject(forEntityName: "Produto", into: context)
        
        // Configura Objeto - INSERT
        produto.setValue("Mackbook Pro 22", forKey: "descricao")
        produto.setValue("Ouro", forKey: "cor")
        produto.setValue(399.99, forKey: "preco")
        
        // Salvar dados
        do {
            try context.save()
            print("Sucesso ao salvar o Produto")
        } catch {
            print("Erro ao salvar o Produto")
        }
        */
        
        
        // Recuperar Dados Usuarios
        // Criar uma requisição - SELECT
        /*
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")

        do {
            let usuarios = try context.fetch(requisicao)
            
            if usuarios.count > 0 {
                
                for usuario in usuarios as! [NSManagedObject] {
                    if let nomeUsuario = usuario.value(forKey: "nome") {
                        print(nomeUsuario)
                    }
                }
                
            } else {
                print("Nenhum úsuario encontrado")
            }
            
        } catch {
            print("Erro ao recuperar os dados")
        }
        */
        // Criar entidade - INSERT
        /*let usuario = NSEntityDescription.insertNewObject(forEntityName: "Usuario", into: context)
        
        // Configura objeto
        usuario.setValue("Jamilie Ferrarez", forKey: "nome")
        usuario.setValue(24, forKey: "idade")
        usuario.setValue("jamilieferrarez", forKey: "login")
        usuario.setValue("1234", forKey: "senha")

        // Salvar (persistir) os dados
        do {
            try context.save()
            print("Dados salvos corretamente")
        } catch {
            print("Erro ao salvar dados")
        }
        */
    }


}

