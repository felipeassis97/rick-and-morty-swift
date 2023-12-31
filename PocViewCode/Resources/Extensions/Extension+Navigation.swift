//
//  Extension+Navigation.swift
//  PocViewCode
//
//  Created by Felipe Assis on 08/12/23.
//

import Foundation
import UIKit

extension UINavigationController {
    
    static func customTopBar(rootViewController: UIViewController) -> UINavigationController {
        
        let navigation = UINavigationController(rootViewController: rootViewController)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple]
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.poppinsFont(type: .semiBold, size: 20)]

        
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple]
        navigation.navigationBar.scrollEdgeAppearance = appearance
        navigation.navigationBar.standardAppearance = appearance
        navigation.navigationController?.navigationBar.compactAppearance = appearance
        navigation.navigationController?.navigationBar.tintColor = .purple
        navigation.navigationBar.barTintColor = .white
        
        return navigation

    }
    
}
