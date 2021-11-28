import Foundation

public struct Bank: Equatable, Decodable {
    public let code: Int
    public let name: String
    
    public init(code: Int, name: String) {
        self.code = code
        self.name = name
    }
}
