//
//  Constants.swift
//  Xiangqi
//
//  Created by Eddie on 19/07/2023.
//

import Foundation

// Const
/// 3...5
let CastleHorizontalRange = 3...5
/// v: 7...9
let RedCastle = (h: CastleHorizontalRange, v: 7...9)
/// v: 0...2
let BlackCastle = (h: CastleHorizontalRange, v: 0...2)
/// 9 x 10
let BoardSize = (h: 9, v: 10)

/// 0, 2, 3,4,5, 6, 8
let BoardMarkerH = (left: 0, leftCanon: 1, midLeft: 2, castleL: 3, center: 4, castleR: 5, midRight: 6, rightCanon: 7, right: 8)

let BoardMarkerV = (blackBot: 0, blackMid: 2, blackRiver: 4, redRiver: 5, redMid: 7, redBot: 9)

enum GameSide {
    case red
    case black

    mutating func toggle() {
        if self == .red { self = .black }
        else { self = .red }
    }

}
typealias MoveDirection = Position.MoveDirection
