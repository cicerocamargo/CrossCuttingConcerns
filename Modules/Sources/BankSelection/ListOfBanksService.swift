import Foundation

public protocol ListOfBanksService {
    func listOfBanks(completion: @escaping (Result<[Bank], Error>) -> Void)
}

public struct LiveListOfBanksService: ListOfBanksService {
    private struct UnknownError: Error {}
    
    public init() {}
    
    public func listOfBanks(completion: @escaping (Result<[Bank], Error>) -> Void) {
        URLSession.shared.dataTask(
            with: URL(string: "https://gist.githubusercontent.com/cicerocamargo/3925e91a6faed7b35bf3fe5f717c39a2/raw/2f34146977e789cca214ad28c6db129933074054/banks.json")!,
            completionHandler: { data, _, error in
                guard let data = data else {
                    completion(.failure(error ?? UnknownError()))
                    return
                }
                
                do {
                    let banks = try JSONDecoder().decode([Bank].self, from: data)
                    completion(.success(banks))
                } catch {
                    completion(.failure(error))
                }
            }
        ).resume()
    }
}

#if DEBUG
struct ListOfBanksServiceStub: ListOfBanksService {
    var result: Result<[Bank], Error>
    
    func listOfBanks(completion: @escaping (Result<[Bank], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(result)
        }
    }
}
#endif
