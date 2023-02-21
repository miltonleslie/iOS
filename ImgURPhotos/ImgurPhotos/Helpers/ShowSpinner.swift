//
//  ShowSpinner.swift
//  ImgURPhotos
//
//  Created by Milton Leslie Sobrinho de Souza Sanches on 17/02/23.
//

import UIKit

fileprivate var spinnerView : UIView?

extension UIViewController {
    
    func showSpinner(View: UIView) {
        
        spinnerView = UIView(frame: self.view.bounds)
        spinnerView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
        
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.center = spinnerView!.center
        indicatorView.startAnimating()
        spinnerView?.addSubview(indicatorView)
        self.view.addSubview(spinnerView!)
        
    }
    
    func removeSpinner() {
        
        spinnerView?.removeFromSuperview()
        spinnerView = nil
        
    }
    
}
