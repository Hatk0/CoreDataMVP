import UIKit

class DetailViewController: UIViewController {
    
    var detailPresenter: DetailPresenter?
    
    // MARK: - UI
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.5
        button.layer.masksToBounds = true
        
        let buttonTitle = "Edit"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        let attributedTitle = NSAttributedString(string: buttonTitle, attributes: attributes)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.layer.borderColor = UIColor.systemBlue.cgColor
        
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

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
        let views = [editButton]
        views.forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            editButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            editButton.widthAnchor.constraint(equalToConstant: 80),
            editButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: - Action
    
    @objc
    func editButtonTapped() {
        
    }
}

// MARK: - Extensions

extension DetailViewController {
    func setPresenter(presenter: DetailPresenter){
        self.detailPresenter = presenter
    }
}
