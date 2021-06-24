//
//  CoreDataPokemon.swift
//  PokemonGO
//
//  Created by Milton Leslie Sanches on 2020-09-16.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit
import CoreData

class CoreDataPokemon {
    
    // recuperar o contexto
    func getContext() -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context!
        
    }
    
    func recuperarTodosPokemons() -> [Pokemon]{
        
        let context = self.getContext()
        
        do{
            let pokemons = try context.fetch( Pokemon.fetchRequest()) as! [Pokemon]
            
            if pokemons.count == 0 {
                self.adicionarTodosPokemons()
                return recuperarTodosPokemons()
            }
            
            return pokemons
            
        }catch{}
        
        return []
        
    }
    
    // salvar pokemon como capturado
    func salvarPokemon( pokemon : Pokemon )  {
        
        let context = self.getContext()
        pokemon.capturado = true
        
        do{
            try context.save()
        } catch {}
        
    }
    
    // adicionar todos pokemons
    func adicionarTodosPokemons() {
        
        let context = self.getContext()
        
        // 12 pokemons
        self.criarPokemon(nome: "Mew", nomeImagem: "mew", capturado: true)
        self.criarPokemon(nome: "Bellsprout", nomeImagem: "bellsprout", capturado: false)
        self.criarPokemon(nome: "Bullbasaur", nomeImagem: "bullbasaur", capturado: false)
        self.criarPokemon(nome: "Caterpie", nomeImagem: "caterpie", capturado: false)
        self.criarPokemon(nome: "Charmander", nomeImagem: "charmander", capturado: false)
        self.criarPokemon(nome: "Meowth", nomeImagem: "meowth", capturado: false)
        self.criarPokemon(nome: "Pikachu-2", nomeImagem: "pikachu-2", capturado: true)
        self.criarPokemon(nome: "Psyduck", nomeImagem: "psyduck", capturado: false)
        self.criarPokemon(nome: "Rattata", nomeImagem: "rattata", capturado: false)
        self.criarPokemon(nome: "Snorlax", nomeImagem: "snorlax", capturado: false)
        self.criarPokemon(nome: "Squirtle", nomeImagem: "squirtle", capturado: false)
        self.criarPokemon(nome: "Zubat", nomeImagem: "zubat", capturado: false)
        
        do{
            try context.save()
        } catch {}

    }

    // criar os pokemons
    func criarPokemon(nome: String, nomeImagem: String, capturado: Bool ){
        
        let context = self.getContext()
        let pokemon = Pokemon(context: context)
        pokemon.nome = nome
        pokemon.nomeImagem = nomeImagem
        pokemon.capturado = capturado
        
        
    }
    
    // recupera pokemons capturados
    func recuperarPokemonsCapturados(capturado: Bool) -> [Pokemon] {
        
        let context = self.getContext()
        
        let requisicao = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        if capturado==true{
            requisicao.predicate = NSPredicate(format: "capturado == true" )
        } else {
            requisicao.predicate = NSPredicate(format: "capturado == false" )
        }
        
        
        do{
            let pokemons = try context.fetch(requisicao) as [Pokemon]
            return pokemons
        }catch{}
        
        return []
        
    }
        
}
