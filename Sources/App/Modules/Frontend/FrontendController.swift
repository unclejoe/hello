//
//  File.swift
//  
//
//  Created by chowdan on 19/7/2020.
//

import Vapor
struct FrontendController {

     func homeView(req: Request) throws -> EventLoopFuture<View> {
        struct Context: Encodable {
            let title: String
            let header: String
            let message: String
        }

        let context = Context(title: "Unclejoe's Blog - 首页",
        header: "大家好,",
        message: "欢迎大家访问我的博客!")
        return req.view.render("home", context)
    }
}
