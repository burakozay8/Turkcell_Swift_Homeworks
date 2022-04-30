//
//  MockDetailRouter.swift
//  MoviesAppTests
//
//  Created by Burak Ozay on 30.04.2022.
//

import Foundation
@testable import MoviesApp

final class MockDetailRouter: DetailRouterProtocol {
    
    var routes: [DetailRoutes] = []
    
    func navigate(_ route: DetailRoutes) {
        routes.append(route)
    }
    
}
