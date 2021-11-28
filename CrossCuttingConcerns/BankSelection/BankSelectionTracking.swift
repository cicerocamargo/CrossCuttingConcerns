import Foundation

protocol BankSelectionTracking {
    func trackView()
}

struct DebugBankSelectionTracking: BankSelectionTracking {
    let tag: String?
    
    func trackView() {
        #if DEBUG
        print((tag.map { "\($0) - " } ?? "") + "BankSelectionTracking - trackView()")
        #endif
    }
}

#if DEBUG
struct DummyBankSelectionTracking: BankSelectionTracking {
    func trackView() {}
}
#endif
