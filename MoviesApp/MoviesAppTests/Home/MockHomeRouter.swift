//
//  MockHomeRouter.swift
//  MoviesAppTests
//
//  Created by Burak Ozay on 30.04.2022.
//

import Foundation
@testable import MoviesApp

final class MockHomeRouter: HomeRouterProtocol {
    
    var routes: [HomeRoutes] = []
    
    func navigate(_ route: HomeRoutes) {
        routes.append(route)
    }
    
}


