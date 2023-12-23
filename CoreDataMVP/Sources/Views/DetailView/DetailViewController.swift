import UIKit

class DetailViewController: UIViewController {
    
    var detailPresenter: DetailPresenter?
    
    // MARK: - UI
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
    
    // MARK: - Action
    
}

// MARK: - Extensions

extension DetailViewController {
    func setPresenter(presenter: DetailPresenter){
        self.detailPresenter = presenter
    }
}
