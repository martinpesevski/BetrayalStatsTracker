//
//  ViewController.swift
//  Betrayal stat tracker
//
//  Created by Martin Peshevski on 4.3.21.
//

import UIKit
import SnapKit

struct StatValue: Equatable, Codable {
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

enum StatType {
    case might
    case speed
    case knowledge
    case sanity
    
    var title: String {
        switch self {
        case .might: return "Might"
        case .speed: return "Speed"
        case .knowledge: return "Knowledge"
        case .sanity: return "Sanity"
        }
    }
}

protocol CharacterViewControllerDelegate: AnyObject {
    func didUpdateCharacter(_ character: Character)
}

class CharacterViewController: UIViewController, StatHolderDelegate {
    var might = StatHolder(stats: Flash.might, type: .might)
    var speed = StatHolder(stats: Flash.speed, type: .speed)
    var knowledge = StatHolder(stats: Flash.knowledge, type: .knowledge)
    var sanity = StatHolder(stats: Flash.sanity, type: .sanity)
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

class ViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = controllers.firstIndex(of: viewController as? CharacterViewController ?? controllers[0]) ?? 0
        index -= 1
        if index < 0 { index = controllers.count - 1 }
        return controllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = controllers.firstIndex(of: viewController as? CharacterViewController ?? controllers[0]) ?? 0
        index += 1
        if index > controllers.count - 1 { index = 0 }
        return controllers[index]
    }
    
    var controllers: [CharacterViewController] = []
    var characters: [Character]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        delegate = self
        dataSource = self
        setViewControllers([controllers[0]], direction: .forward, animated: true)
        
        let menu = UIButton(type: .custom)
        menu.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        menu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        menu.addTarget(self, action: #selector(onMenu), for: .touchUpInside)
        let menuB = UIBarButtonItem(customView: menu)
        navigationItem.leftBarButtonItem = menuB
        
    }
    
    init(characters: [Character]) {
        for character in characters {
            controllers.append(CharacterViewController(character: character))
        }
        self.characters = characters
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        PersistenceManager.saveCharacters(characters)
    }
    
    @objc
    func onMenu() {
        let alert = UIAlertController(title: "Are you sure you want to exit the game?", message: "Your current progress will be lost", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            PersistenceManager.clearEverything()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: CharacterViewControllerDelegate {
    func didUpdateCharacter(_ character: Character) {
        guard let index = characters.firstIndex(where: {$0.name == character.name}) else { return }
        characters[index] = character
        PersistenceManager.saveCharacters(characters)
    }
}

class PersistenceManager {
    static func clearEverything() {
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: "betrayal characters")
    }
    
    static func saveCharacters(_ characters: [Character]) {
        let defaults = UserDefaults.standard
        
        defaults.set(characters, forKey: "betrayal characters")
    }
    
    static func loadCharacters() -> [Character]? {
        let defaults = UserDefaults.standard
        
        return defaults.object(forKey: "betrayal characters") as? [Character]
    }
}

