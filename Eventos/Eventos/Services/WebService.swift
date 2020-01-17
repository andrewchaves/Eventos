//
//  API.swift
//  Eventos
//
//  Created by Andrew Chaves on 17/01/20.
//  Copyright © 2020 Andrew Chaves. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

class WebService {
    func loadEvents(url: URL, completion: @escaping (Result<[Event], NetworkError>) -> Void){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let _ = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            print(data as Any)
            let result = try? JSONDecoder().decode([Event].self, from: data!)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
}
