//
//  HomeViewController.swift
//  BusSeatApp
//
//  Created by Burak Ozay on 21.02.2022.
//

import UIKit
import DropDown
import SCLAlertView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var dateTextField: UITextField!
    
    var customBlack = UIColor(rgb: 0x071E3D)
    var departureDropDown = DropDown()
    var destinationDropDown = DropDown()
    var datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = customBlack
        
        dateTextField.attributedPlaceholder = NSAttributedString(
            string: "Tarih Seçiniz",
            attributes: [.foregroundColor: UIColor.white]
        )
        
        showDatePicker()
        
    }
    
    @IBAction func fromButtonAction(_ sender: Any) {
        
        departureDropDown.backgroundColor = customBlack
        departureDropDown.textColor = .white
        departureDropDown.dataSource = ["ISTANBUL", "ANKARA", "İZMİR", "ANTALYA", "MUĞLA"]
        departureDropDown.anchorView = sender as? AnchorView
        departureDropDown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height)
        departureDropDown.show() //7
        departureDropDown.selectionAction = { [weak self] (index: Int, item: String) in
        guard let _ = self else { return }
        (sender as AnyObject).setTitle(item, for: .normal)
            }
        
    }
    
    @IBAction func toButtonAction(_ sender: Any) {
        
        destinationDropDown.backgroundColor = customBlack
        destinationDropDown.textColor = .white
        destinationDropDown.dataSource = ["ISTANBUL", "ANKARA", "İZMİR", "ANTALYA", "MUĞLA"]
        destinationDropDown.anchorView = sender as? AnchorView
        destinationDropDown.bottomOffset = CGPoint(x: 0, y: (sender as AnyObject).frame.size.height)
        destinationDropDown.show() //7
        destinationDropDown.selectionAction = { [weak self] (index: Int, item: String) in
        guard let _ = self else { return }
        (sender as AnyObject).setTitle(item, for: .normal)
            }
        
    }
    
    func showDatePicker(){

        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -1 , to: Date())

        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Seç", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Vazgeç", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker

     }

      @objc func donedatePicker() {

          let formatter = DateFormatter()
          formatter.dateFormat = "dd/MM/yyyy"
          dateTextField.text = formatter.string(from: datePicker.date)
          
          self.view.endEditing(true)
          
     }

     @objc func cancelDatePicker() {
        self.view.endEditing(true)
      }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if  dateTextField.text == "" || departureDropDown.selectedItem == nil || destinationDropDown.selectedItem == nil {
            SCLAlertView().showError("Gerekli Seçimleri Yapmadınız", subTitle: "Lütfen gerekli lokasyonları ve sefer tarihini seçiniz.", closeButtonTitle: "Tamam", colorStyle: 0x1F4287 , colorTextButton: 0xFFFFFF)
            return false
        } else if departureDropDown.selectedItem == destinationDropDown.selectedItem {
            SCLAlertView().showError("Hatalı Rota Seçimi", subTitle: "Gidiş ve Dönüş için aynı lokasyonu seçtiniz. Lütfen farklı bir lokasyon seçiniz.", closeButtonTitle: "Tamam", colorStyle: 0x1F4287 , colorTextButton: 0xFFFFFF)
            return false
        } else {
            return true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toExpeditionVC" {
            if let destinationVC = segue.destination as? ExpeditionViewController {
                
                let backItem = UIBarButtonItem()
                backItem.title = "Ana Sayfa"
                navigationItem.backBarButtonItem = backItem
                backItem.tintColor = UIColor.white
                
                destinationVC.expeditionDateTextValue = dateTextField.text!
                destinationVC.cityTextValue = departureDropDown.selectedItem! + " - " + destinationDropDown.selectedItem!
            }
        }
    }
    
}
