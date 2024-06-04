//
//  WelcomeViewController.swift
//  FITDIARY
//

import UIKit

import UIKit

class WelcomeViewController: UIViewController {

    //Outlet variables
    @IBOutlet weak var logInBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var firstInfoLabel: UILabel!
    @IBOutlet weak var thirdInfoLabel: UILabel!
    
    //General variables
    var percentage = 0
    var counter = 0
    var timer: Timer?
    
    //MARK: - View Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        defineLabels()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        if !UIDevice.hasNotch{
//            logInBottomConstraint.constant = -20
        }
    }
    
    func defineLabels(){
        firstInfoLabel.text = firstInfoLabel.text?.localized()
        getStartedButton.setTitle(getStartedButton.currentTitle?.localized(), for: .normal)
        logInButton.setTitle(logInButton.currentTitle?.localized(), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonStyle(button: getStartedButton, cornerRadius: 0.096)
        setupButtonStyle(button: logInButton, cornerRadius: 0.09)
        
        //Title Label Animation With For Loop
        firstInfoLabel.text = ""
        var charIndex = 0.0
        let titleText = "💪 Lose weight, build muscle, simply get healthy.".localized()
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.06*charIndex, repeats: false) { (timer) in
                self.firstInfoLabel.text?.append(letter)
            }
            charIndex += 1
        }
        incrementLabel(amount: 12)
    }
    
    //MARK: - Supporting Functions
    func setupButtonStyle(button : UIButton,cornerRadius: Float){
        button.layer.cornerRadius = CGFloat(cornerRadius) * button.bounds.size.width
        button.clipsToBounds = true
    }
    
    func incrementLabel(amount: Int) {
        counter = amount
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateDelay), userInfo: nil, repeats: true)
    }

    @objc func updateDelay() {
        if (counter > 0) {
            counter -= 1
            percentage += 1
            if percentage == 6 {
                //Title Label Animation With For Loop
                infoLabel.text = ""
                var charIndex = 0.0
                let titleText = "🧑‍🍳 Discover healthy, happy file with me.".localized()
                for letter in titleText {
                    Timer.scheduledTimer(withTimeInterval: 0.06*charIndex, repeats: false) { (timer) in
                        self.infoLabel.text?.append(letter)
                    }
                    charIndex += 1
                }
            }
            if percentage == 12 {
                //Title Label Animation With For Loop
                thirdInfoLabel.text = ""
                var charIndex = 0.0
                let titleText = "🙏 FitDiary help you for everything.".localized()
                for letter in titleText {
                    Timer.scheduledTimer(withTimeInterval: 0.06*charIndex, repeats: false) { (timer) in
                        self.thirdInfoLabel.text?.append(letter)
                    }
                    charIndex += 1
                }
            }
        } else {
            timer!.invalidate()
            timer = nil
        }
    }
    
}



