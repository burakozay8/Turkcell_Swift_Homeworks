//
//  MovieRepository.swift
//  MoviesApp
//
//  Created by Burak Ozay on 28.04.2022.
//

import Foundation
import UIKit
import CoreData

protocol MovieRepositoryProtocol {
    func saveMovieID(id: Int)
}

class MovieRepository: MovieRepositoryProtocol {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveMovieID(id: Int) {
        let viewContext = appDelegate.persistentContainer.viewContext
        
        if viewContext.hasChanges {
                  try! viewContext.save()
              }
        
        let favMovie = NSEntityDescription.insertNewObject(forEntityName: "MovieEntity", into: viewContext)
        favMovie.setValue(id, forKey: "id")
        
        do {
            try viewContext.save()
            NSLog("************* BASARIYLA KAYDEDILDI *********", favMovie)
        } catch  {
            print("************** KAYDEDILEMEDI ***************")
        }
    }
    
    
}
