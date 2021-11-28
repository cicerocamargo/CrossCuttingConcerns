import Foundation

struct BankSelectionViewState {
    var banks: [Bank] = []
    var isLoading = false
    var selected: Bank?
}

protocol BankSelectionViewModelProtocol: ObservableObject {
    var state: BankSelectionViewState { get }
    func onAppear()
    func select(_ bank: Bank)
    func advance()
}

final class BankSelectionViewModel: BankSelectionViewModelProtocol {
    @Published
    private(set) var state = BankSelectionViewState()

    private let service: ListOfBanksService
    private let cache: ListOfBanksCache
    private let firebaseTracking: BankSelectionTracking
    private let oneSignalTracking: BankSelectionTracking
    
    init(
        service: ListOfBanksService,
        cache: ListOfBanksCache,
        firebaseTracking: BankSelectionTracking,
        oneSignalTracking: BankSelectionTracking
    ) {
        self.service = service
        self.cache = cache
        self.firebaseTracking = firebaseTracking
        self.oneSignalTracking = oneSignalTracking
    }
    
    func onAppear() {
        trackView()
        fetchBanks()
    }
    
    private func trackView() {
        firebaseTracking.trackView()
        oneSignalTracking.trackView()
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
