//
//  ViewControllerNotifications.swift
//  GerApp
//
//  Created by Milton Leslie Sobrinho de Souza Sanches on 10/11/21.
//

import UIKit

class ViewControllerNotifications: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var idAppLabel: UILabel!
    @IBOutlet weak var nameAppLabel: UILabel!
    @IBOutlet weak var actionDateLabel: UILabel!
    @IBOutlet weak var actionTimeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    
    var app: Application!
    var notices: [Notification] = []

    var urlString: String = "https://www.transfersbrazil.com.br/api/get_notifications.php?token=0x1E06C0F13C5900406B184EB40978422D65EBC372CF06183ECE3A6B8F3A1EBF5C&id_application="
    
    override func viewDidLoad() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //self.tableView.backgroundColor = UIColor.blue

        idAppLabel.text = app.id_application
        nameAppLabel.text = app.app_name
        actionDateLabel.text = app.action_date
        actionTimeLabel.text = app.action_time
        userNameLabel.text = app.user_name
        statusLabel.text = app.status
        messageLabel.text = app.last_message

        urlString = urlString + app.id_application
        
        downloadJsonWithTask(urlString: urlString)
        
    }
    
    @IBAction func refreshNotifications(_ sender: UIBarButtonItem) {
        
        downloadJsonWithTask(urlString: urlString)
        
    }
    
    
    func downloadJsonWithTask(urlString: String) {
            
            let url = NSURL(string: urlString)
            
            var downloadTask = URLRequest(url: (url as URL?)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
            
            downloadTask.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
                let objetoJson = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                //print(objetoJson) // return the raw and pure json
                if let jsonArray = objetoJson as? [[String: Any]] {

                    self.notices = []
                    
                    for planeDict in jsonArray{
                        //print("Entrou no for ")
                        guard
                            let id_notifications = planeDict["id_notifications"] as? String,
                            let id_application = planeDict["id_application"] as? String,
                            let action_date = planeDict["action_date"] as? String,
                            let action_time = planeDict["action_time"] as? String,
                            let action_difference = planeDict["action_difference"] as? String,
                            let action_seconds = planeDict["action_seconds"] as? String,
                            let user_id = planeDict["user_id"] as? String,
                            let user_name = planeDict["user_name"] as? String,
                            let message = planeDict["message"] as? String,
                            let status = planeDict["status"] as? String,
                            let checked = planeDict["checked"] as? String
                        else { continue }
                        //print(id_notifications)
                        // Details Information
                        var notice: Notification
                        notice = Notification(id_notifications: id_notifications, id_application: id_application, action_date: action_date, action_time: action_time, action_difference: action_difference, action_seconds: action_seconds, user_id: user_id, user_name: user_name, message: message, status: status, checked: checked)
                        self.notices.append( notice )
                        
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
        return notices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Reuse or create a cell of the appropriate type.
        let reuseNotification = "reuseNotification"
        let celula = tableView.dequeueReusableCell(withIdentifier: reuseNotification, for: indexPath) as! NotificationCell

        // Fill the fields
        let notice: Notification = notices[ indexPath.row ]
        
        // Configure the cell’s contents with data from the fetched object.
        celula.userNameLabel?.text = notice.user_name
        celula.actionDateLabel?.text = notice.action_date
        celula.actionTimeLabel?.text = notice.action_time
        celula.actionDifferenceLabel?.text = notice.action_difference
        celula.actionSecondsLabel?.text = notice.action_seconds
        celula.statusLabel?.text = notice.status
        celula.messageLabel?.text = notice.message
        //print(notice.last_message)
        return celula
        
    }
    
    @IBAction func buttonInactivate(_ sender: UIButton) {
        ShowMessage(message: "Applicação Inativada!")
    }
    
    @IBAction func buttonActivate(_ sender: UIButton) {
        ShowMessage(message: "Applicação Ativada!")
    }
    
}


//MARK: ShowMessage
extension ViewControllerNotifications {

    func ShowMessage(message: String) {
        let alert = UIAlertController(title: "Atenção!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
