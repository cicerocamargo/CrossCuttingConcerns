import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            BankSelectionView(
                viewModel: BankSelectionViewModel(
                    service: LiveListOfBanksService(),
                    cache: ListOfBanksInMemoryCache(),
                    firebaseTracking: DebugBankSelectionTracking(tag: "Firebase"),
                    oneSignalTracking: DebugBankSelectionTracking(tag: "OneSignal")
                )
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
