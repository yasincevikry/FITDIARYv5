//
//  ProfileViewController.swift
//  FITDIARY
//


import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

final class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let db = DatabaseSingleton.db
    private let backGroundColor = ThemesOptions.backGroundColor
    private let cellBackgColor = ThemesOptions.cellBackgColor
    
    // MARK: -UI ELEMENTS
    private lazy var table: UITableView = UITableView()
    private var profile: ProfileCellModel?
    private var goal: GoalCellModel?
    
    // MARK: VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        addRealTimeUpdate()
        fetchProfileData()
        linkViews()
        configureTableView()
        configureView()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: -VIEWS CONNECTION
    func linkViews(){
        view.backgroundColor = backGroundColor
        view.addSubview(table)
    }
    
    // MARK: -CONFIGURATION
    func configureView(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = navigationItem.title?.localized()
    }
    
    func configureTableView(){
        table.delegate = self
        table.dataSource = self
        table.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        table.register(MyGoalCell.self, forCellReuseIdentifier: MyGoalCell.identifier)
        table.backgroundColor = backGroundColor
        table.tableHeaderView?.isHidden = true
    }
    
    // MARK: -FUNCTIONS
    func addRealTimeUpdate(){
        if let currentUserEmail = Auth.auth().currentUser?.email {
            db.collection("UserInformations").document("\(currentUserEmail)")
                .addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    guard let data = document.data() else {
                        print("Document data was empty.")
                        return
                    }
                    print("Current data: \(data)")
                    self.checkProfileSettingsUpdate(data: data)
                    self.checkGoalSetttingsUpdate(data: data)
                    self.table.reloadData()
                }
        }
    }
    
    func checkProfileSettingsUpdate (data: Dictionary<String, Any>){
        if let name = data["name"]{self.profile?.name = name as? String ?? ""}
        if let height = data["height"]{self.profile?.height = "\(height)"}
        let diateryType: String = data["diateryType"] as? String ?? "Classic"
        profile?.dietaryType = diateryType.localized()
        let sex: String = data["sex"] as? String ?? "Male"
        profile?.sex = sex.localized()
    }
    
    func checkGoalSetttingsUpdate(data: Dictionary<String, Any>){
        updateCalorie(data: data)
        let goalType: String = data["goalType"] as? String ?? "Maintain Weight"
        goal?.goalType = goalType.localized()
        if let manuelCalorie = data["calorieGoal"]{self.goal?.manuelCalorieGoal = "\(manuelCalorie)"}
        if let advicedCalorie = data["calorie"]{self.goal?.advicedCalorieGoal = "\(advicedCalorie)"}
        if let isAdviced = data["adviced"]{self.goal?.isAdviced = isAdviced as? Bool ?? true}
        let activeness: String = data["activeness"] as? String ?? "Moderate"
        goal?.activeness = activeness.localized()
        if let weight = data["weight"]{
            let weightWrapped = weight as? Double ?? 0
            self.goal?.weight = String(format: "%.2f", weightWrapped)
        }
    }
    
    func updateDBValue(key: String, value: Any){
        if let currentUserEmail = Auth.auth().currentUser?.email {
            let docRef = DatabaseSingleton.db.collection("UserInformations").document("\(currentUserEmail)")
            docRef.updateData([key: value])
        }
    }
    
    func updateCalorie(data: Dictionary<String, Any>){
        var calculator = CalculatorBrain()
        calculator.calculateCalorie(data["sex"] as? String ?? "", data["weight"] as? Float ?? 0, data["height"] as? Float ?? 0, data["age"] as? Float ?? 0,data["bmh"] as? Float ?? 0,data["changeCalorieAmount"] as? Int ?? 0)
        updateDBValue(key: "calorie", value: Int(calculator.getCalorie()) ?? 0)
    }
    
    @objc func settingsButtonTapped() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    // MARK: LAYOUT
    func configureLayout(){
        table
            .anchor(top: view.safeAreaLayoutGuide.topAnchor,
                    left: view.leftAnchor,
                    bottom: view.safeAreaLayoutGuide.bottomAnchor,
                    right: view.rightAnchor,
                    paddingTop: 32,
                    paddingLeft: 16,
                    paddingBottom: 8,
                    paddingRight: 16)
    }
    
    // MARK: TABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileCell = table.dequeueReusableCell(withIdentifier: ProfileCell.identifier) as! ProfileCell
        let goalCell = table.dequeueReusableCell(withIdentifier: MyGoalCell.identifier) as! MyGoalCell
        
        switch indexPath.section {
        case 0:
            profileCell.layer.cornerRadius = 20
            profileCell.myViewController = self
            profileCell.selectionStyle = UITableViewCell.SelectionStyle.none
            profileCell.tintColor = backGroundColor
            profileCell.setProfile(model: self.profile ?? ProfileCellModel(profileImage: UIImage(named: "defaultProfilePhoto") ?? UIImage(), name: "", sex: "", dietaryType: "", height: ""))
            return profileCell
        case 1:
            goalCell.backgroundColor = cellBackgColor
            goalCell.layer.cornerRadius = 20
            goalCell.myViewController = self
            goalCell.selectionStyle = UITableViewCell.SelectionStyle.none
            goalCell.setGoalCell(model: self.goal ?? GoalCellModel(goalType: "", weight: "", activeness: "", goalWeight: "", weeklyGoal: "", manuelCalorieGoal: "", advicedCalorieGoal: "", isAdviced: true))
            return goalCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            navigationController?.pushViewController(ProfileCell.myProfileSettings, animated: true)
        default:
            return
        }
    }
}

// MARK: -DATA FETCH
extension ProfileViewController {
    func fetchProfileData() {
        if let currentUserEmail = Auth.auth().currentUser?.email {
            let docRef = db.collection("UserInformations").document("\(currentUserEmail)")
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let data = document.data() {
                        debugPrint("Document data: \(data)")
                        if let goalType = data["goalType"],
                           let weight = data["weight"],
                           let calorie = data["calorie"],
                           let sex = data["sex"],
                           let bmh = data["bmh"],
                           let isAdviced = data["adviced"],
                           let weeklyGoal = data["weeklyGoal"],
                           let goalWeight = data["goalWeight"],
                           let caloryGoal = data["calorieGoal"],
                           let height = data["height"]{
                            let weightWrapped = weight as? Double ?? 0
                            let dietaryType: String = data["diateryType"] as? String ?? "Classic"
                            var activeness: String = "Moderate".localized()
                            switch bmh as? Float{
                            case 1.2: activeness = "Low"
                            case 1.3: activeness = "Moderate"
                            case 1.4: activeness = "High"
                            case 1.5: activeness = "Very High"
                            default: debugPrint("Error happened while choosing activeness")
                            }
                            self.goal = GoalCellModel(goalType: "\(goalType)".localized(), weight: String(format: "%.2f", weightWrapped), activeness: "\(activeness)".localized(), goalWeight: "\(goalWeight)" , weeklyGoal: "\(weeklyGoal)", manuelCalorieGoal: "\(caloryGoal)", advicedCalorieGoal: "\(calorie)", isAdviced: isAdviced as! Bool)
                            self.profile = ProfileCellModel(profileImage: UIImage(named: "defaultProfilePhoto") ?? UIImage(), name: data["name"] as? String ?? "Enter a name".localized(), sex: "\(sex)".localized(), dietaryType: dietaryType.localized(), height: "\(height)")
                            self.table.reloadData()
                        }
                    }
                } else { debugPrint("Document does not exist.") }
            }
        }
    }
}
