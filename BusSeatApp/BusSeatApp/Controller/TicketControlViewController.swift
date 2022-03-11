//
//  TicketControlViewController.swift
//  BusSeatApp
//
//  Created by Burak Ozay on 14.02.2022.
//

import UIKit
import SCLAlertView

class TicketControlViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var seatNumberLabel: UILabel!
    
    var seatNumberTextValue = ""
    var dateTextValue = ""
    
    var customBlack = UIColor(rgb: 0x071E3D)
    var tealGreen = UIColor(rgb: 0x21E6C1)
    var customBlue = UIColor(rgb: 0x1F4287)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        seatNumberLabel.text = seatNumberTextValue
        dateLabel.text = dateTextValue
                
        configureLabels()
        configureTextFields()
        
    }
    
    private func configureLabels() {
        
        dateLabel.layer.borderWidth = 1.0
        dateLabel.layer.cornerRadius = 10
        dateLabel.layer.borderColor = UIColor.white.cgColor
        
        timeLabel.text = "21:30"
        timeLabel.layer.borderWidth = 1.0
        timeLabel.layer.cornerRadius = 10
        timeLabel.layer.borderColor = UIColor.white.cgColor
        
        seatNumberLabel.layer.borderWidth = 1.0
        seatNumberLabel.layer.cornerRadius = 10
        seatNumberLabel.layer.borderColor = UIColor.white.cgColor
        seatNumberLabel.textColor = tealGreen
        
        infoLabel.layer.masksToBounds = true
        infoLabel.layer.cornerRadius = 10
        
    }
    
    private func configureTextFields() {
        
        nameTextField.backgroundColor = customBlack
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.cornerRadius = 10
        nameTextField.layer.borderColor = UIColor.white.cgColor
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Adınız...",
            attributes: [.foregroundColor: UIColor.systemGray2]
        )
        
        surnameTextField.backgroundColor = customBlack
        surnameTextField.layer.borderWidth = 1.0
        surnameTextField.layer.cornerRadius = 10
        surnameTextField.layer.borderColor = UIColor.white.cgColor
        surnameTextField.attributedPlaceholder = NSAttributedString(
            string: "Soyadınız...",
            attributes: [.foregroundColor: UIColor.systemGray]
        )
        
        idTextField.backgroundColor = customBlack
        idTextField.layer.borderWidth = 1.0
        idTextField.layer.cornerRadius = 10
        idTextField.layer.borderColor = UIColor.white.cgColor
        idTextField.attributedPlaceholder = NSAttributedString(
            string: "T.C. Kimlik Numaranız... ",
            attributes: [.foregroundColor: UIColor.systemGray]
        )
        
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if nameTextField.text == "" || surnameTextField.text == "" || idTextField.text == "" {
            SCLAlertView().showError("Gerekli Alanları Doldurmadınız", subTitle: "", closeButtonTitle: "Tamam", colorStyle: 0x1F4287 , colorTextButton: 0xFFFFFF)
            return false
        } else {
            return true
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTicketDetailsVC" {
            if let destinationVC = segue.destination as? TicketDetailsViewController {
                destinationVC.seatNumberTextValue = seatNumberLabel.text!
                destinationVC.detailDateTextValue = "  " + dateTextValue + " - " + "21:30"
            }
        }
        
    }

}
