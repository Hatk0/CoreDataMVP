import UIKit

// MARK: - Protocols

protocol Factory {
    func makeMainViewController(coordinator: ProjectCoordinator) -> MainViewController
    func makeDetailViewController(coordinator: ProjectCoordinator, data: Person) -> DetailViewController
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
    
    func makeDetailViewController(coordinator: ProjectCoordinator, data: Person) -> DetailViewController {
        let viewController = DetailViewController()
        let presenter = DetailPresenter(view: viewController, user: data, coreDataManager: coreDataManager)
        viewController.setPresenter(presenter: presenter)
        return viewController
    }
    
    func makeMainCoordinator() -> ProjectCoordinator {
        let coordinator = ProjectCoordinator(factory: self)
        return coordinator
    }
}
