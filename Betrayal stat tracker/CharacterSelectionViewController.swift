//
//  CharacterSelection.swift
//  Betrayal stat tracker
//
//  Created by Martin Peshevski on 7.3.21.
//

import UIKit

class CharacterSelectionViewController: UIViewController {
    let characters = [Characters.flash.character,
                      Characters.oxBellows.character,
                      Characters.jennyLeClerc.character,
                      Characters.heatherGranville.character,
                      Characters.vivianLopez.character,
                      Characters.madameZostra.character,
                      Characters.missyDubourde.character,
                      Characters.zoeIngstrom.character,
                      Characters.fatherReinhardt.character,
                      Characters.longfellow.character,
                      Characters.brandonJaspers.character,
                      Characters.peterAkimoto.character]

    var selectedCharacters: [Character] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.size.width / 2) - 46
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let t = UICollectionView(frame: .zero, collectionViewLayout: layout)
        t.dataSource = self
        t.delegate = self
        t.register(CharacterSelectionCell.self, forCellWithReuseIdentifier: "default")
        t.allowsMultipleSelection = true
        t.contentInset = UIEdgeInsets(top: 20, left: 8, bottom: 30, right: 8)
        t.backgroundColor = .systemGray6
        return t
    }()
    
    lazy var doneButton: UIButton = {
        let b = UIButton()
        b.setTitle("Done", for: .normal)
        b.setTitleColor(UIColor.label, for: .disabled)
        b.backgroundColor = .systemGray3
        b.isEnabled = false
        b.layer.cornerRadius = 10
        b.addTarget(self, action: #selector(onDone), for: .touchUpInside)
        
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select minimum 3 characters"
        view.addSubview(collectionView)
        view.addSubview(doneButton)
        view.backgroundColor = .systemGray6

        collectionView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.layoutMarginsGuide)
            make.bottom.equalTo(doneButton.snp.top)
        }
        doneButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.right.bottom.equalTo(view.layoutMarginsGuide )
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.indexPathsForSelectedItems?.forEach { self.collectionView.deselectItem(at: $0, animated: false) }
    }
    
    @objc
    func onDone() {
        let vc = CharactersPageViewController(characters: selectedCharacters)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func deselect(_ character: Character) {
        if selectedCharacters.contains(character) {
            selectedCharacters.remove(at: selectedCharacters.firstIndex(of: character)!)
            updateIndexes()
        }
        
        if selectedCharacters.count < 3 {
            doneButton.isEnabled = false
            doneButton.backgroundColor = .systemGray3
        }
    }
}

extension CharacterSelectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as? CharacterSelectionCell ?? CharacterSelectionCell()
        let character = characters[indexPath.row]
        cell.setup(character: character)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        
        selectedCharacters.forEach {
            if ($0.teamColor == character.teamColor && $0.name != character.name) {
                collectionView.deselectItem(at: IndexPath(item: characters.firstIndex(of: $0)!, section: 0), animated: false)
                deselect($0)
            }
        }
        
        selectedCharacters.append(character)
        updateIndexes()

        if selectedCharacters.count >= 3 {
            doneButton.isEnabled = true
            doneButton.backgroundColor = .systemBlue
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        deselect(character)
    }
    
    func updateIndexes() {
        for (index, character) in characters.enumerated() {
            if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? CharacterSelectionCell,
               cell.isSelected,
            let charIndex = selectedCharacters.firstIndex(of: character) {
                cell.selectedNumber(number: charIndex + 1)
            }
        }
    }
}
