//
//  ExpeditionCell.swift
//  BusSeatApp
//
//  Created by Burak Ozay on 21.02.2022.
//

import UIKit

class ExpeditionCell: UITableViewCell {


    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
