import BankSelection
import BankSelection_API
import Caching
import Networking
import Tracking
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            BankSelectionView(
                viewModel: {
                   let vm = BankSelectionViewModel(
                    service: LiveListOfBanksService()
                        .responding(on: .main)
                        .caching(with: ListOfBanksInMemoryCache())
                    )
                    
                    vm.command
                        .first(where: { $0 == .onAppear })
                        .sink { _ in Tracker.trackBankSelectionView() }
                        .store(in: &vm.cancellables)
                    
                    return vm
                }()
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
