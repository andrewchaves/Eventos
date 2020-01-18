//
//  EventDetailViewController.swift
//  Eventos
//
//  Created by Andrew Chaves on 18/01/20.
//  Copyright © 2020 Andrew Chaves. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Toast_Swift

class EventDetailViewController: UIViewController {
    
    // Event Detail components
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    @IBOutlet weak var eventCheckinButton: UIButton!
    @IBOutlet weak var eventShareButton: UIButton!
    
    // Pop-up components
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var eMailTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var eventVM: EventViewModel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        self.title = eventVM.getTitle()
        self.popUpView.isHidden = true
        self.eventImageView.image = eventVM.getImage()
        self.eventDescriptionTextView.text = eventVM.getDescription()
        
        eventCheckinButton.rx.tap.bind {
            
            self.popUpView.isHidden = false
            
        }.disposed(by: disposeBag)
        
        eventShareButton.rx.tap.bind {
             DispatchQueue.main.async {
                self.view.makeToast("Compartilhe bons eventos.", duration: 2.0, position: .center)
            }
        }.disposed(by: disposeBag)
        
        okButton.rx.tap.bind {
            
            self.makeCheckIn()
            
        }.disposed(by: disposeBag)
        
        cancelButton.rx.tap.bind {
            
            self.dissmissPopUp()
            
        }.disposed(by: disposeBag)
    }
    
    private func makeCheckIn() {
        
        if self.nameTextField.text != "" && self.eMailTextField.text  != "" {
            
            let name = self.nameTextField.text!
            let email = self.eMailTextField.text!
            
            WebService().checkIn(name: name, email: email, eventId: self.eventVM.getId()) { result in

               switch result {
                    case .success(_):
                        
                        DispatchQueue.main.async {
                            self.view.makeToast("CheckIn realizado!", duration: 2.0, position: .center)
                            self.dissmissPopUp()
                        }
                       
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.view.makeToast("Erro ao fazer checkIn", duration: 2.0, position: .center)
                        }
               }
            }
            
        } else {
            
            self.feedbackLabel.text = "Preencha todos os campos!"
            self.feedbackLabel.textColor = UIColor.red
            
        }
        
    }
    
    private func dissmissPopUp() {
        
        self.feedbackLabel.text = "Preencha seus dados:"
        self.feedbackLabel.textColor = UIColor.systemGray
        self.nameTextField.text = ""
        self.eMailTextField.text = ""
        self.popUpView.isHidden = true
        
    }
    
}
