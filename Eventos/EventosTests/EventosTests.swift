//
//  EventosTests.swift
//  EventosTests
//
//  Created by Andrew Chaves on 17/01/20.
//  Copyright © 2020 Andrew Chaves. All rights reserved.
//

import XCTest
@testable import Eventos

class EventosTests: XCTestCase {
    
     let event = Event(
                        id: "1",
                        title: "aaaa",
                        description: "aaaa",
                        price: 24.5,
                        image: "aaaa",
                        date: 1534784400000)

    override func setUp() {
        
    }

    override func tearDown() {

    }
    
    func testEventDate() {
        XCTAssertEqual(EventViewModel.init(event: event).getDate(), "20/08/2018")
    }
    
    func testEventPrice() {
        XCTAssertEqual(EventViewModel.init(event: event).getPrice(), "R$ 24,50")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            WebService().loadEvents(completion: { result in
                
            })
        }
    }

}
