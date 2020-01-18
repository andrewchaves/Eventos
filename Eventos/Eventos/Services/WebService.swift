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

enum NetworkSuccess: Error {
    case successPost
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
    
    func checkIn(name: String, email: String, eventId: String, completion: @escaping (Result<NetworkSuccess, NetworkError>) -> Void){
        
        guard let chekinURL = URL(string: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events?fbclid=IwAR0Ll0IuRnyQk4a-KBwi1JZDoxvUeilJEB0rJPsu5VRPK278NVC4LhWdhaQ") else {
            fatalError("URL incorrect.")
        }
        
        let parameters = ["name":name,"email":email,"eventId":eventId]
      
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        var request : URLRequest = URLRequest(url: chekinURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
               print(error.localizedDescription)
            completion(.failure(.decodingError))
        }
        let dataTask = session.dataTask(with: chekinURL) {
            data,response,error in

            guard let httpResponse = response as? HTTPURLResponse, let _ = data
                else {
                    completion(.failure(.decodingError))
                    return
            }
            print(httpResponse.statusCode)
            switch (httpResponse.statusCode) {
                case 200:
                    completion(.success(.successPost))
                    break
                case 400:
                    completion(.failure(.domainError))
                    break
                default:
                    break
            }
        }
        dataTask.resume()
        
    }
}
