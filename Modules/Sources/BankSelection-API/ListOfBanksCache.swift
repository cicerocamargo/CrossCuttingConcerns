public protocol ListOfBanksCache: AnyObject {
    var banks: [Bank] { get set }
}

public class ListOfBanksInMemoryCache: ListOfBanksCache {
    public init() {}
    
    public var banks: [Bank] = []
}
