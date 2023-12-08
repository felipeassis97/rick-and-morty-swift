//
//  CharacterDetailsViewController.swift
//  PocViewCode
//
//  Created by Felipe Assis on 08/12/23.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    var character : CharacterModel?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.navigationItem.title = "Details"
        self.navigationItem.backButtonTitle = nil
        view.backgroundColor = .white
        view.addSubview(characterDetails)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterDetails.topAnchor.constraint(equalTo: view.topAnchor),
            characterDetails.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterDetails.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterDetails.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private lazy var characterDetails: CharacterDetailsView = {
        let details = CharacterDetailsView(character: self.character)
        details.translatesAutoresizingMaskIntoConstraints = false
        return details
    }()
    
}
