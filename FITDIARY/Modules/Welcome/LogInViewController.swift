//
//  LogInViewController.swift
//  FITDIARY
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    // Outler Variables
    @IBOutlet weak var emailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logInButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTextField: UILabel!
    
    //MARK: - View Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        defineLabels()
        if !UIDevice.hasNotch{
            logInButtonBottomConstraint.constant = -25
            emailTopConstraint.constant = 200
        }
    }
    
    func defineLabels(){
        errorTextField.text = errorTextField.text?.localized()
        logInButton.setTitle(logInButton.currentTitle?.localized(), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonStyle(button: logInButton, cornerRadius: 0.096)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.backgroundColor = UIColor.white
        passwordTextField.backgroundColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "email@example.com".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "password".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        emailTextField.tag = 1
        passwordTextField.tag = 2
    }
    
    //MARK: - IBActions
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            UserDefaults.standard.set(password, forKey: email)
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.errorTextField.text = e.localizedDescription
                }else {
                    //Navigate to the nextViewController
                    self.performSegue(withIdentifier: "LoginToCalculate", sender: self)
                }
            }
        }
    }
    
    //MARK: - Setup Functions
    func setupButtonStyle(button : UIButton,cornerRadius: Float){
        button.layer.cornerRadius = CGFloat(cornerRadius) * button.bounds.size.width
        button.clipsToBounds = true
    }
    
}

//MARK: - UITextFieldDelegate
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
     nextField.becomeFirstResponder()
     } else {
     textField.resignFirstResponder()
     }
     return false
     }

} // ends of extension:UITextFieldDelegate

