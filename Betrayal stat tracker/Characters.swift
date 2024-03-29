//
//  Characters.swift
//  Betrayal stat tracker
//
//  Created by Martin Peshevski on 5.3.21.
//

import UIKit

enum TeamColor: Codable {
    case red
    case blue
    case gray
    case purple
    case green
    case yellow
}

struct Character: Equatable, Codable {
    let name: String
    let imageName: String
    let teamColor: TeamColor
    var might: [StatValue]
    var speed: [StatValue]
    var knowledge: [StatValue]
    var sanity: [StatValue]
    
    var image: UIImage {
        UIImage(named: imageName) ?? UIImage()
    }
    
    mutating func setSelected(type: StatType, index: Int) {
        switch type {
        case .might: for (i, _) in might.enumerated() { might[i].isSelected = i == index }
        case .speed: for (i, _) in speed.enumerated() { speed[i].isSelected = i == index }
        case .knowledge: for (i, _) in knowledge.enumerated() { knowledge[i].isSelected = i == index }
        case .sanity: for (i, _) in sanity.enumerated() { sanity[i].isSelected = i == index }
        }
    }
}

enum Characters {
    case flash
    case oxBellows
    case longfellow
    case vivianLopez
    case brandonJaspers
    case jennyLeClerc
    case missyDubourde
    case fatherReinhardt
    case madameZostra
    case zoeIngstrom
    case heatherGranville
    case peterAkimoto
    
    var character: Character {
        switch self {
        case .flash:
            return Character(name: "Darrin \"Flash\" Williams",
                                      imageName: "Flash",
                                      teamColor: .red,
                                      might:
                                        [StatValue(value: 0, isDeath: true),
                                         StatValue(value: 2),
                                         StatValue(value: 3),
                                         StatValue(value: 3, isDefault: true),
                                         StatValue(value: 4),
                                         StatValue(value: 5),
                                         StatValue(value: 6),
                                         StatValue(value: 6),
                                         StatValue(value: 7)],
                                      speed:
                                        [StatValue(value: 0, isDeath: true),
                                         StatValue(value: 4),
                                         StatValue(value: 4),
                                         StatValue(value: 4),
                                         StatValue(value: 5),
                                         StatValue(value: 6, isDefault: true),
                                         StatValue(value: 7),
                                         StatValue(value: 7),
                                         StatValue(value: 8)],
                                      knowledge:
                                        [StatValue(value: 0, isDeath: true),
                                         StatValue(value: 2),
                                         StatValue(value: 3),
                                         StatValue(value: 3, isDefault: true),
                                         StatValue(value: 4),
                                         StatValue(value: 5),
                                         StatValue(value: 5),
                                         StatValue(value: 5),
                                         StatValue(value: 7)],
                                      sanity:
                                        [StatValue(value: 0, isDeath: true),
                                         StatValue(value: 1),
                                         StatValue(value: 2),
                                         StatValue(value: 3, isDefault: true),
                                         StatValue(value: 4),
                                         StatValue(value: 5),
                                         StatValue(value: 5),
                                         StatValue(value: 5),
                                         StatValue(value: 7)])
        case .oxBellows:
            return Character(name: "Ox Bellows",
                             imageName: "OxBellows",
                             teamColor: .red,
                             might:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 5, isDefault: true),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 8),
                                StatValue(value: 8)],
                             speed:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 2),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6)],
                             knowledge:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 2),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 3),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6)],
                             sanity:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 2),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 7)])
        case .longfellow:
            return Character(name: "Professor Longfellow",
                             imageName: "Longfellow",
                             teamColor: .gray,
                             might:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 1),
                                StatValue(value: 2),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6)],
                             speed:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 2),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6)],
                             knowledge:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 5, isDefault: true),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 8)],
                             sanity:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 1),
                                StatValue(value: 3),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 7)])
        case .vivianLopez:
            return Character(name: "Vivian Lopez",
                             imageName: "VivianLopez",
                             teamColor: .blue,
                             might:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 2),
                                StatValue(value: 2, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6)],
                             speed:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 8)],
                             knowledge:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 5, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 7)],
                             sanity:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 8),
                                StatValue(value: 8)])
        case .brandonJaspers:
            return Character(name: "Brandon Jaspers",
                             imageName: "BrandonJaspers",
                             teamColor: .green,
                             might:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 7)],
                             speed:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 8)],
                             knowledge:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 1),
                                StatValue(value: 3),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 7)],
                             sanity:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 8)])
        case .jennyLeClerc:
            return Character(name: "Jenny LeClerc",
                             imageName: "JennyLeClerc",
                             teamColor: .purple,
                             might:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 8)],
                             speed:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 8)],
                             knowledge:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 8)],
                             sanity:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 1),
                                StatValue(value: 1),
                                StatValue(value: 2),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6)])
        case .missyDubourde:
            return Character(name: "Missy Dubourde",
                             imageName: "MissyDubourde",
                             teamColor: .yellow,
                             might:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 7)],
                             speed:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 5, isDefault: true),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 7)],
                             knowledge:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 6)],
                             sanity:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 1),
                                StatValue(value: 2),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 7)])
        case .fatherReinhardt:
            return Character(name: "Father Rhinehardt",
                             imageName: "Rhinehardt",
                             teamColor: .gray,
                             might:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 1),
                                StatValue(value: 2),
                                StatValue(value: 2, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 7)],
                             speed:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 7)],
                             knowledge:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 1),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 8)],
                             sanity:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6, isDefault: true),
                                StatValue(value: 7),
                                StatValue(value: 7),
                                StatValue(value: 8)])
        case .madameZostra:
            return Character(name: "Madame Zostra",
                             imageName: "MadameZostra",
                             teamColor: .blue,
                             might:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6)],
                             speed:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 7)],
                             knowledge:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 1),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6)],
                             sanity:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 8),
                                StatValue(value: 8)])
        case .zoeIngstrom:
            return Character(name: "Zoe Ingstrom",
                             imageName: "ZoeIngstrom",
                             teamColor: .yellow,
                             might:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 6),
                                StatValue(value: 7)],
                             speed:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 8),
                                StatValue(value: 8)],
                             knowledge:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 1),
                                StatValue(value: 2),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 5)],
                             sanity:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 5, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 8)])
        case .heatherGranville:
            return Character(name: "Heather Granville",
                             imageName: "HeatherGranville",
                             teamColor: .purple,
                             might:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 8)],
                             speed:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 8)],
                             knowledge:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 5, isDefault: true),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 8)],
                             sanity:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 6)])
        case .peterAkimoto:
            return Character(name: "Peter Akimoto",
                             imageName: "PeterAkimoto",
                             teamColor: .green,
                             might:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 2),
                                StatValue(value: 3),
                                StatValue(value: 3, isDefault: true),
                                StatValue(value: 4),
                                StatValue(value: 5),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 8)],
                             speed:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 3),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 7)],
                             knowledge:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 7),
                                StatValue(value: 7),
                                StatValue(value: 8)],
                             sanity:
                               [StatValue(value: 0, isDeath: true),
                                StatValue(value: 3),
                                StatValue(value: 4),
                                StatValue(value: 4),
                                StatValue(value: 4, isDefault: true),
                                StatValue(value: 5),
                                StatValue(value: 6),
                                StatValue(value: 6),
                                StatValue(value: 7)])
        }
    }
}
