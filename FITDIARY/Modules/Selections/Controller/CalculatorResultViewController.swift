//
//  CalculatorResultViewController.swift
//  FITDIARY
//

import UIKit

class CalculatorResultViewController: UIViewController {
    
    // Outlet Variables
    @IBOutlet weak var dailyLabel: UILabel!
    @IBOutlet weak var nextButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var calorieSublabel: UILabel!
    @IBOutlet weak var resultNextButton: UIButton!
    
    // General Variables
    var advice: String?
    var color: UIColor?
    var calorie: String?
    var CalorieSublabelField: String?
    var bmiValue: String?
    
    //MARK: - View Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        defineLabels()
        if !UIDevice.hasNotch{
            nextButtonConstraint.constant = -25
        }
    }
    
    func defineLabels(){
        resultLabel.text = resultLabel.text?.localized()
        adviceLabel.text = adviceLabel.text?.localized()
        calorieSublabel.text = calorieSublabel.text?.localized()
        dailyLabel.text = dailyLabel.text?.localized()
        resultNextButton.setTitle(resultNextButton.currentTitle?.localized(), for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonStyle(button: resultNextButton, cornerRadius: 0.096)
        if let bmiValue {
            //Title Label Animation With For Loop
            bmiLabel.text = ""
            var charIndex = 0.0
            let titleText = bmiValue
            for letter in titleText {
                Timer.scheduledTimer(withTimeInterval: 0.23*charIndex, repeats: false) { (timer) in
                    self.bmiLabel.text?.append(letter)
                }
                charIndex += 1
            }
        }
        if let advice {
            adviceLabel.text = advice.localized()
        }
        if let color {
            bmiLabel.textColor = color
        }
        if let CalorieSublabelField {
            calorieSublabel.text = CalorieSublabelField.localized()
        }
        if let calorie {
            //Title Label Animation With For Loop
            calorieLabel.text = ""
            var charIndex = 0.0
            let titleText = calorie + " kcal"
            for letter in titleText {
                Timer.scheduledTimer(withTimeInterval: 0.13*charIndex, repeats: false) { (timer) in
                    self.calorieLabel.text?.append(letter)
                }
                charIndex += 1
            }
        }
    }
    
    
    
    //MARK: - IBActions
    @IBAction func resultNextButtonPressed(_ sender: UIButton) {
    }
    
    //MARK: - Supporting Functions
    func setupButtonStyle(button : UIButton,cornerRadius: Float){
        button.layer.cornerRadius = CGFloat(cornerRadius) * button.bounds.size.width
        button.clipsToBounds = true
    }
}


