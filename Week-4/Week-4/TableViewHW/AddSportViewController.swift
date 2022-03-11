//
//  AddSportViewController.swift
//  Week-4
//
//  Created by Burak Ozay on 3.02.2022.
//

import UIKit

protocol NewElementDelegate {
    func addNewSport(nameText: String, typeText: String )
}

class AddSportViewController: UIViewController {
    @IBOutlet weak var sportNameTF: UITextField!
    @IBOutlet weak var sportTypeTF: UITextField!
    
    var delegate : NewElementDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addSportTapped(_ sender: Any) {
        
        guard let nameText = sportNameTF.text else { return }
        guard let typeText = sportTypeTF.text else { return }
        
        self.delegate?.addNewSport(nameText: nameText, typeText: typeText)
        dismiss(animated: true, completion: nil)
    }
    
}
