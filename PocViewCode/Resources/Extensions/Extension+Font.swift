//
//  Extension+Font.swift
//  PocViewCode
//
//  Created by Felipe Assis on 08/12/23.
//

import Foundation
import UIKit

extension UIFont {
    
    enum InterFontType {
        case light
        case medium
        case regular
        case semiBold
        case bold
        
        func getFontName() -> String {
            switch self {
            case .light:
                return "Inter-Light"
            case .medium:
                return "Inter-Medium"
            case .regular:
                return "Inter-Regular"
            case .semiBold:
                return "Inter-SemiBold"
            case .bold:
                return "Inter-Bold"
            }
        }
        
    }
    
    static func interFont(type: InterFontType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.getFontName(), size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
}

extension UIFont {
    
    enum PoppinsFontType {
        case light
        case medium
        case regular
        case semiBold
        case bold
        
        func getFontName() -> String {
            switch self {
            case .light:
                return "Poppins-Light"
            case .medium:
                return "Poppins-Medium"
            case .regular:
                return "Poppins-Light"
            case .semiBold:
                return "Poppins-SemiBold"
            case .bold:
                return "Poppins-Bold"
            }
        }
        
    }
    
    static func poppinsFont(type: PoppinsFontType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.getFontName(), size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
}
