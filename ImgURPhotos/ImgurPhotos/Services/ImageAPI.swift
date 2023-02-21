//
//  ImageAPI.swift
//  ImgURPhotos
//
//  Created by Milton Leslie Sobrinho de Souza Sanches on 21/02/23.
//

import UIKit

class ImageAPI {
    private let clientID = "07e1c90635bb9cd"

    func searchImages(query: String, completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        let urlString = "https://api.imgur.com/3/gallery/search/?q=\(query)"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let data = json?["data"] as? [[String: Any]] {
                        completion(.success(data))
                    } else {
                        completion(.failure(APIError.invalidData))
                    }
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(APIError.noData))
            }
        }

        task.resume()
    }
}

