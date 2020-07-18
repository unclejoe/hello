import Vapor

func routes(_ app: Application) throws {
    app.get { req -> EventLoopFuture<View> in
        struct Context: Encodable {
            let title: String
            let body: String
        }
        
        let context = Context(title: "my first Vapor Project with Leaf", body: "Hello Leaf!")
        
        return req.view.render("index", context)
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
}
