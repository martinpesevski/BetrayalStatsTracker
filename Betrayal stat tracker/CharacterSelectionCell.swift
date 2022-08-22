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
    lazy var selectionNumberView: UIView = {
        let l = UIView()
        l.snp.makeConstraints { make in make.width.height.equalTo(20) }
        l.backgroundColor = .systemBlue
        l.layer.cornerRadius = 10
        l.isHidden = true
        l.addSubview(selectionNumberLabel)
        selectionNumberLabel.snp.makeConstraints { make in make.center.equalToSuperview() }
        
        return l
    }()
    lazy var selectionNumberLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
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
        addSubview(selectionNumberView)
        selectionNumberView.snp.makeConstraints{ make in make.top.left.equalToSuperview().inset(5) }
        containerStack.snp.makeConstraints { make in make.edges.equalToSuperview().inset(5) }
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                selectionNumberView.alpha = 0
                selectionNumberView.isHidden = false
                UIView.animate(withDuration: 0.2, delay: 0) {
                    self.backgroundColor = .systemGray3
                    self.selectionNumberView.alpha = 1
                }
            } else {
                UIView.animate(withDuration: 0.15, delay: 0) {
                    self.backgroundColor = .clear
                    self.selectionNumberView.alpha = 0
                } completion: { _ in
                    self.selectionNumberView.isHidden = true
                }
            }
        }
    }
    
    func selectedNumber(number: Int) {
        selectionNumberLabel.text = "\(number)"
    }

    func setup(character: Character) {
        image.image = character.image
        nameLabel.text = character.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
