//
//  ProfileThemeOptions.swift
//  FITDIARY
//

import UIKit
import iOSDropDown

struct ThemesOptions{
    
    static let backGroundColor = UIColor(red: 254/255.0, green: 209/255.0, blue: 134/255.0, alpha: 1.0)
    static let cellBackgColor = UIColor(red: 254/255.0, green: 209/255.0, blue: 134/255.0, alpha: 1.0)
    static let buttonBackGColor = UIColor(red: 221/255.0, green: 185/255.0, blue: 137/255.0, alpha: 1.0)
    static let figureColor = UIColor(red: 254/255.0, green: 209/255.0, blue: 134/255.0, alpha: 1.0)
    
    static let dropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.backgroundColor = cellBackgColor
        dropDown.textColor = .white
        dropDown.cornerRadius = 10
        return dropDown
    }()
}
