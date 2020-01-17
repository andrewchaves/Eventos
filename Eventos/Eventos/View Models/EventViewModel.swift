//
//  EventViewModel.swift
//  Eventos
//
//  Created by Andrew Chaves on 17/01/20.
//  Copyright © 2020 Andrew Chaves. All rights reserved.
//

import Foundation
import UIKit

struct EventViewModel {
    private let event: Event
}

extension EventViewModel {
    
    func getId() -> String {
        return event.id
    }
    
    func getTitle() -> String {
        return event.title
    }
    
    func getDescription() -> String {
        return event.description
    }
    
    func getPrice() -> String? {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: event.price))
         
    }
    
    func getImage() -> UIImage {
    
        guard let imageURL = URL(string: event.image) else {
            fatalError("URL incorrect.")
        }
       
        if let data = try? Data(contentsOf: imageURL) {
           if let image = UIImage(data: data) {
              return image
           }
        }
        
        return UIImage()
        
    }
    
    func getDate() -> String {
        
        let date = Date(timeIntervalSince1970: event.date)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
        
    }
    
}
