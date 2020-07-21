
import Vapor
import Fluent

struct UserMigration_v1_0_0: Migration {
    private func users() -> [UserModel] {
        [
            UserModel(email: "51802932@qq.com", password: try! Bcrypt.hash("chowdan")),
            UserModel(email: "chowdann@qq.com", password: try! Bcrypt.hash("51802932")),
        ]
    }
    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(UserModel.schema)
            .id()
            .field(UserModel.FieldKeys.email, .string, .required)
            .field(UserModel.FieldKeys.password, .string, .required)
            .unique(on: UserModel.FieldKeys.email)
            .create(),
    ]) .flatMap {
        self.users().create(on: db) }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
            database.schema(UserModel.schema).delete(), ])
    }
}
