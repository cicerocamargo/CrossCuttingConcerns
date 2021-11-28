import BankSelection
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            BankSelectionView(
                viewModel: BankSelectionViewModel(
                    service: LiveListOfBanksService(),
                    cache: ListOfBanksInMemoryCache(),
                    tracking: DebugBankSelectionTracking()
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
