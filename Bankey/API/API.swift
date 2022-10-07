//
//  API.swift
//  Bankey
//
//  Created by HanaTI on 2022/10/07.
//

import Foundation

class API {
    private let baseUrl: String
    init (baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func fetch<Data>(
        byEndPoint endPoint: String,
        completion: @escaping (Result<Data, NetworkError>) -> Void) where Data: Codable {
        
        let url = URL(string: "\(baseUrl)/\(endPoint)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedData = try decoder.decode(Data.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
