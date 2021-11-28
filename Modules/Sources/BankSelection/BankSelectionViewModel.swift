import BankSelection_API
import Foundation

public final class BankSelectionViewModel: ObservableObject {
    struct State {
        var banks: [Bank] = []
        var isLoading = false
        var selected: Bank?
    }
    
    @Published
    private(set) var state = State()

    private let service: ListOfBanksService
    private let cache: ListOfBanksCache
    private let tracking: BankSelectionTracking
    
    public init(
        service: ListOfBanksService,
        cache: ListOfBanksCache,
        tracking: BankSelectionTracking
    ) {
        self.service = service
        self.cache = cache
        self.tracking = tracking
    }
    
    func onAppear() {
        tracking.trackView()
        fetchBanks()
    }
    
    private func fetchBanks() {
        if !cache.banks.isEmpty {
            state.banks = cache.banks
            return
        }
        
        state.isLoading = true
        service.listOfBanks { [weak self] result in
            DispatchQueue.main.async {
                self?.handleFetchBanksResult(result)
            }
        }
    }
    
    private func handleFetchBanksResult(_ result: Result<[Bank], Error>) {
        state.isLoading = false
        do {
            let banks = try result.get()
            state.banks = banks
            cache.banks = banks
        } catch {
            // TODO: handle error
            #if DEBUG
            print(error)
            #endif
        }
    }
    
    func select(_ bank: Bank) {
        state.selected = bank
    }
    
    func advance() {
        // TODO: implement
    }
}
