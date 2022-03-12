//
//  NoFavGameView.swift
//  VideoGamesApp
//
//  Created by Burak Ozay on 12.03.2022.
//

import UIKit

class NoFavGameView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("NoFavGameView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
