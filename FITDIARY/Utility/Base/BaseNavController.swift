//
//  BaseNavController.swift
//  FITDIARY
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class BaseNavController: UINavigationController {
    
    var exist: Bool?
    var user = Auth.auth().currentUser
    var store = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
