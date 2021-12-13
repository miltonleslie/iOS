//
//  ViewController.swift
//  GerApp
//
//  Created by Milton Leslie Sobrinho de Souza Sanches on 08/11/21.
//

import UIKit

//MARK: Controller
class ViewControllerLogin: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwdText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: Button Action
    @IBAction func buttonConfirm(_ sender: UIButton) {

        let token = "0x1E06****BF5C"
        let email = emailText?.text
        let passwd = passwdText?.text
        var s: String = "https://www.transfersbrazil.com.br/api/get_users.php?"
        s += "token=" + token
        s += "&email=" + email!
        s += "&password=" + passwd!
        print(s)
        checkLogin(urlString: s)
        
    }
}

//MARK: Login
extension ViewControllerLogin {
    
    func checkLogin(urlString: String) {
        
        var erro = false
        let url = NSURL(string: urlString)
        
        var downloadTask = URLRequest(url: (url as URL?)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            let objetoJson = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            //print(objetoJson) // return the raw and pure json
            
            if let jsonArray = objetoJson as? [[String: Any]] {
                //print("Antes do for ")
                for planeDict in jsonArray{
                    //print("Entrou no for ")
                    guard
                        let ch_usuario = planeDict["ch_usuario"] as? String,
                        let nm_usuario = planeDict["nm_usuario"] as? String,
                        var email = planeDict["email"] as? String
                    else { continue }
                    
                    // Details Information
                    email = email.replacingOccurrences(of: "'", with: " ")
                    
                    
                    print("Resposta: ch_usuario: \(ch_usuario)")
                    print("Resposta: nm_usuario: \(nm_usuario)")
                    print("Resposta: email: \(email)")
                    
                    DispatchQueue.main.async {
                        
                        self.performSegue(withIdentifier: "segueMain", sender: nil)
                        //self.performSegue(withIdentifier: "segueMain", sender: self)
                        
                        /* func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                            if segue.identifier == "segueMain" {
                                let viewControllerDestino = segue.destination as! ViewControllerMain
                                viewControllerDestino.ch_usuario = ch_usuario
                                viewControllerDestino.nm_usuario = nm_usuario
                                viewControllerDestino.email = email
                            }
                        } */
                    }
                }
            } else {
                // Não logou
                print("Não foi possível logar. Usuário/Senha inválidos.")
                erro = true

            }
            if erro == true {
                
                DispatchQueue.main.async {
                    self.ShowMessage()
                }
            }

        }).resume()
        
    }
    
}

//MARK: ShowMessage
extension ViewControllerLogin {

    func ShowMessage() {
        let alert = UIAlertController(title: "Atenção!", message: "Não foi possível logar. Usuário/Senha inválidos.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
