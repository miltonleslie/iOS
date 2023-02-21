//
//  ViewModel.swift
//  ImgURPhotos
//
//  Created by Milton Leslie Sobrinho de Souza Sanches on 16/02/23.
//

import UIKit

protocol ViewModelProtocol {
    func fetchData(completion: @escaping () -> Void)
    func numberOfItems() -> Int
    func itemAtIndex(index: Int) -> ImageItem?
}

class ViewModel: ViewModelProtocol {

    private var items: [ImageItem] = []

    private let imageAPI = ImageAPI()

    func fetchData(completion: @escaping () -> Void) {
        imageAPI.searchImages(query: "cats") { [weak self] result in
            switch result {
            case .success(let data):
                for item in data {
                    if let images = item["images"] as? [[String: Any]],
                       let link = images[0]["link"] as? String,
                       let url = URL(string: link),
                       let data = try? Data(contentsOf: url),
                       let image = UIImage(data: data),
                       let title = item["title"] as? String {
                        let item = ImageItem(image: image, title: title)
                        self?.items.append(item)
                    }
                }
                completion()

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func numberOfItems() -> Int {
        return items.count
    }

    func itemAtIndex(index: Int) -> ImageItem? {
        guard index < items.count else {
            return nil
        }

        return items[index]
    }
}

enum APIError: Error {
    case invalidURL
    case noData
    case invalidData
}
