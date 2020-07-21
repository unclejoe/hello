import Vapor
import Leaf
import Fluent
import FluentSQLiteDriver

public func configure(_ app: Application) throws {
    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)
    
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease
    let workingDirectory = app.directory.workingDirectory
    app.leaf.configuration.rootDirectory = "/"
    app.leaf.sources = LeafSources.singleSource(ModularViewFiles(workingDirectory: workingDirectory, fileio: app.fileio))
    
    let modules: [Module] = [FrontendModule(), BlogModule(), UserModule()]
    for module in modules {
        try module.configure(app)
    }
}
