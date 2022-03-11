//
//  NotificationListenerVC.swift
//  Week-4
//
//  Created by Burak Ozay on 4.02.2022.
//

import UIKit

class NotificationListenerVC: UIViewController {

    @IBOutlet weak var notificationMsgLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationCenter: NotificationCenter = .default
        notificationCenter.addObserver(self, selector: #selector(changeMessage(_:)), name: .sendDataNotification, object: nil)
    }
    
    @objc func changeMessage(_ notification: Notification) {
        guard let text = notification.userInfo!["data"] as? String else { return }
        notificationMsgLabel.text = text
    }
    
}
