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

class CharacterDetailsCell: UICollectionViewCell {
    var might = StatHolder(stats: Flash.might, title: "Might")
    var speed = StatHolder(stats: Flash.speed, title: "Speed")
    var knowledge = StatHolder(stats: Flash.knowledge, title: "Knowledge")
    var sanity = StatHolder(stats: Flash.sanity, title: "Sanity")

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
    
    func setup(character: Character) {
        titleLabel.text = character.name
        characterImage.image = character.image
        
        might.setup(stats: character.might)
        speed.setup(stats: character.speed)
        knowledge.setup(stats: character.knowledge)
        sanity.setup(stats: character.sanity)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainStack.addArrangedSubview(characterImage)

        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(UIView())

        mainStack.addArrangedSubview(might)
        
        mainStack.addArrangedSubview(speed)
        
        mainStack.addArrangedSubview(knowledge)
        
        mainStack.addArrangedSubview(sanity)
                
        addSubview(mainStack)
        characterImage.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(80)
            make.height.equalTo(characterImage.snp.width)
        }
        mainStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(80)
            make.bottom.equalToSuperview().inset(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    let characters: [Character]

    lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = view.frame.size
        flow.scrollDirection = .horizontal
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        
        let c = UICollectionView(frame: .zero, collectionViewLayout: flow)
        c.isPagingEnabled = true
        c.register(CharacterDetailsCell.self, forCellWithReuseIdentifier: "characterCell")
        c.dataSource = self
        c.delegate = self
        c.backgroundColor = .systemBackground

        return c
    }()
    lazy var pageControl: UIPageControl = {
        let p = UIPageControl()
        p.numberOfPages = characters.count
        p.pageIndicatorTintColor = .systemGray5
        p.currentPageIndicatorTintColor = .systemGray
        return p
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = characters[0].name
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.layoutMarginsGuide)
        }
        collectionView.snp.makeConstraints { make in make.edges.equalToSuperview() }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterDetailsCell ?? CharacterDetailsCell()
        
        cell.setup(character: characters[indexPath.row])
        return cell;
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let index = collectionView.indexPath(for: collectionView.visibleCells.first!)?.row else { return }
        pageControl.currentPage = index
        title = characters[index].name
    }
    
    init(characters: [Character]) {
        self.characters = characters
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

