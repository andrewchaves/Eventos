//
//  Event.swift
//  Eventos
//
//  Created by Andrew Chaves on 17/01/20.
//  Copyright © 2020 Andrew Chaves. All rights reserved.
//

import Foundation


struct Event: Decodable {
    
    let id: String
    let title: String
    let description:String
    let price: Double
    let image: String
    let date: TimeInterval

}
