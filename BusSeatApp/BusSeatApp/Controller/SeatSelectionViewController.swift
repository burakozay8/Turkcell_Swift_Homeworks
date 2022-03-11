//
//  ViewController.swift
//  BusSeatApp
//
//  Created by Burak Ozay on 14.02.2022.
//

import UIKit
import SCLAlertView


class SeatSelectionViewController: UIViewController {

    @IBOutlet weak var leftCollectionView: UICollectionView!
    @IBOutlet weak var rightCollectionView: UICollectionView!
    @IBOutlet weak var reserveSeatButton: UIButton!
    @IBOutlet weak var temporaryDateLabel: UILabel!

    var selectedSeatNumbers = [String]()
    var selectedSeatNumberString = ""
    var tempDateTextValue = ""
    
    var customBlack = UIColor(rgb: 0x071E3D)
    var tealGreen = UIColor(rgb: 0x21E6C1)
    var customBlue = UIColor(rgb: 0x1F4287)
    
    var leftSeatNumbers = ["01", "02","05", "06", "09", "10", "13", "14", "17", "18", "21","22", "25","26", "29", "30", "33", "34", "37", "38", "41", "42"]
    var rightSeatNumbers = [ "03", "04",  "07", "08", "11", "12", "15", "16", "19", "20", "23", "24", "27", "28",  "31", "32", "35", "36", "39", "40", "43", "44"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = customBlack
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        temporaryDateLabel.text = tempDateTextValue
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedSeatNumberString = ""
        
    }
    
}

extension SeatSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.leftCollectionView {
            return leftSeatNumbers.count
        } else {
            return rightSeatNumbers.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.leftCollectionView {
            let leftCell = leftCollectionView.dequeueReusableCell(withReuseIdentifier: "leftSeatCell", for: indexPath) as! LeftSeatCell
            
            leftCell.layer.cornerRadius = 10
            leftCell.layer.borderWidth = 1
            leftCell.layer.borderColor = UIColor.white.cgColor
            leftCell.backgroundColor = customBlack

            leftCell.leftSeatLabel.text = leftSeatNumbers[indexPath.row]
            
            return leftCell
        } else {
            let rightCell = rightCollectionView.dequeueReusableCell(withReuseIdentifier: "rightSeatCell", for: indexPath) as! RightSeatCell
            
            rightCell.layer.cornerRadius = 10
            rightCell.layer.cornerRadius = 10
            rightCell.layer.borderWidth = 1
            rightCell.layer.borderColor = UIColor.white.cgColor
            rightCell.backgroundColor = customBlack
            rightCell.rightSeatLabel.text = rightSeatNumbers[indexPath.row]
            
            return rightCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.leftCollectionView {

            let selectedLeftCell: UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
            
            if selectedSeatNumbers.count < 5 {
                
                if selectedLeftCell.backgroundColor == customBlack {
                    
                    selectedLeftCell.backgroundColor = tealGreen
                    selectedSeatNumbers.append(leftSeatNumbers[indexPath.row])
                    
                }
                
                else if selectedLeftCell.backgroundColor == tealGreen {
                    
                    selectedLeftCell.backgroundColor = customBlack
                    selectedSeatNumbers = selectedSeatNumbers.filter { $0 != leftSeatNumbers[indexPath.row]}
 
                    }
                      
            } else {
                
                if selectedLeftCell.backgroundColor == tealGreen {
                    
                    selectedLeftCell.backgroundColor = customBlack
                    selectedSeatNumbers = selectedSeatNumbers.filter { $0 != leftSeatNumbers[indexPath.row]}
                    
                } else if selectedLeftCell.backgroundColor == customBlack {
                
                    SCLAlertView().showError("Koltuk Seçilemedi", subTitle: "Tek seferde en fazla 5 koltuk satın alabilirsiniz.", closeButtonTitle: "Tamam", colorStyle: 0x1F4287 , colorTextButton: 0xFFFFFF)
                
                }
                
            }
            
        } else {
            
            let selectedRightCell: UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
            
            if selectedSeatNumbers.count < 5 {

                if selectedRightCell.backgroundColor == customBlack {
                    
                    selectedRightCell.backgroundColor = tealGreen
                    selectedSeatNumbers.append(rightSeatNumbers[indexPath.row])
                    
                }
                
                else if selectedRightCell.backgroundColor == tealGreen {
                    
                    selectedRightCell.backgroundColor = customBlack
                    selectedSeatNumbers = selectedSeatNumbers.filter { $0 != rightSeatNumbers[indexPath.row]}
                    
                    }
                      
            } else {
                
                if selectedRightCell.backgroundColor == tealGreen {
                    
                    selectedRightCell.backgroundColor = customBlack
                    selectedSeatNumbers = selectedSeatNumbers.filter { $0 != rightSeatNumbers[indexPath.row]}
                    
                } else if selectedRightCell.backgroundColor == customBlack {
                    
                    SCLAlertView().showError("Koltuk Seçilemedi", subTitle: "Tek seferde en fazla 5 koltuk satın alabilirsiniz.", closeButtonTitle: "Tamam", colorStyle: 0x1F4287 , colorTextButton: 0xFFFFFF)
                    
                }
                
            }
            
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if selectedSeatNumbers.count == 0 {
            SCLAlertView().showError("Koltuk Seçimi Yapmadınız", subTitle: "", closeButtonTitle: "Tamam", colorStyle: 0x1F4287 , colorTextButton: 0xFFFFFF)
            return false
        } else {
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTicketControlVC" {
            
            let destinationVC = segue.destination as? TicketControlViewController
            
            let backItem = UIBarButtonItem()
            backItem.title = "Koltuk Seçimi"
            navigationItem.backBarButtonItem = backItem
            backItem.tintColor = UIColor.white
                
                for i in 1...selectedSeatNumbers.count {
                    
                    selectedSeatNumberString = selectedSeatNumberString + "  " +  String(selectedSeatNumbers[i-1])
                    
                    }
                
                destinationVC?.seatNumberTextValue = selectedSeatNumberString
            
                destinationVC?.dateTextValue = tempDateTextValue
                
            }
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == leftCollectionView {
            return CGSize(width: 60, height: 60)
        } else {
            return CGSize(width: 60, height: 60)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == leftCollectionView {
            return 8
        } else {
            return 8
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == leftCollectionView {
            return UIEdgeInsets(top: 12, left: 16, bottom: 8, right: 48)
        } else {
            return UIEdgeInsets(top: 12, left: 24, bottom: 8, right: 16)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == leftCollectionView {
            self.rightCollectionView.contentOffset = self.leftCollectionView.contentOffset
        } else if scrollView == rightCollectionView {
            self.leftCollectionView.contentOffset = self.rightCollectionView.contentOffset
        }
        
    }
    
}

