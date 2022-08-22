//
//  CharacterSelection.swift
//  Betrayal stat tracker
//
//  Created by Martin Peshevski on 7.3.21.
//

import UIKit

class CharacterCell: UICollectionViewCell {
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

class CharacterSelection: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let characters = [Flash, OxBellows, JennyLeClerc, HeatherGranville, VivianLopez, MadameZostra, MissyDubourde, ZoeIngstrom, FatherRhinehardt, LongFellow, BrandonJaspers, PeterAkimoto]

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
        t.register(CharacterCell.self, forCellWithReuseIdentifier: "default")
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
        let vc = ViewController(characters: selectedCharacters)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as? CharacterCell ?? CharacterCell()
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
        if selectedCharacters.count >= 3 {
            doneButton.isEnabled = true
            doneButton.backgroundColor = .systemBlue
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        let character = characters[indexPath.row]
        deselect(character)
    }
    
    func deselect(_ character: Character) {
        if selectedCharacters.contains(character) {
            selectedCharacters.remove(at: selectedCharacters.firstIndex(of: character)!)
        }
        
        if selectedCharacters.count < 3 {
            doneButton.isEnabled = false
            doneButton.backgroundColor = .systemGray3
        }
    }
}
