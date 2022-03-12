//
//  FavouritesViewController.swift
//  VideoGamesApp
//
//  Created by Burak Ozay on 5.03.2022.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var favGameDetail: GameDetail?
    var favoriteGames = [GameDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var noFavGameView: NoFavGameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getFavoriteGames()
        
        if favoriteGames.count == 0 {
            collectionView.isHidden = true
            if noFavGameView != nil && !noFavGameView.contentView.isHidden {
                noFavGameView?.removeFromSuperview()
            }
            noFavGameView = NoFavGameView(frame: CGRect(x: 0, y: 40, width: self.view.frame.width, height: self.view.frame.height))
            self.view.addSubview(noFavGameView)
            
        } else {
            noFavGameView?.removeFromSuperview()
            collectionView.isHidden = false
            collectionView.reloadData()
        }
        
    }
    
    private func configureNavigationIcon() {
        let image: UIImage = UIImage(named: "app_icon.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    private func getFavoriteGames() {
        
        favoriteGames.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGame")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    guard let name = result.value(forKey: "name") as? String else { return }
                    guard let releasedDate = result.value(forKey: "released") as? String else { return }
                    guard let metacriticRate = result.value(forKey: "metacritic") as? Int else { return }
                    guard let image = result.value(forKey: "image") as? String else { return }
                    guard let gameDescription = result.value(forKey: "game_description") as? String else { return }
                    guard let id = result.value(forKey: "id") as? Int else { return }
                    guard let slug = result.value(forKey: "slug") as? String else { return }
                    guard let rating = result.value(forKey: "rating") as? Double else { return }
                    
                    favoriteGames.append(GameDetail(id: id, slug: slug, name: name, released: releasedDate, background_image: image, rating: rating, description: gameDescription, metacritic: metacriticRate))

                }
                self.collectionView.reloadData()
            } else {
                print("Error")
            }
        } catch  {
            print("Couldn't fetch data.")
        }
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteGameCell", for: indexPath) as! FavoriteGameCell
        cell.layer.cornerRadius = 5
        cell.favoriteNameLabel.text = favoriteGames[indexPath.row].name
        cell.favoriteDetailLabel.text = "\((favoriteGames[indexPath.row].rating))" + " - " + favoriteGames[indexPath.row].released
        cell.favoriteGameImage.loadFrom(URLAddress: favoriteGames[indexPath.row].background_image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailGameRequest = GameRequest(slug: favoriteGames[indexPath.row].slug)
        detailGameRequest.getGameDetails { result in
            switch result {
            case .success(let gameDetail):
                self.favGameDetail = gameDetail
                DispatchQueue.main.async {
                    guard let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameDetailsVC") as? GameDetailsViewController else {return}
                    detailsVC.gameDetail = gameDetail
                    let backItem = UIBarButtonItem()
                    backItem.title = "Favorites"
                    self.navigationItem.backBarButtonItem = backItem
                    backItem.tintColor = UIColor.white
                    self.navigationController?.pushViewController(detailsVC, animated: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.view.bounds.width - 12, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 12, left: 6, bottom: 4, right: 6)
    }
    
}



