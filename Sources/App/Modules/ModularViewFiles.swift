
import Vapor
import Leaf

struct ModularViewFiles: LeafSource {

    let workingDirectory: String
    let modulesDirectory: String
    let alternateDirectory: String
    let nioLeafFiles: NIOLeafFiles
    
    init(workingDirectory: String,
        modulesDirectory: String = "Sources/App/Modules",
        alternateDirectory: String = "Resources",
        fileio: NonBlockingFileIO) {
        self.workingDirectory = workingDirectory
        self.modulesDirectory = modulesDirectory
        self.alternateDirectory = alternateDirectory
        self.nioLeafFiles = NIOLeafFiles(fileio: fileio)
    }

    func file(template: String,escape:Bool = true, on eventLoop: EventLoop) throws -> EventLoopFuture<ByteBuffer> {
        let viewsDir = "Views"
        let resourcesPath = self.alternateDirectory + "/" + viewsDir
        let ext = ".leaf"
        let name = template.replacingOccurrences(of: ext, with: "")
        let resourceFile = resourcesPath + name + ext
        if FileManager.default.fileExists(atPath: resourceFile) {
            return try self.nioLeafFiles.file(template: self.workingDirectory + resourceFile,escape:true,on: eventLoop)
        }
        
        let components = name.split(separator: "/")
        let pathComponents = [String(components.first!), viewsDir] + components.dropFirst().map { String($0) }
        
        let moduleFile = self.modulesDirectory + "/" + pathComponents.joined(separator: "/") + ext
        return try self.nioLeafFiles.file(template: self.workingDirectory + moduleFile,escape:true, on: eventLoop)
    }
}
