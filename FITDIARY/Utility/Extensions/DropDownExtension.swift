import UIKit
import iOSDropDown
import RSSelectionMenu

extension UIViewController {

    func setDropDown(dataSource: [String], anchorView: UIView, bottomOffset: CGPoint) -> DropDown{
        ThemesOptions.dropDown.optionArray = dataSource
//        ThemesOptions.dropDown. = anchorView
//        ThemesOptions.dropDown.bottomOffset = bottomOffset
        ThemesOptions.dropDown.cornerRadius = 10
        
//        ThemesOptions.RSSelectionMenu. = bo
//        ThemesOptions.RSSelectionMenu.anchorView = anchorView
//        ThemesOptions.RSSelectionMenu.bottomOffset = bottomOffset
        
        return ThemesOptions.dropDown
    }
}

extension UIView {

    func setDropDown(dataSource: [String], anchorView: UIView, bottomOffset: CGPoint) -> DropDown{
        ThemesOptions.dropDown.optionArray = dataSource
//        ThemesOptions.dropDown.anchorView = anchorView
//        ThemesOptions.dropDown.bottomOffset = bottomOffset
        ThemesOptions.dropDown.cornerRadius = 10
        
        return ThemesOptions.dropDown
    }

}
