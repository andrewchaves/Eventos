//
//  EventsTableViewController.swift
//  Eventos
//
//  Created by Andrew Chaves on 17/01/20.
//  Copyright © 2020 Andrew Chaves. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var eventsTableView: UITableView!
    
    let disposeBag = DisposeBag()
    private var eventsListVM: BehaviorRelay<[EventViewModel]> = BehaviorRelay(value: [])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsTableView
        .rx.setDelegate(self)
        .disposed(by: disposeBag)
        loadEvents()
    }
    
    private func loadEvents() {
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        guard let eventsURL = URL(string: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events?fbclid=IwAR0Ll0IuRnyQk4a-KBwi1JZDoxvUeilJEB0rJPsu5VRPK278NVC4LhWdhaQ") else {
            fatalError("URL incorrect.")
        }
        
        WebService().loadEvents(url: eventsURL) { result in
            
            switch result {
                case .success(let events):
                    
                    for event in events {
                        self.eventsListVM.accept(self.eventsListVM.value + [EventViewModel(event: event)])
                    }
                    self.presentDataInTableView()
                
                case .failure(let error):
                    print(error)
            }
            
        }
        
    }
    
    private func presentDataInTableView() {
        
        activityIndicator.stopAnimating()
        
        self.eventsListVM.asObservable().bind(to: eventsTableView.rx.items(cellIdentifier: "cellId", cellType: EventTableViewCell.self)) { row, model, cell in

                       cell.eventTitleLabel.text = model.getTitle()
                       cell.eventDateLabel.text = model.getDate()
                       cell.eventPriceLabel.text = model.getPrice()
        }.disposed(by: disposeBag)
        
    }
    
    // MARK :- TableView delegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
}