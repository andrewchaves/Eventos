//
//  EventDetailViewController.swift
//  Eventos
//
//  Created by Andrew Chaves on 18/01/20.
//  Copyright © 2020 Andrew Chaves. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    @IBOutlet weak var eventCheckinButton: UIButton!
    @IBOutlet weak var eventShareButton: UIButton!
    
    
    var eventVM: EventViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.title = eventVM.getTitle()
        self.eventImageView.image = eventVM.getImage()
        self.eventDescriptionTextView.text = eventVM.getDescription()
    }
    
}
