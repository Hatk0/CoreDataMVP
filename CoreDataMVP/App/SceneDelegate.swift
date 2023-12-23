import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let factoryPattern = FactoryPattern()
        let coordinator = factoryPattern.makeMainCoordinator()
        coordinator.start(with: navigationController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
