//
//  ViewController.swift
//  Week-4
//
//  Created by Burak Ozay on 2.02.2022.
//

import UIKit

class ViewController: UIViewController {

    var sports = [SportsModel]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        sports.append(SportsModel(sportName: "Football", sportType: "Team"))
        sports.append(SportsModel(sportName: "Tennis", sportType: "Individual"))
        sports.append(SportsModel(sportName: "Basketball", sportType: "Team"))
        sports.append(SportsModel(sportName: "Volleyball", sportType: "Team"))
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(onAddTapped))
        
    }

    @objc func onAddTapped() {
        let addSportVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddSportVC") as! AddSportViewController
               addSportVC.delegate = self
               present(addSportVC, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! SportCell
        cell.configure(model: sports[indexPath.row])
        return cell
    }
    
    
}

extension ViewController: NewElementDelegate {
    
    func addNewSport(nameText: String, typeText: String) {
        self.sports.append(SportsModel(sportName: nameText, sportType: typeText))
        tableView.reloadData()
    }
    
}




