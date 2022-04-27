//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by Burak Ozay on 27.04.2022.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setupTableView()
//    func contextForSearchText() -> String
}

class SearchViewController: UIViewController, LoadingShowable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SearchPresenterProtocol?
    
    var searchText1: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

extension SearchViewController: SearchViewControllerProtocol {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SearchCell.self)
    }
    
//    func contextForSearchText() -> String {
//        tableView.reloadData()
//        return searchText1
//    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SearchCell.self, for: indexPath)
        if let searchMovie = presenter?.searchMovie(indexPath.row) {
            cell.titleLabel.text = searchMovie.title
        }
        return cell
    }
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        ////bir seyler olmalı
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let text = searchBar.text, !text.isEmpty else { return }
//        reloadData()
//    }
        
}
