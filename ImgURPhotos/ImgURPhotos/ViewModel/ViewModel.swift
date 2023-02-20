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

    func fetchData(completion: @escaping () -> Void) {

        let clientID = "07e1c90635bb9cd"
        let urlString = "https://api.imgur.com/3/gallery/search/?q=cats"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in

            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let data = data {

                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                    if let data = json?["data"] as? [[String: Any]] {
                        for item in data {
                            if
                                let images = item["images"] as? [[String: Any]],
                                    let link = images[0]["link"] as? String,
                                    let url = URL(string: link),
                                    let data = try? Data(contentsOf: url),
                                    let image = UIImage(data: data),
                                    let title = item["title"] as? String {
                                let item = ImageItem(image: image, title: title)
                                self?.items.append(item)
                            }
                        }
                    }

                    completion()

                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }

        task.resume()
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
