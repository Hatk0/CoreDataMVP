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
    
    private lazy var listTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        let views = [printNameTextField, pressButton, listTableView]
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
            pressButton.heightAnchor.constraint(equalToConstant: 50),
            
            listTableView.topAnchor.constraint(equalTo: pressButton.bottomAnchor, constant: 20),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Action
    
    @objc
    func buttonTapped() {
        if printNameTextField.text != "" {
            print("")
        } else {
            let alert = UIAlertController(title: "Nothing was written",
                                          message: "Please enter your name",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
        self.printNameTextField.text = ""
    }
}

// MARK: - Extensions

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
