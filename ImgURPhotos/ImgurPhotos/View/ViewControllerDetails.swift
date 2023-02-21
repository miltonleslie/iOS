//
//  ViewControllerDetails.swift
//  ImgURPhotos
//
//  Created by Milton Leslie Sobrinho de Souza Sanches on 17/02/23.
//

import UIKit

class ViewControllerDetails: UIViewController {

    let imageView = UIImageView()
    let label = UILabel()

    init(image: UIImage?, text: String) {
        self.imageView.image = image
        self.label.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
                
        insertViews()
        setupViews()
        setupConstraints()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Insert Views
    private func insertViews() {
        
        view.addSubview(imageView)
        view.addSubview(label)
        
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true

        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {

        let screenWidth = UIScreen.main.bounds.width

        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: screenWidth - 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: screenWidth - 20).isActive = true

        label.topAnchor.constraint(equalTo: view.topAnchor, constant: screenWidth - 80).isActive = true
        label.widthAnchor.constraint(equalToConstant: screenWidth - 20).isActive = true
        label.heightAnchor.constraint(equalToConstant: screenWidth - 20).isActive = true

    }
}
