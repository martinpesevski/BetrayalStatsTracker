//
//  ViewController.swift
//  Betrayal stat tracker
//
//  Created by Martin Peshevski on 4.3.21.
//

import UIKit
import SnapKit

struct StatValue: Equatable {
    let value: Int
    let isDefault: Bool
    let isDeath: Bool
    var isSelected: Bool
    
    init(value: Int, isDefault: Bool = false, isDeath: Bool = false) {
        self.value = value
        self.isDefault = isDefault
        self.isDeath = isDeath
        self.isSelected = isDefault
    }
    
    var isDead: Bool { isDeath == isSelected }
}

struct Character {
    let name: String
    let might: [StatValue]
    let speed: [StatValue]
    let knowledge: [StatValue]
    let sanity: [StatValue]
}

class ViewController: UIViewController {
    let character: Character
    lazy var mainStack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.alignment = .center
        s.spacing = 25
        s.distribution = .fill
        return s
    }()
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 0
        l.textColor = .label
        l.textAlignment = .center
        return l
    }()
    lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    init(character: Character) {
        self.character = character
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        mainStack.addArrangedSubview(characterImage)
        characterImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(characterImage.snp.width)
        }
        
        titleLabel.text = character.name
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(UIView())

        mainStack.addArrangedSubview(StatHolder(stats: character.might))
        
        mainStack.addArrangedSubview(StatHolder(stats: character.speed))
        
        mainStack.addArrangedSubview(StatHolder(stats: character.knowledge))
        
        mainStack.addArrangedSubview(StatHolder(stats: character.sanity))
        
        
        view.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in make.edges.equalTo(view.layoutMarginsGuide).inset(20) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

