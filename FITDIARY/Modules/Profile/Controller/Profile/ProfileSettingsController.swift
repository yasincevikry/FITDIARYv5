//
//  ProfileSettingsController.swift
//  FITDIARY


import UIKit

final class ProfileSettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    private var nameValue: String!
    private var genderValue: String!
    private var diaterValue: String!
    private var heightValue: String!
    private let backGroundColor = ThemesOptions.backGroundColor
    private let cellBackgColor = ThemesOptions.cellBackgColor
    private var profileSettingModels: [SettingModel] = []
    private var pickerData: [String] = []
    private var currentIndexPath: IndexPath?

    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    private lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        toolbar.setItems([doneButton], animated: false)
        return toolbar
    }()
    
    // MARK: - UI ELEMENTS
    private lazy var tableView: UITableView = UITableView()

    private lazy var tableTitle: UILabel = {
        let label = UILabel()
        label.text = "Profile Settings".localized()
        label.font = UIFont(name: "Copperplate Bold", size: 33)
        label.textColor = .white
        return label
    }()

    // MARK: - INIT-CONTROLLER
    init(nameValue: String!, genderValue: String!, diaterValue: String!, heightValue: String!) {
        super.init(nibName: nil, bundle: nil)
        self.nameValue = nameValue
        self.genderValue = genderValue
        self.diaterValue = diaterValue
        self.heightValue = heightValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserDefaults()
        profileSettingModels = fetchData()
        linkViews()
        configureView()
        layoutViews()
        delegateTableView()
    }

    // MARK: - VIEWS CONNECTION
    func linkViews() {
        view.backgroundColor = backGroundColor
        view.addSubview(tableView)
        view.addSubview(tableTitle)
    }

    // MARK: - CONFIGURATION
    func delegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func configureView() {
        tableView.register(ProfileSettingsCell.self, forCellReuseIdentifier: ProfileSettingsCell.identifier)
        tableView.backgroundColor = backGroundColor
        navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - LAYOUT
    func layoutViews() {
        tableTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          bottom: tableView.topAnchor,
                          right: view.rightAnchor,
                          paddingTop: 32,
                          paddingLeft: 16,
                          paddingBottom: 16,
                          paddingRight: 16)
        
        tableView.anchor(top: tableTitle.bottomAnchor,
                         left: tableTitle.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: tableTitle.rightAnchor)
    }

    // MARK: - TABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileSettingModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsCell.identifier) as! ProfileSettingsCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = backGroundColor
        cell.myViewController = self
        cell.setProfileSetting(model: profileSettingModels[indexPath.row], indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            view.endEditing(true)
            currentIndexPath = indexPath
            pickerData = getPickerData(for: indexPath.row)
            pickerView.reloadAllComponents()
            showPicker()
        }
    }

    func getPickerData(for index: Int) -> [String] {
        switch index {
        case 1:
            return ["Male", "Female"]
        case 2:
            return ["Vegan", "Vegetarian", "Non-Vegetarian"]
        case 3:
            return ["150 cm", "151 cm", "152 cm", "153 cm", "154 cm", "155 cm", "156 cm", "157 cm","158 cm", "159 cm",
                    "160 cm", "161 cm", "162 cm", "163 cm", "164 cm", "165 cm", "166 cm", "167 cm","168 cm", "169 cm",
                    "170 cm", "171 cm", "172 cm", "173 cm", "174 cm", "175 cm", "176 cm", "177 cm","178 cm", "179 cm",
                    "180 cm", "181 cm", "182 cm", "183 cm", "184 cm", "185 cm", "186 cm", "187 cm","188 cm", "189 cm",
                    "190 cm", "191 cm", "192 cm", "193 cm", "194 cm", "195 cm", "196 cm", "197 cm","198 cm", "199 cm",
                    "200 cm", "201 cm", "202 cm", "203 cm", "204 cm", "205 cm", "206 cm", "207 cm","208 cm", "209 cm","210 cm"]
        default:
            return []
        }
    }

    func showPicker() {
        view.addSubview(pickerView)
        view.addSubview(toolBar)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: pickerView.topAnchor)
        ])
    }

    @objc func donePicker() {
        view.endEditing(true)
        pickerView.removeFromSuperview()
        toolBar.removeFromSuperview()
    }

    // MARK: - UIPickerView DataSource and Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let currentIndexPath = currentIndexPath else { return }
        let selectedValue = pickerData[row]
        
        // Update the corresponding model with the selected value
        profileSettingModels[currentIndexPath.row].textValue = selectedValue
        
        // Reload the specific cell
        tableView.reloadRows(at: [currentIndexPath], with: .none)
        
        // Save to UserDefaults
        saveToUserDefaults()
    }

    // MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let cell = textField.superview?.superview as? ProfileSettingsCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        // Update the corresponding model with the entered text
        profileSettingModels[indexPath.row].textValue = textField.text ?? ""
        
        // Reload the specific cell
        tableView.reloadRows(at: [indexPath], with: .none)
        
        // Save to UserDefaults
        saveToUserDefaults()
    }

    // Fetch data function
    func fetchData() -> [SettingModel] {
        let profileSetting1 = SettingModel(textLabel: "Name".localized(), textValue: nameValue)
        let profileSetting2 = SettingModel(textLabel: "Gender".localized(), textValue: genderValue)
        let profileSetting3 = SettingModel(textLabel: "Dietary".localized(), textValue: diaterValue)
        let profileSetting4 = SettingModel(textLabel: "Height".localized(), textValue: heightValue)
        
        return [profileSetting1, profileSetting2, profileSetting3, profileSetting4]
    }
    
    // Load data from UserDefaults
    func loadUserDefaults() {
        nameValue = UserDefaults.standard.string(forKey: "name") ?? ""
        genderValue = UserDefaults.standard.string(forKey: "gender") ?? ""
        diaterValue = UserDefaults.standard.string(forKey: "dietary") ?? ""
        heightValue = UserDefaults.standard.string(forKey: "height") ?? ""
    }

    // Save data to UserDefaults
    func saveToUserDefaults() {
        for model in profileSettingModels {
            switch model.textLabel {
            case "Name".localized():
                UserDefaults.standard.set(model.textValue, forKey: "name")
            case "Gender".localized():
                UserDefaults.standard.set(model.textValue, forKey: "gender")
            case "Dietary".localized():
                UserDefaults.standard.set(model.textValue, forKey: "dietary")
            case "Height".localized():
                UserDefaults.standard.set(model.textValue, forKey: "height")
            default:
                break
            }
        }
    }
}

