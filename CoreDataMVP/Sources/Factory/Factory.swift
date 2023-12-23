import UIKit

protocol Factory {
    func makeMainViewController(coordinator: ProjectCoordinator) -> MainViewController
}

class FactoryPattern: Factory {
    
    // MARK: - Properties
    
    var coreDataManager: UserPersistenceManager = CoreDataManager()
    
    // MARK: - Methods
    
    func makeMainViewController(coordinator: ProjectCoordinator) -> MainViewController {
        let viewController = MainViewController()
        return viewController
    }
    
    func makeMainCoordinator() -> ProjectCoordinator {
        let coordinator = ProjectCoordinator(factory: self)
        return coordinator
    }
}
