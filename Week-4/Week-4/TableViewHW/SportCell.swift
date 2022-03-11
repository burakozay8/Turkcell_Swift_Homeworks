//
//  TableViewCell.swift
//  Week-4
//
//  Created by Burak Ozay on 2.02.2022.
//

import UIKit

class SportCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: SportsModel) {
        textLabel?.text = model.sportName
        detailTextLabel?.text = model.sportType
    }
    
}

extension SportCell: NewElementDelegate {
    func addNewSport(nameText: String, typeText: String) {
        self.textLabel?.text = nameText
        self.detailTextLabel?.text = typeText
    }
    
    
}
