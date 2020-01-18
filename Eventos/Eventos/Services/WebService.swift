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
    func loadEvents( completion: @escaping (Result<[Event], NetworkError>) -> Void){
        
        guard let eventsURL = URL(string: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events?fbclid=IwAR0Ll0IuRnyQk4a-KBwi1JZDoxvUeilJEB0rJPsu5VRPK278NVC4LhWdhaQ") else {
            fatalError("URL incorrect.")
        }
        
        URLSession.shared.dataTask(with: eventsURL) { data, response, error in
            
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
