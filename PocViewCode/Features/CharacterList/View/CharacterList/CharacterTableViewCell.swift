//
//  UserItemTableViewCell.swift
//  PocViewCode
//
//  Created by Felipe Assis on 03/12/23.
//

import Foundation
import UIKit

class CharacterTableViewCell :  UITableViewCell {
    static let identifier: String = "UserItemTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData(character: CharacterModel?) {
        characterNameLabel.text = character?.name
        characterGenderLabel.text = character?.gender
        characterImage.loadImage(url: character?.image ?? "")
    }
    
    private func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(stackView)
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            
            characterImage.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppinsFont(type: .semiBold, size: 16)
        return label
    }()
    
    private lazy var characterGenderLabel : UILabel = {
        let label = UILabel()
        label.font = .poppinsFont(type: .light, size: 14)
        return label
    }()
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [characterImage, characterNameLabel, characterGenderLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16,
                                                                     leading: 24,
                                                                     bottom: 16,
                                                                     trailing: 24)
        stackView.spacing = 16
        return stackView
    }()
}
