import Foundation

protocol UserInteractor {
    var users: [Person] { get }
    func fetchAllUsers()
    func saveUserName(name: String)
    func deleteUser(indexPath: IndexPath)
}

class MainPresenter: UserInteractor {
    
    // MARK: - Properties
    
    weak private var view: MainViewController?
    private var coordinator: ProjectCoordinator?
    let coreDataManager: UserPersistenceManager
    var users = [Person]()
    
    // MARK: - Initalizer
    
    init(view: MainViewController, coordinator: ProjectCoordinator, coreDataManager: UserPersistenceManager) {
        self.view = view
        self.coordinator = coordinator
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Methods
    
    func fetchAllUsers() {
        users = coreDataManager.fetchAllUsers() ?? []
    }
    
    func saveUserName(name: String) {
        coreDataManager.saveUserName(name)
    }
    
    func deleteUser(indexPath: IndexPath) {
        coreDataManager.deleteUser(user: users[indexPath.row])
    }
}
