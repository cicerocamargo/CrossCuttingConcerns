protocol ListOfBanksCache: AnyObject {
    var banks: [Bank] { get set }
}

class ListOfBanksInMemoryCache: ListOfBanksCache {
    var banks: [Bank] = []
}

#if DEBUG
class ListOfBanksNoCache: ListOfBanksCache {
    var banks: [Bank] {
        get { [] }
        set { }
    }
}
#endif
