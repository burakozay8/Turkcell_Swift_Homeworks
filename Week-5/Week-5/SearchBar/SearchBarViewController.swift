//
//  SearchBarViewController.swift
//  Week-5
//
//  Created by Burak Ozay on 8.02.2022.
//

import UIKit

class SearchBarViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var users = [User]()
    var filteredUsers = [User]()
    var isFiltering: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://jsonplaceholder.typicode.com/users"
        guard let userURL = URL(string: urlString) else { return }
//        let data = try? Data(contentsOf: userURL)
        let userList = try? JSONDecoder().decode([User].self, from: Data(contentsOf: userURL))
        guard let users = userList else { return }
        self.users = users
        
    }
    

}

extension SearchBarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering == true {
            return filteredUsers.count
        }
        return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        
        let user: User
        
        if isFiltering == true {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
         
        cell?.textLabel?.text = user.username
        cell?.detailTextLabel?.text = user.email
        
        return cell!
    }
  
}

extension SearchBarViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            isFiltering = false
            tableView.reloadData()
    
            searchBar.endEditing(true)
            
        } else {
            
            filteredUsers = users.filter({ (user: User) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased())
            })

                isFiltering = true
                tableView.reloadData()
            
        }
      
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        tableView.reloadData()
        
        searchBar.endEditing(true)
        
    }

}

extension UITableView {
func setEmptyView(title: String, message: String) {
let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
let titleLabel = UILabel()
let messageLabel = UILabel()
titleLabel.translatesAutoresizingMaskIntoConstraints = false
messageLabel.translatesAutoresizingMaskIntoConstraints = false
titleLabel.textColor = UIColor.black
titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
messageLabel.textColor = UIColor.lightGray
messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
emptyView.addSubview(titleLabel)
emptyView.addSubview(messageLabel)
titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
titleLabel.text = title
messageLabel.text = message
messageLabel.numberOfLines = 0
messageLabel.textAlignment = .center
// The only tricky part is here:
self.backgroundView = emptyView
self.separatorStyle = .none
}
func restore() {
self.backgroundView = nil
self.separatorStyle = .singleLine
}
}
