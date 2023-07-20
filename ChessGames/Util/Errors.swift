//
//  Errors.swift
//  Xiangqi
//
//  Created by Eddie Luke Atmey on 20/07/2023.
//

import Foundation

enum Rule: Error {
    case moveRule(MoveError)
    case checkRule
}

enum MoveError: Error {
    // Invalid move
    case blocked
    case loseKing(KingInCheck)
    case invalid
}

// MARK: - Check
protocol KingInCheck: Error {
    var checkingPiece: [GamePiece] { get }
}

struct CheckXiangqi: KingInCheck {
    var checkingPiece: [GamePiece]
}

