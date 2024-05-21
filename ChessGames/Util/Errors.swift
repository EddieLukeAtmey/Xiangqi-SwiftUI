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

enum MoveError: LocalizedError {
    case loseKing

    var errorDescription: String? {
        switch self {
        case .loseKing:
            return "You cannot make this move as it would put your king in check."
        }
    }
}
