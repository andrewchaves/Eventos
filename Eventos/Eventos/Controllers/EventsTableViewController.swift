//
//  EventsTableViewController.swift
//  Eventos
//
//  Created by Andrew Chaves on 17/01/20.
//  Copyright © 2020 Andrew Chaves. All rights reserved.
//

import Foundation
import UIKit

class EventsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents()
    }
    
    private func loadEvents() {
        
        guard let eventsURL = URL(string: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events?fbclid=IwAR0Ll0IuRnyQk4a-KBwi1JZDoxvUeilJEB0rJPsu5VRPK278NVC4LhWdhaQ") else {
            fatalError("URL incorrect.")
        }
        
        WebService().loadEvents(url: eventsURL) { result in
            
            switch result {
                case .success(let events):
                    print(events)
                case .failure(let error):
                    print(error)
            }
            
        }
        
    }
}
