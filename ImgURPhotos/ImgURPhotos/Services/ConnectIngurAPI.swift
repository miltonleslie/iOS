//
//  ConnectIngurAPI.swift
//  ImgURPhotos
//
//  Created by Milton Leslie Sobrinho de Souza Sanches on 16/02/23.
//

import UIKit

enum APIError: Error {
    case invalidResponse
    case decodingError
    case networkError
}

class ConnectIngurAPI {
    let clientId = "07e1c90635bb9cd"
    let clientSecret = "b4ea79393c2451c11af0267a6c5a1ae28d542758"
    let baseUrl = "https://api.imgur.com/3/gallery/search/?q=cats"
    var accessToken: String?
    var refreshToken: String?

    // MARK: - Request Authorization
    func requestNewAccessToken() {
        let authorizationUrl = "https://api.imgur.com/oauth2/authorize?client_id=\(clientId)&response_type=token"
        if let url = URL(string: authorizationUrl) {
            UIApplication.shared.open(url)
        }
    }

    // MARK: - API Call to Retrieve Images Data
    func makeApiCall(completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        guard let accessToken = accessToken else {
            completion(.failure(APIError.networkError))
            return
        }

        if let url = URL(string: baseUrl) {
            var request = URLRequest(url: url)
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let data = json?["data"] as? [[String: Any]] {
                            let items = data.map { item -> [String: Any] in
                                var result = [String: Any]()
                                if let images = item["images"] as? [[String: Any]], let link = images[0]["link"] as? String {
                                    result["link"] = link
                                }
                                if let title = item["title"] as? String {
                                    result["title"] = title
                                }
                                if let description = item["description"] as? String {
                                    result["description"] = description
                                }
                                return result
                            }
                            completion(.success(items))
                        } else {
                            completion(.failure(APIError.invalidResponse))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }.resume()
        }
    }

    // MARK: - Handle OAuth Authorization Response
    func handleAuthorizationResponse(_ url: URL) {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let fragment = urlComponents?.fragment, fragment.hasPrefix("access_token=") {
            let parameters = fragment.components(separatedBy: "&")
            let accessTokenParameter = parameters.first(where: { $0.hasPrefix("access_token=") })
            accessToken = accessTokenParameter?.replacingOccurrences(of: "access_token=", with: "")
            let refreshTokenParameter = parameters.first(where: { $0.hasPrefix("refresh_token=") })
            refreshToken = refreshTokenParameter?.replacingOccurrences(of: "refresh_token=", with: "")
            UserDefaults.standard.set(accessToken, forKey: "access_token")
            UserDefaults.standard.set(refreshToken, forKey: "refresh_token")
        }
    }
}
