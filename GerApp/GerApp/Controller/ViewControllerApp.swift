//
//  ViewControllerApp.swift
//  GerApp
//
//  Created by Milton Leslie Sobrinho de Souza Sanches on 08/11/21.
//

import UIKit

class ViewControllerApp: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ch_usuario: String = "0"
    var nm_usuario: String = "0"
    var email: String = "0"
    let urlString: String = "https://www.transfersbrazil.com.br/api/get_applications.php?token=0x1E06C0F13C5900406B184EB40978422D65EBC372CF06183ECE3A6B8F3A1EBF5C"

    @IBOutlet weak var tableView: UITableView!
    
    var apps: [Application] = []
    
    override func viewDidLoad() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.white

        // Get Details Information
        downloadJsonWithTask(urlString: urlString)

        
    }
    
    @IBAction func buttonRefresh(_ sender: UIBarButtonItem) {
        
        downloadJsonWithTask(urlString: urlString)
        
    }
    
    
    func downloadJsonWithTask(urlString: String) {
            
            let url = NSURL(string: urlString)
            //print(urlString)
            var downloadTask = URLRequest(url: (url as URL?)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
            
            downloadTask.httpMethod = "POST"
            
            URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
                let objetoJson = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                //print(objetoJson) // return the raw and pure json
                if let jsonArray = objetoJson as? [[String: Any]] {
                    
                    self.apps = []
                    
                    //print("Antes do for ")
                    for planeDict in jsonArray{
                        //print("Entrou no for ")
                        guard
                            let id_app = planeDict["id_application"] as? String,
                            let app_name = planeDict["application_name"] as? String,
                            let action_date = planeDict["action_date"] as? String,
                            let action_time = planeDict["action_time"] as? String,
                            let action_difference = planeDict["action_difference"] as? String,
                            let action_seconds = planeDict["action_seconds"] as? String,
                            let user_id = planeDict["user_id"] as? String,
                            let user_name = planeDict["user_name"] as? String,
                            let last_message = planeDict["last_message"] as? String,
                            let status = planeDict["status"] as? String
                        else { continue }
                        
                        // Details Information
                        // description = description.replacingOccurrences(of: "<br>", with: " ")
                        var appli: Application
                        appli = Application(id_application: id_app, app_name: app_name, action_date: action_date, action_time: action_time, action_difference: action_difference, action_seconds: action_seconds, user_id: user_id, user_name: user_name, last_message: last_message, status: status)
                        self.apps.append( appli )
                        
                        OperationQueue.main.addOperation {
                            self.tableView.reloadData()
                        }

                    }
                }
       }).resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Reuse or create a cell of the appropriate type.
        let reuseApplication = "reuseApplication"
        let celula = tableView.dequeueReusableCell(withIdentifier: reuseApplication, for: indexPath) as! ApplicationCell

        // Fill the fields
        let app: Application = apps[ indexPath.row ]
        // Configure the cell’s contents with data from the fetched object.
        celula.appId?.text = app.id_application
        celula.appName?.text = app.app_name
        celula.appMessage?.text = app.last_message
        celula.appDate?.text = app.action_date
        celula.appTime?.text = app.action_time
        celula.appUser?.text = app.user_name
        celula.appStatus?.text = app.status
        
        return celula
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueNotifications" {
            
            if let indexPath = tableView.indexPathForSelectedRow {

                //Change the selected background view of the cell.
                tableView.deselectRow(at: indexPath, animated: true)

                let app = self.apps[ indexPath.row ]
                let viewControllerDestiny = segue.destination as! ViewControllerNotifications
                viewControllerDestiny.app = app
                
            }

        }
        
    }
    
}
