import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var printNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Print your name here"
        textField.textAlignment = .center
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 15
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupHierarchy() {
        let views = [printNameTextField]
        views.forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            printNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            printNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            printNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            printNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            printNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Action
    
}

// MARK: - Extensions
