//
//  ViewController.swift
//  FirebaseConfiguracao
//
//  Created by Milton Leslie Sanches on 2020-12-08.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var firebase = Firebase.DatabaseReference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebase.child("pontuacao").setValue("100")

    }


}

