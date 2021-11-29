import Foundation

public protocol ListOfBanksService {
    func listOfBanks(completion: @escaping (Result<[Bank], Error>) -> Void)
}
