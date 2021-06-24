SWIFT CODE

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueWebsites"){
            if let url = URL(string: "https://apps.apple.com/us/app/aviator-words/id1030888319") {
                webView.load(URLRequest(url: url))
            }
        }
    }



    UIViewController


        @IBAction func openAviator(_ sender: Any) {
        
        if let url = URL(string: "https://apps.apple.com/us/app/aviator-words/id1030888319") {
            UIApplication.shared.open(url)
        }
    
    }

    @IBAction func openDecorateWords(_ sender: Any) {
        
        if let url = URL(string: "https://apps.apple.com/us/app/decorate-words/id1018102009") {
            UIApplication.shared.open(url)
        }
        
    }
    
    @IBAction func openLinkedin(_ sender: Any) {

        if let url = URL(string: "https://www.linkedin.com/in/miltonlesliesanches/") {
            UIApplication.shared.open(url)
        }

    }


import UIKit
import WebKit

class ViewControllerWeb: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://mleslie.com.br/v5/index.php") {
                        webView.load(URLRequest(url: url))
                    }
    }






