import SwiftUI
import UIKit

struct GenericUIViewControllerWrapper: UIViewControllerRepresentable {
    let viewController: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension UIViewController {
    var swiftUIRepresentable: GenericUIViewControllerWrapper {
        .init(viewController: self)
    }
}
