//
//  ViewController.swift
//  Som dos Bichos
//
//  Created by Milton Leslie Sanches on 2020-09-26.
//  Copyright © 2020 Milton Leslie. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVAudioPlayer()
    
    @IBAction func cao(_ sender: Any) {
        self.executaSom(nomeSom: "cao")
    }
    @IBAction func gato(_ sender: Any) {
        self.executaSom(nomeSom: "gato")
    }
    @IBAction func leao(_ sender: Any) {
        self.executaSom(nomeSom: "leao")
    }
    @IBAction func macaco(_ sender: Any) {
        self.executaSom(nomeSom: "macaco")
    }
    @IBAction func ovelha(_ sender: Any) {
        self.executaSom(nomeSom: "ovelha")
    }
    @IBAction func vaca(_ sender: Any) {
        self.executaSom(nomeSom: "vaca")
    }
    func executaSom(nomeSom: String){
        if let path = Bundle.main.path(forResource: nomeSom, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.play()
            } catch {
                print("erro ao executar o áudio")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

