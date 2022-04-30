//
//  MovieRepository.swift
//  MoviesApp
//
//  Created by Burak Ozay on 28.04.2022.
//

import Foundation
import UIKit
import CoreData

//protocol MovieRepositoryProtocol {
//    func saveMovieID(id: Int)
//}

class MovieRepository {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveMovieToEntity(id: Int) {
        let viewContext = appDelegate.persistentContainer.viewContext
        
        if viewContext.hasChanges {
                  try! viewContext.save()
              }
        
        let favMovie = NSEntityDescription.insertNewObject(forEntityName: "MovieEntity", into: viewContext)
        favMovie.setValue(id, forKey: "id")
        
        do {
            try viewContext.save()
            NSLog("************* SAVED *********", favMovie)
        } catch  {
            print("************** COULD NOT SAVE ***************")
        }
    }
    
    func deleteMovieFromEntity(movieID: Int) { //tekrar yaz
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        let idString = "\((movieID))"
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        fetchRequest.returnsObjectsAsFaults = false

            do {
            let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        guard let id = result.value(forKey: "id") as? Int else { return }
                        if id == movieID {
                                context.delete(result)
                                    do {
                                        try context.save()
                                        print("************* DELETED *********")
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
    }
    
    func checkMovieIsInFavorites(movieID: Int) -> Bool { // tekrar yaz.
        
        var isFavorite: Bool = false
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if result.value(forKey: "id") as! Int == movieID {
                         isFavorite = true
                    }
                }
            } else {
                print("Error")
            }
        } catch {
            print("Couldn't fetch data.")
        }
        return isFavorite
        
    }

}
