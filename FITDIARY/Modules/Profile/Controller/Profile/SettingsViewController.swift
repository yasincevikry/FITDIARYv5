//
//  SettingsViewController.swift
//  FITDIARY
//


import UIKit

final class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let backGroundColor = ThemesOptions.backGroundColor
    private var optionList: [ProfileOption] = []
    
    // MARK: -UI ELEMENTS
    private lazy var tableView = UITableView()
    
    private lazy var tableTitle = {
        let label = UILabel()
        label.text = "Settings".localized()
        label.font = UIFont(name: "Copperplate Bold", size: 33)
        label.textColor = .white
        return label
    }()
    
    // MARK: -VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        optionList = fetchData()
        linkViews()
        configureView()
        configureTableView()
        configureLayout()
    }
    
    // MARK: -VIEWS CONNECTION
    func linkViews(){
        view.addSubview(tableTitle)
        view.addSubview(tableView)
    }
    
    // MARK: -CONFIGURATION
    func configureView(){
        view.backgroundColor = backGroundColor
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func configureTableView(){
        setTableViewDelegates()
        tableView.backgroundColor = backGroundColor
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        tableView.rowHeight = 64
    }
    
    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
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
                    bottom: view.bottomAnchor,
                    right: tableTitle.rightAnchor)
    }
    
    // MARK: -TABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier) as! SettingsCell
        let settingOption = optionList[indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setSetting(setting: settingOption)
        cell.backgroundColor = backGroundColor
        cell.tintColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0:
            navigationController?.pushViewController(AccountSettingsController(), animated: true)
            
        case 1:
            navigationController?.pushViewController(ProfileCell.myProfileSettings, animated: true)
            
        case 2:
            navigationController?.pushViewController(MyGoalCell.myGoalSettings, animated: true)
            
//        case 3:
//            navigationController?.pushViewController(AboutUsController(), animated: true)
            
        default:
            print("ERROR!")
        }
    }
}

// MARK: -FETCH DATA
extension SettingsViewController {
    func fetchData() -> [ProfileOption]{
        let option1 = ProfileOption(image: UIImage(systemName: "lock.fill") ?? UIImage(), title: "Account".localized())
        let option2 = ProfileOption(image: UIImage(systemName: "person.circle.fill") ?? UIImage(), title: "Profile".localized())
        let option3 = ProfileOption(image: UIImage(systemName: "flag.fill") ?? UIImage(), title: "My Goals".localized())
//        let option4 = ProfileOption(image: UIImage(systemName: "questionmark.app.fill") ?? UIImage(), title: "About Us".localized())

        return[option1, option2, option3]
    }
}
