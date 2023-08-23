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
    case loseKing
}
