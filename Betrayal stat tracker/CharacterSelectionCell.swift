//
//  CharacterSelectionCell.swift
//  Betrayal stat tracker
//
//  Created by Martin Peshevski on 8/22/22.
//

import UIKit

class CharacterSelectionCell: UICollectionViewCell {
    lazy var image: UIImageView = {
        let l = UIImageView()
        l.contentMode = .scaleAspectFill
        
        return l
    }()
    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    lazy var containerStack: UIStackView = {
        let l = UIStackView(arrangedSubviews: [image, nameLabel])
        l.axis = .vertical
        l.alignment = .center
        l.spacing = 5
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = 6

        contentView.addSubview(containerStack)
        containerStack.snp.makeConstraints { make in make.edges.equalToSuperview().inset(5) }
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                backgroundColor = .systemGray3
            } else {
                backgroundColor = .clear
            }
        }
    }

    func setup(character: Character) {
        image.image = character.image
        nameLabel.text = character.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
