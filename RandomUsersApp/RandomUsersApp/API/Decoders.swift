//
//  Decoders.swift
//  RandomUsersApp
//
//  Created by Burak Ozay on 3.04.2022.
//

import Foundation

public enum Decoders {
    static let dateDecoder: JSONDecoder = {
       let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}

