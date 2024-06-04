//
//  ProfileSettingsCell.swift
//  FITDIARY
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

final class ProfileSettingsCell: UITableViewCell {
    
    static let identifier = "ProfileSettingsCell"
    var myViewController: UIViewController!
    private var dropDown = ThemesOptions.dropDown
    private let genders = ["Male".localized(), "Female".localized()]
    private let diateries = ["Vegetarian".localized(), "Vegan".localized(), "Classic".localized()]
    private let cellBackgColor = ThemesOptions.cellBackgColor
    
    // MARK: - UI ELEMENTS
    private lazy var pSettingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Copperplate Bold", size: 25)
        label.textColor = ThemesOptions.buttonBackGColor
        return label
    }()
    
    private lazy var pValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.delegate = self as? UITextFieldDelegate
        tf.isHidden = true // Başlangıçta gizli
        return tf
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        let size = CGFloat(42)
        button.tintColor = ThemesOptions.figureColor
        button.backgroundColor = ThemesOptions.cellBackgColor
        button.layer.cornerRadius = size / 2
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil")
        imageView.tintColor = ThemesOptions.figureColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - INIT-CELL
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        linkViews()
        configureView()
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEWS CONNECTION
    func linkViews() {
        contentView.addSubview(pSettingLabel)
        contentView.addSubview(pValueLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(textField)
        editButton.addSubview(iconView)
    }
    
    // MARK: - CONFIGURATION
    func configureView() {
        // editButton.addTarget(self, action: #selector(editorButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - FUNCTIONS
    func setProfileSetting(model: SettingModel, indexPath: IndexPath) {
        editButton.accessibilityIdentifier = model.textLabel
        pSettingLabel.text = "\(model.textLabel)"
        pValueLabel.text = "\(model.textValue)"
        textField.text = model.textValue
        
        // İsim için özel ayar
        if model.textLabel == "Name".localized() {
            pValueLabel.isHidden = true
            textField.isHidden = false
        } else {
            pValueLabel.isHidden = false
            textField.isHidden = true
        }
    }
    
    @objc func editButtonTapped() {
        if editButton.accessibilityIdentifier == "Name".localized() {
            textField.becomeFirstResponder()
        }
        // Diğer ayarlar için ilgili işlemler
    }
    
    // MARK: - LAYOUT
    override func layoutSubviews() {
        pSettingLabel.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             bottom: pValueLabel.topAnchor,
                             paddingTop: 16,
                             paddingLeft: 16,
                             paddingBottom: 8)
        
        pValueLabel.anchor(top: pSettingLabel.bottomAnchor,
                           left: pSettingLabel.leftAnchor,
                           bottom: contentView.bottomAnchor,
                           right: contentView.rightAnchor)
        
        textField.anchor(top: pSettingLabel.bottomAnchor,
                         left: pSettingLabel.leftAnchor,
                         bottom: contentView.bottomAnchor,
                         right: contentView.rightAnchor)
        
        editButton.anchor(top: pSettingLabel.topAnchor,
                          bottom: pSettingLabel.bottomAnchor,
                          right: contentView.rightAnchor,
                          paddingTop: 16,
                          paddingRight: 24)
        
        iconView.anchor(top: editButton.topAnchor,
                        left: editButton.leftAnchor,
                        bottom: editButton.bottomAnchor,
                        right: editButton.rightAnchor,
                        paddingTop: 8,
                        paddingLeft: 8,
                        paddingBottom: 8,
                        paddingRight: 8,
                        width: 28,
                        height: 28)
    }
}
