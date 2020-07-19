//
//  File.swift
//  
//
//  Created by chowdan on 19/7/2020.
//

import Vapor
struct FrontendRouter: RouteCollection {
    let controller = FrontendController()
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: self.controller.homeView)
    }
}
