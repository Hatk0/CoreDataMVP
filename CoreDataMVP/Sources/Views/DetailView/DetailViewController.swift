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

    private lazy var roundPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 90
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        if let data = detailPresenter?.user?.avatar, let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.setDefaultUserImage()
        }

        return imageView
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
        let views = [editButton, roundPicture]
        views.forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            editButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            editButton.widthAnchor.constraint(equalToConstant: 80),
            editButton.heightAnchor.constraint(equalToConstant: 30),
            
            roundPicture.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 80),
            roundPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roundPicture.widthAnchor.constraint(equalToConstant: 180),
            roundPicture.heightAnchor.constraint(equalToConstant: 180)
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
