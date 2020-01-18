//
//  EventTableViewCell.swift
//  Eventos
//
//  Created by Andrew Chaves on 17/01/20.
//  Copyright © 2020 Andrew Chaves. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventPriceLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    func setupCell(eventVM: EventViewModel, row: Int) {
        if (row % 2 != 0 ) {
            self.backgroundColor = UIColor(displayP3Red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 0.8)
        } else {
            self.backgroundColor = UIColor(displayP3Red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 0.8)
        }
        
        self.eventImageView.image = eventVM.getImage()
        self.eventTitleLabel.text = eventVM.getTitle()
        self.eventDateLabel.text = eventVM.getDate()
        self.eventPriceLabel.text = eventVM.getPrice()
    }
}
