//
//  CharacterViewController.swift
//  Betrayal stat tracker
//
//  Created by Martin Peshevski on 8/22/22.
//

import UIKit

protocol CharacterViewControllerDelegate: AnyObject {
    func didUpdateCharacter(_ character: Character)
}

class CharacterViewController: UIViewController, StatHolderDelegate {
    var might = StatHolderView(stats: Flash.might, type: .might)
    var speed = StatHolderView(stats: Flash.speed, type: .speed)
    var knowledge = StatHolderView(stats: Flash.knowledge, type: .knowledge)
    var sanity = StatHolderView(stats: Flash.sanity, type: .sanity)
    
    let isSmallDevice = UIScreen.main.bounds.height <= 736
    
    weak var characterDelegate: CharacterViewControllerDelegate?
    
    var character: Character

    lazy var mainStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [characterImage, titleLabel, UIView(), might, speed, knowledge, sanity])
        s.axis = .vertical
        s.alignment = .center
        s.spacing = 10
        s.distribution = .fill
        return s
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 0
        l.textColor = .label
        l.textAlignment = .center
        l.isHidden = isSmallDevice
        return l
    }()
    lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
        
        might.delegate = self
        speed.delegate = self
        knowledge.delegate = self
        sanity.delegate = self
                
        view.addSubview(mainStack)
        let inset = isSmallDevice ? 100 : 80
        characterImage.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(inset)
            make.height.equalTo(characterImage.snp.width)
        }
        mainStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(isSmallDevice ? 100 : 130)
            make.bottom.equalToSuperview().inset(100)
        }

        titleLabel.text = character.name
        characterImage.image = character.image
        
        might.setup(stats: character.might)
        speed.setup(stats: character.speed)
        knowledge.setup(stats: character.knowledge)
        sanity.setup(stats: character.sanity)
    }
    
    func didUpdateSelected(type: StatType, selected: Int) {
        
        character.setSelected(type: type, index: selected)
        characterDelegate?.didUpdateCharacter(character)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
