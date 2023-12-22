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
    
    private lazy var pressButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Press", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupHierarchy() {
        let views = [printNameTextField, pressButton]
        views.forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            printNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            printNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            printNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            printNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            printNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            pressButton.topAnchor.constraint(equalTo: printNameTextField.bottomAnchor, constant: 10),
            pressButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pressButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pressButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Action
    
    @objc
    func buttonTapped() {
        
    }
}

// MARK: - Extensions
