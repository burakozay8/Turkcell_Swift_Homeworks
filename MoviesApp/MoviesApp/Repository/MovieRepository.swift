//
//  MovieRepository.swift
//  MoviesApp
//
//  Created by Burak Ozay on 28.04.2022.
//

import Foundation
import UIKit
import CoreData

class MovieRepository {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveMovieToEntity(id: Int) {
        let context = appDelegate.persistentContainer.viewContext
        
        if context.hasChanges {
                  try! context.save()
              }
        
        let favMovie = NSEntityDescription.insertNewObject(forEntityName: "MovieEntity", into: context)
        favMovie.setValue(id, forKey: "id")
        
        do {
            try context.save()
            NSLog("************* SAVED *********", favMovie)
        } catch  {
            print("************** COULD NOT SAVE ***************")
        }
    }
    
    func deleteMovieFromEntity(movieID: Int) {
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
                        } catch {
                            print(error)
                        }
                        break
                    }
                }
            } else {
                print("Error")
            }
        } catch {
            print("Could not fetch data.")
        }
    }
    
    func checkMovieIsInFavorites(movieID: Int) -> Bool {
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
