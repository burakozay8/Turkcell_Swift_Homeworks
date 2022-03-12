//
//  GameDetailsViewController.swift
//  VideoGamesApp
//
//  Created by Burak Ozay on 7.03.2022.
//

import UIKit
import CoreData

class GameDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailGameImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var detailGameNameLabel: UILabel!
    @IBOutlet weak var detailGameRateLabel: UILabel!
    @IBOutlet weak var detailGameDateLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var gameDetail: GameDetail?
    
    var isFavButtonFilled: Bool = false
    var isGameInFavorites: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
            showDetails()
    }
    
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    isGameInFavorites = checkGameIsInFavorites(id: gameDetail!.id)
    
    if isGameInFavorites {
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
        isFavButtonFilled = true
    } else {
        likeButton.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        isFavButtonFilled = false
    }
    
}
    
    private func showDetails() {
        
        detailGameNameLabel.text = gameDetail?.name
        detailGameDateLabel.text = "Release Date: " + gameDetail!.released
        detailGameRateLabel.text = "Metacritic: " + "\((gameDetail?.metacritic)!)"
        detailDescriptionLabel.text = gameDetail?.description.html2String
        detailGameImage.loadFrom(URLAddress: gameDetail!.background_image)
        
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        
        if isFavButtonFilled {
            likeButton.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
            isFavButtonFilled = false

            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGame")
            let idString = "\((gameDetail?.id)!)"
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false

                do {
                let results = try context.fetch(fetchRequest)
                    if results.count > 0 {
                        for result in results as! [NSManagedObject] {
                            guard let id = result.value(forKey: "id") as? Int else { return }
                            if id == gameDetail?.id {
                                    context.delete(result)
                                        do {
                                            try context.save()
                                            } catch {
                                                print(error)
                                                    }
                                            break
                                        }
                                    }
                                } else {
                                    print("Error")
                                }
                } catch  {
                    print("Couldn't fetch data.")
                }

        } else {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
            isFavButtonFilled = true
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let favGame = NSEntityDescription.insertNewObject(forEntityName: "FavoriteGame", into: context)
            favGame.setValue(gameDetail?.name, forKey: "name")
            favGame.setValue(gameDetail?.background_image, forKey: "image")
            favGame.setValue(gameDetail?.released, forKey: "released")
            favGame.setValue(gameDetail?.metacritic, forKey: "metacritic")
            favGame.setValue(gameDetail?.description, forKey: "game_description")
            favGame.setValue(gameDetail?.id, forKey: "id")
            favGame.setValue(gameDetail?.slug, forKey: "slug")
            favGame.setValue(gameDetail?.rating, forKey: "rating")
            
            do {
                try context.save()
            } catch  {
                print("Couldn't save data.")
            }
        }
        
    }
    
   private func checkGameIsInFavorites(id: Int) -> Bool {
        
        var isFavorite: Bool = false
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGame")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if result.value(forKey: "id") as! Int == gameDetail!.id {
                         isFavorite = true
                    } else {
                        print("false control")
                    }
                }
            } else {
                print("Error")
            }
        } catch  {
            print("Couldn't fetch data.")
        }
        
        return isFavorite
        
    }
    
}


