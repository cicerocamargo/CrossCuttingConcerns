import Foundation

public protocol ListOfBanksService {
    func listOfBanks(
        completion: @escaping (Result<[Bank], Error>) -> Void
    )
}

struct ListOfBanksServiceQueueDecorator: ListOfBanksService {
    let decoratee: ListOfBanksService
    let queue: DispatchQueue
    
    func listOfBanks(
        completion: @escaping (Result<[Bank], Error>) -> Void
    ) {
        decoratee.listOfBanks { result in
            queue.async {
                completion(result)
            }
        }
    }
}

public extension ListOfBanksService {
    func responding(on queue: DispatchQueue) -> ListOfBanksService {
        ListOfBanksServiceQueueDecorator(decoratee: self, queue: queue)
    }
}
