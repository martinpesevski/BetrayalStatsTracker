//
//  ViewController.swift
//  Betrayal stat tracker
//
//  Created by Martin Peshevski on 4.3.21.
//

import UIKit
import SnapKit

class CharactersPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
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
        self.characters = characters
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        for character in characters {
            let controller = CharacterViewController(character: character)
            controller.characterDelegate = self
            controllers.append(controller)
        }
        
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

extension CharactersPageViewController: CharacterViewControllerDelegate {
    func didUpdateCharacter(_ character: Character) {
        guard let index = characters.firstIndex(where: {$0.name == character.name}) else { return }
        characters[index] = character
        PersistenceManager.saveCharacters(characters)
    }
}
