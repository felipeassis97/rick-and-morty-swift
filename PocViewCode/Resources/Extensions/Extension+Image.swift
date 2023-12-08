//
//  Extension+Image.swift
//  PocViewCode
//
//  Created by Felipe Assis on 03/12/23.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        let request = URLRequest(url: imageURL)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                self.image = UIImage(named: "default")
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

extension UIImageView {
    func loadImageByUrl(path: String){
        if let url = URL(string: path), let data = try? Data(contentsOf: url) {
            self.image = UIImage(data: data)
        }else{
            self.image = nil
        }
    }
}

extension UIImageView {

    func setRounded(anyImage: UIImage) {
        self.contentMode = .scaleAspectFill
            self.layer.cornerRadius = self.frame.height / 2
            self.layer.masksToBounds = false
            self.clipsToBounds = true

    }
}

