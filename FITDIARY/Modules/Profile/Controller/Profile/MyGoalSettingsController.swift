////
////  MyGoalSettingsController.swift
////  FITDIARY
////
//
//import UIKit
//
//final class MyGoalSettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
//
//    private var goalValue: String!
//    private var weightValue: String!
//    private var activenessValue: String!
//    private var goalWeightValue: String!
//    private var weeklyGoalValue: String!
//    private var goalCalorieValue: String!
//
//    private let backGroundColor = ThemesOptions.backGroundColor
//    private let cellBackgColor = ThemesOptions.cellBackgColor
//    private var goalSettingModels: [SettingModel] = []
//    private var pickerData: [String] = []
//    private var currentIndexPath: IndexPath?
//
//    private lazy var pickerView: UIPickerView = {
//        let picker = UIPickerView()
//        picker.backgroundColor = .white
//        picker.delegate = self
//        picker.dataSource = self
//        return picker
//    }()
//
//    private lazy var toolBar: UIToolbar = {
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
//        toolbar.setItems([doneButton], animated: false)
//        return toolbar
//    }()
//    
//    // MARK: - UI ELEMENTS
//    private lazy var tableView: UITableView = UITableView()
//
//    private lazy var viewTitle = {
//        let label = UILabel()
//        label.text = "My Goal Settings".localized()
//        label.font = UIFont(name: "Copperplate Bold", size: 33)
//        label.textColor = .white
//        return label
//    }()
//
//    // MARK: - INIT-CONTROLLER
//    init(goalValue: String, weightValue: String, goalCalorieValue: String, activenessValue: String, goalWeightValue: String, weeklyGoalValue: String) {
//        super.init(nibName: nil, bundle: nil)
//        self.goalValue = goalValue
//        self.weightValue = weightValue
//        self.goalCalorieValue = goalCalorieValue
//        self.activenessValue = activenessValue
//        self.goalWeightValue = goalWeightValue
//        self.weeklyGoalValue = weeklyGoalValue
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - VIEW LIFECYCLE
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadUserDefaults()
//        define()
//    }
//
//    func define() {
//        goalSettingModels = fetchData()
//        linkViews()
//        delegateTableView()
//        configureView()
//        configureLayout()
//    }
//
//    // MARK: - VIEWS CONNECTION
//    func linkViews() {
//        view.addSubview(viewTitle)
//        view.addSubview(tableView)
//    }
//
//    // MARK: - CONFIGURATION
//    func delegateTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(MyGoalSettingCell.self, forCellReuseIdentifier: MyGoalSettingCell.identifier)
//        tableView.backgroundColor = backGroundColor
//    }
//
//    func configureView() {
//        view.backgroundColor = backGroundColor
//        navigationItem.largeTitleDisplayMode = .never
//    }
//
//    // MARK: - LAYOUT
//    func configureLayout() {
//        viewTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: tableView.topAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
//        tableView.anchor(top: viewTitle.bottomAnchor, left: viewTitle.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: viewTitle.rightAnchor)
//    }
//
//    // MARK: - TABLE VIEW FUNCTIONS
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return goalSettingModels.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MyGoalSettingCell.identifier) as! MyGoalSettingCell
//        cell.backgroundColor = backGroundColor
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//        cell.myViewController = self
//        cell.setProfileSetting(model: goalSettingModels[indexPath.row])
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        view.endEditing(true)
//        currentIndexPath = indexPath
//        pickerData = getPickerData(for: indexPath.row)
//        pickerView.reloadAllComponents()
//        showPicker()
//    }
//
//    func getPickerData(for index: Int) -> [String] {
//        switch index {
//        case 0:
//            return ["Lose Weight", "Maintain Weight", "Gain Weight"]
//        case 1:
//            return ["50 kg","51 kg","52 kg","53 kg","54 kg","55 kg","56 kg","57 kg","58 kg","59 kg",
//                    "60 kg","61 kg","62 kg","63 kg","64 kg","65 kg","66 kg","67 kg","68 kg","69 kg",
//                    "70 kg","71 kg","72 kg","73 kg","74 kg","75 kg","76 kg","77 kg","78 kg","79 kg",
//                    "80 kg","81 kg","82 kg","83 kg","84 kg","85 kg","86 kg","87 kg","88 kg","89 kg",
//                    "90 kg","91 kg","92 kg","93 kg","94 kg","95 kg","96 kg","97 kg","98 kg","99 kg",
//                    "100 kg","101 kg","102 kg","103 kg","104 kg","105 kg","106 kg","107 kg","108 kg","109 kg",
//                    "110 kg","111 kg","112 kg","113 kg","114 kg","115 kg","116 kg","117 kg","118 kg","119 kg",
//                    "120 kg","121 kg","122 kg","123 kg","124 kg","125 kg","126 kg","127 kg","128 kg","129 kg",
//                    "130 kg","131 kg","132 kg","133 kg","134 kg","135 kg","136 kg","137 kg","138 kg","139 kg",
//                    "140 kg","141 kg","142 kg","143 kg","144 kg","145 kg","146 kg","147 kg","148 kg","149 kg",
//                    "150 kg","151 kg","152 kg","153 kg","154 kg","155 kg","156 kg","157 kg","158 kg","159 kg"]
//        case 2:
//            return ["50 kg", "55 kg","60 kg","65 kg", "70 kg","75 kg","80 kg","85 kg","90 kg","95 kg","100 kg","105 kg",
//                    "110 kg","115 kg","120 kg"]
//        case 3:
//            return ["Sedentary", "Lightly Active", "Moderately Active", "Very Active"]
//        case 4:
//            return ["0.5 kg/week", "1 kg/week", "1.5 kg/week"]
//        case 5:
//            return ["1200 kcal", "1500 kcal", "1800 kcal", "2000 kcal","25000 kcal"]
//        default:
//            return []
//        }
//    }
//
//    func showPicker() {
//        view.addSubview(pickerView)
//        view.addSubview(toolBar)
//        
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        toolBar.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            toolBar.bottomAnchor.constraint(equalTo: pickerView.topAnchor)
//        ])
//    }
//
//    @objc func donePicker() {
//        view.endEditing(true)
//        pickerView.removeFromSuperview()
//        toolBar.removeFromSuperview()
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerData[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        guard let currentIndexPath = currentIndexPath else { return }
//        let selectedValue = pickerData[row]
//        
//        goalSettingModels[currentIndexPath.row].textValue = selectedValue
//        
//        tableView.reloadRows(at: [currentIndexPath], with: .none)
//        
//        saveToUserDefaults()
//    }
//
//    func fetchData() -> [SettingModel] {
//        let goalSetting1 = SettingModel(textLabel: "Goal".localized(), textValue: goalValue)
//        let goalSetting2 = SettingModel(textLabel: "Starting Weight".localized(), textValue: weightValue)
//        let goalSetting3 = SettingModel(textLabel: "Goal Weight".localized(), textValue: goalWeightValue)
//        let goalSetting4 = SettingModel(textLabel: "Activity Level".localized(), textValue: activenessValue)
//        let goalSetting5 = SettingModel(textLabel: "Weekly Goal".localized(), textValue: weeklyGoalValue)
//        let goalSetting6 = SettingModel(textLabel: "Calorie Goal".localized(), textValue: goalCalorieValue)
//        
//        return [goalSetting1, goalSetting2, goalSetting3, goalSetting4, goalSetting5, goalSetting6]
//    }
//    
//    func loadUserDefaults() {
//        goalValue = UserDefaults.standard.string(forKey: "goal") ?? ""
//        weightValue = UserDefaults.standard.string(forKey: "startingWeight") ?? ""
//        goalWeightValue = UserDefaults.standard.string(forKey: "goalWeight") ?? ""
//        activenessValue = UserDefaults.standard.string(forKey: "activityLevel") ?? ""
//        weeklyGoalValue = UserDefaults.standard.string(forKey: "weeklyGoal") ?? ""
//        goalCalorieValue = UserDefaults.standard.string(forKey: "calorieGoal") ?? ""
//    }
//
//    func saveToUserDefaults() {
//        for model in goalSettingModels {
//            switch model.textLabel {
//            case "Goal".localized():
//                UserDefaults.standard.set(model.textValue, forKey: "goal")
//            case "Starting Weight".localized():
//                UserDefaults.standard.set(model.textValue, forKey: "startingWeight")
//            case "Goal Weight".localized():
//                UserDefaults.standard.set(model.textValue, forKey: "goalWeight")
//            case "Activity Level".localized():
//                UserDefaults.standard.set(model.textValue, forKey: "activityLevel")
//            case "Weekly Goal".localized():
//                UserDefaults.standard.set(model.textValue, forKey: "weeklyGoal")
//            case "Calorie Goal".localized():
//                UserDefaults.standard.set(model.textValue, forKey: "calorieGoal")
//            default:
//                break
//            }
//        }
//    }
//}
//
import UIKit

final class MyGoalSettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    private var goalValue: String!
    private var weightValue: String!
    private var activenessValue: String!
    private var goalWeightValue: String!
    private var weeklyGoalValue: String!
    private var goalCalorieValue: String!

    private let backGroundColor = ThemesOptions.backGroundColor
    private let cellBackgColor = ThemesOptions.cellBackgColor
    private var goalSettingModels: [SettingModel] = []
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

    private lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.text = "My Goal Settings".localized()
        label.font = UIFont(name: "Copperplate Bold", size: 33)
        label.textColor = .white
        return label
    }()

    // MARK: - INIT-CONTROLLER
    init(goalValue: String, weightValue: String, goalCalorieValue: String, activenessValue: String, goalWeightValue: String, weeklyGoalValue: String) {
        super.init(nibName: nil, bundle: nil)
        self.goalValue = goalValue
        self.weightValue = weightValue
        self.goalCalorieValue = goalCalorieValue
        self.activenessValue = activenessValue
        self.goalWeightValue = goalWeightValue
        self.weeklyGoalValue = weeklyGoalValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        loadUserDefaults()
        define()
    }

    func define() {
        goalSettingModels = fetchData()
        linkViews()
        delegateTableView()
        configureView()
        configureLayout()
    }

    // MARK: - VIEWS CONNECTION
    func linkViews() {
        view.addSubview(viewTitle)
        view.addSubview(tableView)
    }

    // MARK: - CONFIGURATION
    func delegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyGoalSettingCell.self, forCellReuseIdentifier: MyGoalSettingCell.identifier)
        tableView.backgroundColor = backGroundColor
    }

    func configureView() {
        view.backgroundColor = backGroundColor
        navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - LAYOUT
    func configureLayout() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            viewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - TABLE VIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalSettingModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyGoalSettingCell.identifier, for: indexPath) as! MyGoalSettingCell
        cell.backgroundColor = backGroundColor
        cell.selectionStyle = .none
        cell.myViewController = self
        cell.setProfileSetting(model: goalSettingModels[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        currentIndexPath = indexPath
        pickerData = getPickerData(for: indexPath.row)
        
        // Debug: Print the picker data to ensure it is being set
        print("Picker Data for index \(indexPath.row): \(pickerData)")
        
        pickerView.reloadAllComponents()
        showPicker()
    }

    func getPickerData(for index: Int) -> [String] {
        switch index {
        case 0:
            return ["Lose Weight", "Maintain Weight", "Gain Weight"]
        case 1:
            return ["50 kg", "51 kg", "52 kg", "53 kg", "54 kg", "55 kg", "56 kg", "57 kg", "58 kg", "59 kg",
                    "60 kg", "61 kg", "62 kg", "63 kg", "64 kg", "65 kg", "66 kg", "67 kg", "68 kg", "69 kg",
                    "70 kg", "71 kg", "72 kg", "73 kg", "74 kg", "75 kg", "76 kg", "77 kg", "78 kg", "79 kg",
                    "80 kg", "81 kg", "82 kg", "83 kg", "84 kg", "85 kg", "86 kg", "87 kg", "88 kg", "89 kg",
                    "90 kg", "91 kg", "92 kg", "93 kg", "94 kg", "95 kg", "96 kg", "97 kg", "98 kg", "99 kg",
                    "100 kg", "101 kg", "102 kg", "103 kg", "104 kg", "105 kg", "106 kg", "107 kg", "108 kg", "109 kg",
                    "110 kg", "111 kg", "112 kg", "113 kg", "114 kg", "115 kg", "116 kg", "117 kg", "118 kg", "119 kg",
                    "120 kg", "121 kg", "122 kg", "123 kg", "124 kg", "125 kg", "126 kg", "127 kg", "128 kg", "129 kg",
                    "130 kg", "131 kg", "132 kg", "133 kg", "134 kg", "135 kg", "136 kg", "137 kg", "138 kg", "139 kg",
                    "140 kg", "141 kg", "142 kg", "143 kg", "144 kg", "145 kg", "146 kg", "147 kg", "148 kg", "149 kg",
                    "150 kg", "151 kg", "152 kg", "153 kg", "154 kg", "155 kg", "156 kg", "157 kg", "158 kg", "159 kg"]
        case 2:
            return ["50 kg", "55 kg", "60 kg", "65 kg", "70 kg", "75 kg", "80 kg", "85 kg", "90 kg", "95 kg", "100 kg", "105 kg",
                    "110 kg", "115 kg", "120 kg"]
        case 3:
            return ["Sedentary", "Lightly Active", "Moderately Active", "Very Active"]
        case 4:
            return ["0.5 kg/week", "1 kg/week", "1.5 kg/week"]
        case 5:
            return ["1200 kcal", "1500 kcal", "1800 kcal", "2000 kcal", "2500 kcal"]
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

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Debug: Ensure the title for each row is being set correctly
        print("Setting title for row \(row): \(pickerData[row])")
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let currentIndexPath = currentIndexPath else { return }
        let selectedValue = pickerData[row]

        goalSettingModels[currentIndexPath.row].textValue = selectedValue

        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [currentIndexPath], with: .none)
        }

        saveToUserDefaults()
    }

    func fetchData() -> [SettingModel] {
        let goalSetting1 = SettingModel(textLabel: "Goal".localized(), textValue: goalValue)
        let goalSetting2 = SettingModel(textLabel: "Starting Weight".localized(), textValue: weightValue)
        let goalSetting3 = SettingModel(textLabel: "Goal Weight".localized(), textValue: goalWeightValue)
        let goalSetting4 = SettingModel(textLabel: "Activity Level".localized(), textValue: activenessValue)
        let goalSetting5 = SettingModel(textLabel: "Weekly Goal".localized(), textValue: weeklyGoalValue)
        let goalSetting6 = SettingModel(textLabel: "Calorie Goal".localized(), textValue: goalCalorieValue)

        return [goalSetting1, goalSetting2, goalSetting3, goalSetting4, goalSetting5, goalSetting6]
    }

    func loadUserDefaults() {
        goalValue = UserDefaults.standard.string(forKey: "goal") ?? ""
        weightValue = UserDefaults.standard.string(forKey: "startingWeight") ?? ""
        goalWeightValue = UserDefaults.standard.string(forKey: "goalWeight") ?? ""
        activenessValue = UserDefaults.standard.string(forKey: "activityLevel") ?? ""
        weeklyGoalValue = UserDefaults.standard.string(forKey: "weeklyGoal") ?? ""
        goalCalorieValue = UserDefaults.standard.string(forKey: "calorieGoal") ?? ""
    }

    func saveToUserDefaults() {
        for model in goalSettingModels {
            switch model.textLabel {
            case "Goal".localized():
                UserDefaults.standard.set(model.textValue, forKey: "goal")
            case "Starting Weight".localized():
                UserDefaults.standard.set(model.textValue, forKey: "startingWeight")
            case "Goal Weight".localized():
                UserDefaults.standard.set(model.textValue, forKey: "goalWeight")
            case "Activity Level".localized():
                UserDefaults.standard.set(model.textValue, forKey: "activityLevel")
            case "Weekly Goal".localized():
                UserDefaults.standard.set(model.textValue, forKey: "weeklyGoal")
            case "Calorie Goal".localized():
                UserDefaults.standard.set(model.textValue, forKey: "calorieGoal")
            default:
                break
            }
        }
    }
}
