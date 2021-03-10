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

class ViewController: UIViewController {
    let character: Character
    lazy var mainStack: UIStackView = {
        let s = UIStackView()
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
        return l
    }()
    lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
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

        
        titleLabel.text = character.name
        characterImage.image = character.image
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(UIView())

        mainStack.addArrangedSubview(StatHolder(stats: character.might, title: "Might"))
        
        mainStack.addArrangedSubview(StatHolder(stats: character.speed, title: "Speed"))
        
        mainStack.addArrangedSubview(StatHolder(stats: character.knowledge, title: "Knowledge"))
        
        mainStack.addArrangedSubview(StatHolder(stats: character.sanity, title: "Sanity"))
        
        
        view.addSubview(mainStack)
        characterImage.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(80)
            make.height.equalTo(characterImage.snp.width)
        }
        mainStack.snp.makeConstraints { make in
            make.left.right.equalTo(view.layoutMarginsGuide)
            make.bottom.top.equalTo(view.layoutMarginsGuide).inset(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

