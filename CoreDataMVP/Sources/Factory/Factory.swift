import UIKit

// MARK: - Protocols

protocol Factory {
    func makeMainViewController(coordinator: ProjectCoordinator) -> MainViewController
}

// MARK: - FactoryPattern

class FactoryPattern: Factory {
    
    // MARK: - Properties
    
    var coreDataManager: UserPersistenceManager = CoreDataManager()
    
    // MARK: - Methods
    
    func makeMainViewController(coordinator: ProjectCoordinator) -> MainViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(view: viewController, coordinator: coordinator, coreDataManager: coreDataManager)
        viewController.setPresenter(presenter)
        return viewController
    }
    
    func makeMainCoordinator() -> ProjectCoordinator {
        let coordinator = ProjectCoordinator(factory: self)
        return coordinator
    }
}
