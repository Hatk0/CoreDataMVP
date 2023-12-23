import UIKit

class DetailViewController: UIViewController {
    
    var detailPresenter: DetailPresenter?
    
    private var avatar: Data? = nil
    
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
    
    private lazy var openGalleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set new photo", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(openGalleryButtonTapped), for: .touchUpInside)
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
        let views = [editButton, roundPicture, openGalleryButton]
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
            roundPicture.heightAnchor.constraint(equalToConstant: 180),
            
            openGalleryButton.topAnchor.constraint(equalTo: roundPicture.bottomAnchor, constant: 20),
            openGalleryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    // MARK: - Action
    
    @objc
    func editButtonTapped() {
        
    }
    
    @objc
    func openGalleryButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}

// MARK: - Extensions

extension DetailViewController {
    func setPresenter(presenter: DetailPresenter){
        self.detailPresenter = presenter
    }
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        roundPicture.contentMode = .scaleAspectFit
        roundPicture.image = image
        avatar = image?.pngData()
        dismiss(animated: true)
    }
}

