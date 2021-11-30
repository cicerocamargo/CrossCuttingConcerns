import BankSelection_API
import Combine
import Foundation

public final class BankSelectionViewModel: ObservableObject {
    struct State {
        var banks: [Bank] = []
        var isLoading = false
        var selected: Bank?
    }
    
    public enum Command: Equatable {
        case onAppear
        case select(Bank)
    }
    
    public let command = PassthroughSubject<Command, Never>()
    
    public var cancellables = Set<AnyCancellable>()
    
    @Published
    private(set) var state = State()

    private let service: ListOfBanksService
    
    public init(service: ListOfBanksService) {
        self.service = service
        
        command.sink { [weak self] in self?.handleCommand($0) }
            .store(in: &cancellables)
    }
    
    private func handleCommand(_ command: Command) {
        switch command {
        case .onAppear:
            fetchBanks()
            
        case .select(let bank):
            state.selected = bank
        }
    }
    
    private func fetchBanks() {
        state.isLoading = true
        service.listOfBanks { [weak self] result in
            self?.handleFetchBanksResult(result)
        }
    }
    
    private func handleFetchBanksResult(_ result: Result<[Bank], Error>) {
        state.isLoading = false
        do {
            let banks = try result.get()
            state.banks = banks
        } catch {
            // TODO: handle error
            #if DEBUG
            print(error)
            #endif
        }
    }
}



















 
 
 
 
 

