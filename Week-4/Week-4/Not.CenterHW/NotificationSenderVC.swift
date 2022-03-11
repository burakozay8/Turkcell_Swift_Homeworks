//
//  NotificationSenderVC.swift
//  Week-4
//
//  Created by Burak Ozay on 4.02.2022.
//

import UIKit

class NotificationSenderVC: UIViewController {
    @IBOutlet weak var notificationMsgTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendNotificationBtn(_ sender: Any) {
        
        let dataDict  = ["data" : notificationMsgTF.text]
        NotificationCenter.default.post(name: .sendDataNotification, object: nil, userInfo: dataDict)
        dismiss(animated: true, completion: nil)
        
    }
    

}
