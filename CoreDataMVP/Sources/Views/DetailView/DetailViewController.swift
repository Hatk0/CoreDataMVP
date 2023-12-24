import UIKit

class DetailViewController: UIViewController {
    
    var detailPresenter: DetailPresenter?
    
    private var avatar: Data? = nil
    private let genderArray = ["Male", "Female", "Other"]
    
    // MARK: - UI
    
    private let datePicker = UIDatePicker()
    private let genderPicker = UIPickerView()
    
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
    
    private lazy var nameTextField: UITextField = {
       let textField = UITextField()
        let image = UIImage(systemName: "person.circle.fill")
        textField.setIcon(image ?? UIImage())
        textField.borderStyle = .roundedRect
        textField.tintColor = .systemBlue
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var birthDateTextField: UITextField = {
       let textField = UITextField()
        let image = UIImage(systemName: "birthday.cake.fill")
        textField.setIcon(image ?? UIImage())
        textField.borderStyle = .roundedRect
        textField.tintColor = .systemBlue
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var genderTextField: UITextField = {
        let textField = UITextField()
        let image = UIImage(systemName: "allergens.fill")
        textField.setIcon(image ?? UIImage())
        textField.borderStyle = .roundedRect
        textField.tintColor = .systemBlue
        textField.backgroundColor = .systemGray6
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
        self.hideKeyboardWhenTappedAround()
        setBirthDatePicker()
        setGenderPicker()
    }
    
    private func setupHierarchy() {
        let views = [editButton, roundPicture, openGalleryButton, nameTextField,birthDateTextField, genderTextField]
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
            
            nameTextField.topAnchor.constraint(equalTo: openGalleryButton.bottomAnchor, constant: 40),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 350),
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            
            birthDateTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            birthDateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthDateTextField.widthAnchor.constraint(equalToConstant: 350),
            birthDateTextField.heightAnchor.constraint(equalToConstant: 60),
            
            genderTextField.topAnchor.constraint(equalTo: birthDateTextField.bottomAnchor, constant: 10),
            genderTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderTextField.widthAnchor.constraint(equalToConstant: 350),
            genderTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setBirthDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        birthDateTextField.inputView = datePicker
        birthDateTextField.inputAccessoryView = toolBar
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexSpace, doneButton], animated: true)
        
        let minimumBirthDate = Calendar.current.date(byAdding: .year, value: -73, to: Date())
        let maximumBirthDate = Calendar.current.date(byAdding: .year, value: -8, to: Date())
        datePicker.minimumDate = minimumBirthDate
        datePicker.maximumDate = maximumBirthDate
    }
    
    private func setGenderPicker() {
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderTextField.inputView = genderPicker
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
    
    @objc
    func doneAction() {
        getDateFromPicker()
        view.endEditing(true)
    }
    
    private func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        birthDateTextField.text = formatter.string(from: datePicker.date)
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

extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genderArray[row]
    }
}
