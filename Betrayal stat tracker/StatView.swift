//
//  StatView.swift
//  Betrayal stat tracker
//
//  Created by Martin Peshevski on 8/22/22.
//

import UIKit

class StatView: UIView {
    var stat: StatValue {
        didSet {
            label.text = "\(stat.value)"
            if stat.isDeath { label.textColor = .systemRed } else { label.textColor = stat.isDefault ? .systemGreen : .systemGray2 }
            updateBorder()
        }
    }
    
    lazy var label: UILabel = {
        let l = UILabel()
        l.text = "\(stat.value)"
        l.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        l.textAlignment = .center
        return l
    }()
    
    func resetLabelColor() {
        if stat.isDeath { label.textColor = .systemRed } else { label.textColor = stat.isDefault ? .systemGreen : .systemGray2 }
    }
    
    var highlightColor: UIColor {
        if stat.isDeath { return .systemRed } else { return stat.isDefault ? .systemGreen : .systemBlue }
    }
    
    init(stat: StatValue) {
        self.stat = stat
        super.init(frame: .zero)
        
        backgroundColor = .clear

        addSubview(label)
        label.snp.makeConstraints { make in make.edges.equalToSuperview().inset(2) }
        layer.cornerRadius = 3
        resetLabelColor()
        updateBorder()
    }
    
    func updateBorder() {
        if stat.isSelected {
            label.textColor = .white
        } else {
            resetLabelColor()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
