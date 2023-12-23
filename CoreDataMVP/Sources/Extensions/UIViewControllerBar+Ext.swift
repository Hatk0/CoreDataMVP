import UIKit

enum NavigationConfiguration {
    static let backButtonImage = UIImage(systemName: "arrow.left")
    static let backButtonTintColor = UIColor.systemBlue
}

extension UIViewController {
    func setupNavigationBar() {
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        customizeBackButton()
    }
    
    func customizeBackButton() {
        setBackButton(with: NavigationConfiguration.backButtonImage, tintColor: NavigationConfiguration.backButtonTintColor)
    }
    
    private func setBackButton(with image: UIImage?, tintColor: UIColor) {
        navigationController?.navigationBar.backIndicatorImage = image
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        navigationItem.backButtonTitle = ""
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = tintColor
        navigationItem.backBarButtonItem = backButton
    }
}
