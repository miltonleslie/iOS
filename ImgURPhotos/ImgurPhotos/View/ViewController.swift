//
//  ViewController.swift
//  ImgURPhotos
//
//  Created by Milton Leslie Sobrinho de Souza Sanches on 15/02/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    let navigationBar = UINavigationBar()
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: ViewController.self, action: #selector(refreshData))

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    var viewModel: ViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        
        setupView()
        setupConstraints()
        fetchData()
    }
    
    // MARK: - Button Refresh
    @objc func refreshData() {
        fetchData()
    }
    
    // MARK: - Fetch API data
    func fetchData() {
        self.showSpinner(View: view)
        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.removeSpinner()
            }
        }
    }

    // MARK: - Setup View
    func setupView() {
        navigationController?.navigationBar.addSubview(navigationBar)
        navigationItem.title = "Imgur Photos"
        navigationItem.rightBarButtonItem = refreshButton

        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    // MARK: - Set Image on CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        if let item = viewModel.itemAtIndex(index: indexPath.row) {
            cell.imageView.image = item.image
        } else {
            cell.imageView.image = UIImage(named: "cat0")
        }
        return cell
    }

}

extension ViewController: UICollectionViewDelegate {
    
    // MARK: - Call the ViewControllerDetails
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.deselectItem(at: indexPath, animated: true)

        let item = viewModel.itemAtIndex(index: indexPath.row)
        let selectedImage = item?.image
        let selectedText = item?.title ?? "No title"
        let viewController = ViewControllerDetails(image: selectedImage, text: selectedText)
        navigationController?.pushViewController(viewController, animated: true)

    }
    
    // MARK: - CollectionView Setup
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width/3.2),
            height: (view.frame.size.width/3.2)-5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
}
