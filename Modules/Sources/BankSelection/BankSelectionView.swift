import Combine
import SwiftUI
import UIKit

public struct BankSelectionView: View {
    @ObservedObject
    var viewModel: BankSelectionViewModel
    
    public init(viewModel: BankSelectionViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        List(viewModel.state.banks, id: \.code) { bank in
            Button(
                action: {
                    viewModel.command.send(.select(bank))
                },
                label: {
                    HStack {
                        Text(bank.name).bold() + Text(" (\(bank.code))")
                        Spacer()
                        if viewModel.state.selected == bank {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            ).foregroundColor(.primary)
        }
        .overlay(loadingOverlay)
        .navigationTitle(Text("Select your bank"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: Button("Next", action: {})
                .disabled(viewModel.state.selected == nil)
        )
        .onAppear(perform: { viewModel.command.send(.onAppear) })
    }
    
    @ViewBuilder
    private var loadingOverlay: some View {
        if viewModel.state.isLoading {
            ProgressView()
        }
    }
}
