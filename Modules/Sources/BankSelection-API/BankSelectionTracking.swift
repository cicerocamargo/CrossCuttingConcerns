import Foundation

public protocol BankSelectionTracking {
    func trackView()
}

public struct DebugBankSelectionTracking: BankSelectionTracking {
    public init() {}
    
    public func trackView() {
        #if DEBUG
        print("BankSelectionTracking - trackView()")
        #endif
    }
}
