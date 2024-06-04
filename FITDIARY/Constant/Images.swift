//
//  Images.swift
//  FITDIARY
//

import Foundation
import UIKit

enum Images {
    case Placeholder
    
    var associatedImage: UIImage {
        switch self {
        case .Placeholder:
            return UIImage(named: "imagePlaceholder") ?? UIImage.add
            
        }
    }
}

