//
//  DatabaseSingleton.swift
//  FITDIARY
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class DatabaseSingleton {
    static let db = Firestore.firestore()
    static let storage = Storage.storage()
    init(){}
}

