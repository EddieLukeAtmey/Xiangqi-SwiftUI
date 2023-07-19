//
//  Advisor.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 仕 or 士
final class Advisor: GamePiece {
    override var title: String {
        side == .red ? "仕" : "士"
    }

    override var availableUpMoves: [Move] {
        var moves = [Move]()

        if let upLeft = position.move([.up, .left], 1) {
            if upLeft.isInCastle(side), let move = Move(from: self, to: upLeft) {
                moves.append(move)
            }
        }

        if let upRight = position.move([.up, .right], 1) {
            if upRight.isInCastle(side), let move = Move(from: self, to: upRight) {
                moves.append(move)
            }
        }

        return moves
    }

    override var availableDownMoves: [Move] {
        var moves = [Move]()

        if let downLeft = position.move([.down, .left], 1) {
            if downLeft.isInCastle(side), let move = Move(from: self, to: downLeft) {
                moves.append(move)
            }
        }

        if let downRight = position.move([.up, .right], 1) {
            if downRight.isInCastle(side), let move = Move(from: self, to: downRight) {
                moves.append(move)
            }
        }

        return moves
    }
}
