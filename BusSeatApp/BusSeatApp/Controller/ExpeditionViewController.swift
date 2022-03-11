//
//  ExpeditionViewController.swift
//  BusSeatApp
//
//  Created by Burak Ozay on 21.02.2022.
//

import UIKit
import SCLAlertView

class ExpeditionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var customBlack = UIColor(rgb: 0x071E3D)
    var customBlue = UIColor(rgb: 0x1F4287)
    
    var randomTimes = ["21:30"]
    var selectedCells = [UITableViewCell]()
    
    var cityTextValue = ""
    var expeditionDateTextValue = ""
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var expeditionDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = customBlack
        
        cityLabel.text = cityTextValue
        expeditionDateLabel.text = expeditionDateTextValue

    }
    
}

extension ExpeditionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "expeditionCell", for: indexPath) as! ExpeditionCell
        cell.backgroundColor = customBlack
        cell.timeLabel.text = randomTimes[indexPath.row]
        cell.logoImage.image = UIImage(named: "bus1.png")
        
        let view = UIView()
        view.backgroundColor = customBlue
        cell.selectedBackgroundView = view
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCells.append(selectedCell)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if selectedCells.count == 0 {
            SCLAlertView().showError("Sefer Seçimi Yapmadınız", subTitle: "", closeButtonTitle: "Tamam", colorStyle: 0x1F4287 , colorTextButton: 0xFFFFFF)
            return false
        } else {
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSeatSelectionVC" {
            if let destinationVC = segue.destination as? SeatSelectionViewController {
                let backItem = UIBarButtonItem()
                backItem.title = "Seferler"
                navigationItem.backBarButtonItem = backItem
                backItem.tintColor = UIColor.white
                
                destinationVC.tempDateTextValue = expeditionDateTextValue
            }
     
        }
        
    }
    
}
