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

    override var availableMoves: [Move] {
        var moves = [Move]()

        [Position.MoveDirection.up, .down].forEach { v in
            [Position.MoveDirection.left, .right].forEach { h in
                if let p = position.move([v, h], 1), p.isInCastle(side), let move = Move(from: self, to: p) {
                    moves.append(move)
                }
            }
        }

        return moves
    }
}
