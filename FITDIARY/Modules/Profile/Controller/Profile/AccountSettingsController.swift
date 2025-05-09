//
//  AccountSettingsController.swift
//  FITDIARY
//

import UIKit
import iOSDropDown
import FirebaseAuth
import FirebaseFirestore
import CoreData

final class AccountSettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private let user = Auth.auth().currentUser
    private var docCopy: [String : Any]?
    private let db = DatabaseSingleton.db
    private var userPassword = UserDefaults.standard.string(forKey: Auth.auth().currentUser?.email ?? "")
    private var userEmail = Auth.auth().currentUser?.email
    private var accountSettingModels: [SettingModel] = []
    private let backGroundColor = ThemesOptions.backGroundColor
    private let cellBackgColor = ThemesOptions.cellBackgColor
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: -UI ELEMENTS
    private lazy var tableView: UITableView = UITableView()

    private lazy var tableTitle = {
        let label = UILabel()
        label.text = "Account Settings".localized()
        label.textColor = .white
        label.font = UIFont(name: "Copperplate Bold", size: 33)
        return label
    }()
    private lazy var deleteButton = {
        let button = UIButton()
        button.setTitle("Delete".localized(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.backgroundColor = ThemesOptions.buttonBackGColor
        button.layer.cornerRadius = 20
        return button
    }()
    private lazy var logOutButton = {
        let button = UIButton()
        button.setTitle("Log Out".localized(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.backgroundColor = ThemesOptions.buttonBackGColor
        button.layer.cornerRadius = 20
        return button
    }()
    
    // MARK: -VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        accountSettingModels = fetcData()
        linkViews()
        configureView()
        configureTableView()
        configureLayout()
    }
    
    // MARK: -VIEWS CONNECTION
    func linkViews(){
        view.addSubview(tableView)
        view.addSubview(tableTitle)
        view.addSubview(deleteButton)
        view.addSubview(logOutButton)
    }
    
    // MARK: -CONFIGURATION
    func configureView(){
        view.backgroundColor = backGroundColor
        navigationItem.largeTitleDisplayMode = .never
        deleteButton.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
        logOutButton.addTarget(self, action: #selector(logOutAccount), for: .touchUpInside)
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSettingCell.self, forCellReuseIdentifier: AccountSettingCell.identifier)
        tableView.backgroundColor = backGroundColor
    }
    
    // MARK: -FUNCTIONS
    @objc func deleteAccount(){
        showSimpleAlert(title: "Are you sure you want to Delete ?".localized(), firstResponse: "Cancel".localized(), secondResponse: "Delete".localized())
    }
    
    @objc func logOutAccount(){
        showSimpleAlert(title: "Are you sure you want to Log Out ?".localized(), firstResponse: "Cancel".localized(), secondResponse: "Log Out".localized())
    }
    
    func showSimpleAlert(title: String, firstResponse: String, secondResponse: String) {
        let alert = UIAlertController(title: title, message: nil,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: firstResponse, style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
            }))
            alert.addAction(UIAlertAction(title: secondResponse,
                                          style: UIAlertAction.Style.destructive,
                                          handler: {(_: UIAlertAction!) in
                switch secondResponse {
                case "Log Out".localized():
                    self.logOut()
                case "Delete".localized():
                    self.delete()
                default:
                    return
                }
            }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func delete(){
        self.user!.delete { error in
            if let error = error {
                let alert = UIAlertController(title: "Deletion unsuccessfull!".localized(), message: "Sorry for inconvenience situation. Deletion of an account is sensitive process. You should be re-signed into your account to perform this process.".localized(), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay".localized(), style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(error)
            } else {
                // Account deleted.
                print("Account deleted.".localized())
                self.deleteAllOnlineData()
                self.deleteAllOfflineData()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "nRoot")
                self.view.window?.rootViewController = rootViewController
                self.navigationController?.popToRootViewController(animated: true)
            }
    }
    }
    
    func logOut(){
        let auth = Auth.auth()
        //Sign out action
        do {
            deleteAllOfflineData()
            try auth.signOut()
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let rootViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "nRoot")
            self.view.window?.rootViewController = rootViewController
            self.navigationController?.popToRootViewController(animated: true)

        }catch _{}
    }
    
    func deleteAllOnlineData(){
        if let currentUserEmail = userEmail {
            let docRef = self.db.collection("UserInformations").document(currentUserEmail)
            
            docRef.delete(){ err in
                if let err = err {
                    debugPrint("Errorqe removing document: \(err)")
                }
                else {
                    debugPrint("Errorqenot successfully removed!")
                }
            }
        }
    }
    
    func deleteAllOfflineData(){
        let context1 = self.appDelegate.persistentContainer
        let context2 = self.appDelegate.persistentContainer2
        let context3 = self.appDelegate.persistentContainer3
        deleteOfflineData("FoodRecipe", context1)
        deleteOfflineData("FoodEntity", context2)
        deleteOfflineData("FavFoodEntity", context3)
    }
    
    func deleteOfflineData(_ entity:String,_ container: NSPersistentContainer) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                container.viewContext.delete(objectData)
            }
            try? container.viewContext.save()
        } catch let error {
            debugPrint("Detele all data in \(entity) error :", error)
        }
    }
        
    // MARK: -LAYOUT
    func configureLayout(){
        tableTitle
            .anchor(top: view.safeAreaLayoutGuide.topAnchor,
                    left: view.leftAnchor,
                    bottom: tableView.topAnchor,
                    right: view.rightAnchor,
                    paddingTop: 32,
                    paddingLeft: 16,
                    paddingBottom: 16,
                    paddingRight: 16)
        
        tableView
            .anchor(top: tableTitle.bottomAnchor,
                    left: tableTitle.leftAnchor,
                    bottom: deleteButton.topAnchor,
                    right: tableTitle.rightAnchor)
        
        deleteButton
            .anchor(width: 256,
                    height: 48)
        
        deleteButton
            .centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        logOutButton
            .anchor(top: deleteButton.bottomAnchor,
                    bottom: view.safeAreaLayoutGuide.bottomAnchor,
                    paddingTop: 32,
                    paddingBottom: 32,
                    width: 256,
                    height: 48)
        
        logOutButton
            .centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: -TABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accountSettingModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSettingCell.identifier) as! AccountSettingCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = backGroundColor
        cell.myViewController = self
        cell.setAccountSettings(model: accountSettingModels[indexPath.row])
        return cell
    }

}
// MARK: -DATA FETCH
extension AccountSettingsController {
    func fetcData() -> [SettingModel]{
        let accountSetting1 = SettingModel(textLabel: "Email Adress".localized(), textValue: userEmail ?? "")
        let accountSetting2 = SettingModel(textLabel: "Password".localized(), textValue: userPassword ?? "")
        
        return [accountSetting1, accountSetting2]
    }
}
