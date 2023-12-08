//
//  CharacterDetailsView.swift
//  PocViewCode
//
//  Created by Felipe Assis on 08/12/23.
//

import UIKit

class CharacterDetailsView: UIView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(character: CharacterModel?){
        super.init(frame: .zero)
        setupView()
        if let character = character {
            name.text = character.name
            gender.text = character.gender
            characterImage.loadImage(url: character.image)
        }
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(detailsItems)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            detailsItems.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            detailsItems.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            detailsItems.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private lazy var detailsItems: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [characterImage,characterBasicInfos])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return stack
    }()
    
    private lazy var characterBasicInfos: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [statusIcon, name, genderIcon, gender])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.spacing = 3
        stack.axis = .horizontal
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return stack
    }()
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var statusIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "status")
        image.contentMode = .scaleAspectFit
        image.heightAnchor.constraint(equalToConstant: 24).isActive = true
        image.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return image
    }()
    
    private lazy var genderIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "gender")
        image.contentMode = .scaleAspectFit
        image.heightAnchor.constraint(equalToConstant: 24).isActive = true
        image.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return image
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppinsFont(type: .medium, size: 16)
        return label
    }()
    
    private lazy var gender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppinsFont(type: .medium, size: 16)
        return label
    }()
    
}
