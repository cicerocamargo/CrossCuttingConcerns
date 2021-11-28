import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            BankSelectionView(
                viewModel: BankSelectionViewModel(
                    service: LiveListOfBanksService(),
                    cache: ListOfBanksInMemoryCache(),
                    tracking: DebugBankSelectionTracking(tag: "Firebase")
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
