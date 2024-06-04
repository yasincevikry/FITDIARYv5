//  Colors.swift
//  FITDIARY
//

import Foundation
import UIKit

enum ThemeColors {
    case colorLightGreen
    case colorGreen
    case colorDarkGreen
    case colorHardDarkGreen
    case colorLightOrange
    case colorOrange
    case colorDarkOrange
    
    //If using color with type UIColor.
    var associatedColor: UIColor {
        switch self {
            //rgb(132, 198, 155)
        case .colorLightGreen:
            return UIColor(named: "ColorLightGreen") ?? UIColor(red: 132/255.0, green: 198/255.0, blue: 155/255.0, alpha: 1.0)
            //rgb(47, 136, 134)
        case .colorGreen:
            return UIColor(named: "ColorGreen") ?? UIColor(red: 47/255.0, green: 136/255.0, blue: 134/255.0, alpha: 1.0)
            //rgb(40, 71, 92)
        case .colorDarkGreen:
            return UIColor(named: "ColorDarkGreen") ?? UIColor(red: 40/255.0, green: 71/255.0, blue: 92/255.0, alpha: 1.0)
            //rgb(26, 47, 75)
        case .colorHardDarkGreen:
            return UIColor(named: "ColorHardDarkGreen") ?? UIColor(red: 26/255.0, green: 47/255.0, blue: 75/255.0, alpha: 1.0)
        case .colorLightOrange:
            return UIColor(named: "ColorLightOrange") ?? UIColor(red: 254/255.0, green: 209/255.0, blue: 134/255.0, alpha: 1.0)
        case .colorOrange:
            return UIColor(named: "ColorOrange") ?? UIColor(red: 250/255.0, green: 180/255.0, blue: 90/255.0, alpha: 1.0)
        case .colorDarkOrange:
            return UIColor(named: "ColorDarkOrange") ?? UIColor(red: 175/255.0, green: 142/255.0, blue: 90/255.0, alpha: 1.0)

        }
    }
    
    //If using color with type CGColor.
    var CGColorType: CGColor {
        switch self {
            //rgb(132, 198, 155)
        case .colorLightGreen:
            return UIColor(named: "ColorLightGreen")?.cgColor ?? CGColor(red: 132/255.0, green: 198/255.0, blue: 155/255.0, alpha: 1.0)
            //rgb(47, 136, 134)
        case .colorGreen:
            return UIColor(named: "ColorGreen")?.cgColor ?? CGColor(red: 47/255.0, green: 136/255.0, blue: 134/255.0, alpha: 1.0)
            //rgb(40, 71, 92)
        case .colorDarkGreen:
            return UIColor(named: "ColorDarkGreen")?.cgColor ?? CGColor(red: 40/255.0, green: 71/255.0, blue: 92/255.0, alpha: 1.0)
            //rgb(26, 47, 75)
        case .colorHardDarkGreen:
            return UIColor(named: "ColorHardDarkGreen")?.cgColor ?? CGColor(red: 26/255.0, green: 47/255.0, blue: 75/255.0, alpha: 1.0)
        case .colorLightOrange:
            return UIColor(named: "ColorLightOrange")?.cgColor ?? CGColor(red: 254/255.0, green: 209/255.0, blue: 134/255.0, alpha: 1.0)
        case .colorOrange:
            return UIColor(named: "ColorLightOrange")?.cgColor ?? CGColor(red: 250/255.0, green: 180/255.0, blue: 90/255.0, alpha: 1.0)
        case .colorDarkOrange:
            return UIColor(named: "ColorDarkOrange")?.cgColor ?? CGColor(red: 175/255.0, green: 142/255.0, blue: 90/255.0, alpha: 1.0)

        }
    }
}

enum SpecialColors {
    case strokeColorDarkGreen
    //If using color with type UIColor.
    var associatedColor: UIColor {
        switch self {
            //rgb(47, 160, 134)
        case .strokeColorDarkGreen:
            return UIColor(red: 47/255, green: 160/255, blue: 134/255, alpha: 1)
        }
    }
    //If using color with type CGColor.
    var CGColorType: CGColor {
        switch self {
            //rgb(47, 160, 134)
        case .strokeColorDarkGreen:
            return UIColor(red: 47/255, green: 160/255, blue: 134/255, alpha: 1).cgColor
        }
    }
}

