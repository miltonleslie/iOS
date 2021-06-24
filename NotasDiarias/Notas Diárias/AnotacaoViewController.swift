//
//  AnotacaoViewController.swift
//  Notas Diárias
//
//  Created by Milton Leslie Sanches on 2020-09-02.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {
    
    @IBOutlet weak var texto: UITextView!
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configurações iniciais
        self.texto.becomeFirstResponder()
        
        if anotacao != nil {
            if let textoRecuperado = anotacao.value(forKey: "texto") {
                self.texto.text = String(describing: textoRecuperado)
            }
        } else {
            self.texto.text = ""
        }
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func salvar(_ sender: Any) {

        if anotacao != nil { // UPDATE
            self.atualizarAnotacao()
        } else { // INSERT
            self.salvarAnotacao()
        }
        // Retornar para a tela principal
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func atualizarAnotacao(){
        
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue( Date() , forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao atualizar!")
        } catch let erro {
            print("Erro ao atualizar anotacao:\(erro.localizedDescription)")
        }
    }
    
    func salvarAnotacao(){
        
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue( Date() , forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao salvar!")
        } catch let erro {
            print("Erro ao salvar anotacao:\(erro.localizedDescription)")
        }
        
    }

}
