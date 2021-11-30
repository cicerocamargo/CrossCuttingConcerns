import BankSelection_API
import Foundation

struct CachedListOfBanksService: ListOfBanksService {
    
    let cache: ListOfBanksCache
    let decoratee: ListOfBanksService
    
    func listOfBanks(
        completion: @escaping (Result<[Bank], Error>) -> Void
    ) {
        if cache.banks.isEmpty {
            decoratee.listOfBanks { result in
                if case .success(let banks) = result {
                    cache.banks = banks
                }
                completion(result)
            }
        } else {
            completion(.success(cache.banks))
        }
    }
}

public extension ListOfBanksService {
    func caching(with cache: ListOfBanksCache) -> ListOfBanksService {
        CachedListOfBanksService(cache: cache, decoratee: self)
    }
}
