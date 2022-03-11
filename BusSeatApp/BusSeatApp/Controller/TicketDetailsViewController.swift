//
//  TicketDetailsViewController.swift
//  BusSeatApp
//
//  Created by Burak Ozay on 14.02.2022.
//

import UIKit

class TicketDetailsViewController: UIViewController {

    @IBOutlet weak var detailSeatNumberLabel: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    
    var seatNumberTextValue = ""
    var detailDateTextValue = ""
    
    @IBOutlet weak var successImage: UIImageView!
    @IBOutlet weak var barcodeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        successImage.image = UIImage(named: "Success.png")
        barcodeImage.image = UIImage(named: "barcode3.png")
        
        detailSeatNumberLabel.text = seatNumberTextValue
        detailDateLabel.text = detailDateTextValue
        
    }
    
}
