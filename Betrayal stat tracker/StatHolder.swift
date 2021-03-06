//
//  StatsHolderView.swift
//  Betrayal stat tracker
//
//  Created by Martin Peshevski on 6.3.21.
//

import UIKit

class StatView: UIView {
    var stat: StatValue {
        didSet {
            if stat.isDeath { label.textColor = .systemRed } else { label.textColor = stat.isDefault ? .systemGreen : .systemGray4 }
            updateBorder()
        }
    }
    
    lazy var label: UILabel = {
        let l = UILabel()
        l.text = "\(stat.value)"
        if stat.isDeath { l.textColor = .systemRed } else { l.textColor = stat.isDefault ? .systemGreen : .systemGray4 }
        l.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        l.textAlignment = .center
        return l
    }()
    
    init(stat: StatValue) {
        self.stat = stat
        super.init(frame: .zero)
        addSubview(label)
        label.snp.makeConstraints { make in make.edges.equalToSuperview() }
        updateBorder()
    }
    
    func updateBorder() {
        if stat.isSelected {
            layer.borderWidth = 1
            layer.borderColor = UIColor.systemRed.cgColor
        } else {
            layer.borderWidth = 0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class StatHolder: UIStackView {
    lazy var increaseButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .systemBlue
        b.setTitle("+", for: .normal)
        b.addTarget(self, action: #selector(onIncrease), for: .touchUpInside)
        b.snp.makeConstraints { make in make.width.equalTo(50) }
        return b
    }()
    
    lazy var reduceButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = .systemBlue
        b.setTitle("-", for: .normal)
        b.addTarget(self, action: #selector(onReduce), for: .touchUpInside)
        b.snp.makeConstraints { make in make.width.equalTo(50) }

        return b
    }()
    var stats = [StatValue]()
    var statViews = [StatView]()
    
    var selected: StatValue {
        set {
            let index = stats.firstIndex(of: newValue) ?? 0
            for (i, _) in stats.enumerated() { stats[i].isSelected = false }

            stats[index].isSelected = true
            update()
        }
        get {
            return stats.filter { $0.isSelected } . first!
        }
    }

    init(stats: [StatValue]) {
        super.init(frame: .zero)
        
        axis = .horizontal
        spacing = 5
        distribution = .fillProportionally
        
        addArrangedSubview(reduceButton)
        setCustomSpacing(15, after: reduceButton)
        
        self.stats = stats
        self.statViews = createLabels(stats: stats)
        
        for label in statViews {
            addArrangedSubview(label)
        }
        
        addArrangedSubview(increaseButton)
    }
    
    func createLabels(stats: [StatValue]) -> [StatView] {
        var arr = [StatView]()
        for stat in stats { arr.append(StatView(stat: stat)) }
        
        return arr
    }
    
    func update() {
        for (i, statView) in statViews.enumerated() {
            statView.stat = stats[i]
        }
    }
    
    @objc
    func onIncrease() {
        let index = stats.firstIndex(of: selected) ?? 0
        if index < stats.count - 1 { selected = stats[index + 1] }
    }
    
    @objc
    func onReduce() {
        let index = stats.firstIndex(of: selected) ?? 0
        if index > 0 { selected = stats[index - 1] }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
