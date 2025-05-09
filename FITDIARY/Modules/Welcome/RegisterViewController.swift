//
//  RegisterViewController.swift
//  FITDIARY
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    // Outlet Variables
    @IBOutlet weak var emailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTextField: UILabel!
    
    // General Variables
    var check = false
    
    //MARK: - View Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        defineLabels()
        if !UIDevice.hasNotch{
            signUpButtonBottomConstraint.constant = -25
            emailTopConstraint.constant = 200
        }
        if check {
            self.performSegue(withIdentifier: "RegisterToCalculate", sender: self)
        }
    }
    
    func defineLabels(){
        errorTextField.text = errorTextField.text?.localized()
        signUpButton.setTitle(signUpButton.currentTitle?.localized(), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonStyle(button: signUpButton, cornerRadius: 0.096)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.backgroundColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "email@example.com".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "password".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        passwordTextField.backgroundColor = UIColor.white
        emailTextField.tag = 1
        passwordTextField.tag = 2
    }

    //MARK: - IBActions
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.errorTextField.text = e.localizedDescription
                }else {
                    //Navigate to the nextViewController
                    UserDefaults.standard.set(password, forKey: email)
                    self.performSegue(withIdentifier: "RegisterToCalculate", sender: self)
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
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
     nextField.becomeFirstResponder()
     } else {
     textField.resignFirstResponder()
     }
     return false
     }

} // ends of extension:UITextFieldDelegate

