//
//  ViewController.swift
//  VideoGamesApp
//
//  Created by Burak Ozay on 5.03.2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    var gameRequest = GameRequest()
    var games = [GameResult]() {
        didSet {
            DispatchQueue.main.async {
                self.topCollectionView.reloadData()
                self.bottomCollectionView.reloadData()
            }
        }
    }
    var filteredGames = [GameResult]()
    var gameDetail: GameDetail?
    var isFiltering: Bool = false
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    var noResultView: NoResultView!
    var customGray = UIColor(rgb: 0x373737)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameRequest.getGame { result in
            switch result {
            case .success(let games):
                self.games = games
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        
        }
        
        configureNavigationIcon()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSearchBar()
    }
    
    private func configureNavigationIcon() {
        let image: UIImage = UIImage(named: "app_icon.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    private func configureSearchBar() {
        searchBar.searchTextField.backgroundColor = customGray
        searchBar.searchTextField.leftView?.tintColor = .systemGray4
        searchBar.searchTextField.textColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray4])
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView {
            let tempGames = games.prefix(3)
            return tempGames.count
        } else {
            if isFiltering == false {
                return games.count
            } else {
                return filteredGames.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topCollectionView {
            let topCell = topCollectionView.dequeueReusableCell(withReuseIdentifier: "homeTopCell", for: indexPath) as! HomeTopCell
            let tempGames = games.prefix(3)
            topCell.homeTopGameImage.loadFrom(URLAddress: tempGames[indexPath.row].background_image)
            
            
            return topCell
        }
        
        else {
            let game: GameResult
            if isFiltering == false {
                game = games[indexPath.row]
            } else {
                game = filteredGames[indexPath.row]
            }
            let bottomCell = bottomCollectionView.dequeueReusableCell(withReuseIdentifier: "homeBottomCell", for: indexPath) as! HomeBottomCell
            bottomCell.layer.cornerRadius = 5
            bottomCell.homeGameNameLabel.text = game.name
            bottomCell.homeGameDetailsLabel.text = String(game.rating) + " - " + game.released
            bottomCell.homeBottomGameImage.loadFrom(URLAddress: game.background_image)
    
            return bottomCell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == bottomCollectionView {
            let game: GameResult
            if isFiltering == false {
                game = games[indexPath.row]
            } else {
                game = filteredGames[indexPath.row]
            }
            let detailGameRequest = GameRequest(slug: game.slug)
            detailGameRequest.getGameDetails { result in
                switch result {
                case .success(let gameDetail):
                    self.gameDetail = gameDetail
                    DispatchQueue.main.async {
                        guard let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameDetailsVC") as? GameDetailsViewController else { return }
                        detailsVC.gameDetail = gameDetail
                        let backItem = UIBarButtonItem()
                        backItem.title = "Home"
                        self.navigationItem.backBarButtonItem = backItem
                        backItem.tintColor = UIColor.white
                        self.navigationController?.pushViewController(detailsVC, animated: true)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            let detailGameRequest = GameRequest(slug: games[indexPath.row].slug)
            detailGameRequest.getGameDetails { result in
                switch result {
                case .success(let gameDetail):
                    self.gameDetail = gameDetail
                    DispatchQueue.main.async {
                        guard let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameDetailsVC") as? GameDetailsViewController else {return}
                        detailsVC.gameDetail = gameDetail
                        let backItem = UIBarButtonItem()
                        backItem.title = "Home"
                        self.navigationItem.backBarButtonItem = backItem
                        backItem.tintColor = UIColor.white
                        self.navigationController?.pushViewController(detailsVC, animated: true)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == bottomCollectionView {
            return CGSize(width: self.view.bounds.width - 12, height: 90)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == bottomCollectionView {
            return 16
        } else {
            return CGFloat()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == bottomCollectionView {
            return UIEdgeInsets(top: 12, left: 6, bottom: 4, right: 6)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == topCollectionView {
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x / width)
        }

    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count >= 3 {
            filteredGames = games.filter({ (game: GameResult) -> Bool in
                return game.name.lowercased().contains(searchText.lowercased())
            })
            if filteredGames.count == 0 {
                topCollectionView.isHidden = true
                pageControl.isHidden = true
                bottomCollectionView.isHidden = true
                
                isFiltering = true
                
                if noResultView != nil && !noResultView.contentView.isHidden {
                    noResultView?.removeFromSuperview()
                }
                
                noResultView = NoResultView(frame: CGRect(x: 0, y: 141, width: self.view.frame.width, height: self.view.frame.height))
                self.view.addSubview(noResultView)

            
            } else {
                noResultView?.removeFromSuperview()

                topCollectionView.isHidden = true
                bottomCollectionView.isHidden = false
                pageControl.isHidden = true
                isFiltering = true
                
                bottomCollectionView.reloadData()
            }

        } else if searchText.isEmpty {
            noResultView?.removeFromSuperview()

            isFiltering = false
            topCollectionView.isHidden = false
            bottomCollectionView.isHidden = false
            pageControl.isHidden = false
            
            topCollectionView.reloadData()
            bottomCollectionView.reloadData()
            
            searchBar.endEditing(true)
        }
    
    }
                                         
}





