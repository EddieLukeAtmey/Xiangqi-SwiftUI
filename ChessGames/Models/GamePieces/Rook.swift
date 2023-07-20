//
//  Rook.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 俥 or 車
final class Rook: GamePiece {
    override var title: String { "車" }

    override var availableMoves: [Move] {
        var moves = [Move]()

        for direction in Position.MoveDirection.allCases {
            while let pos = position.move(direction, 1), let m = Move(from: self, to: pos)  {
                moves.append(m)
            }
        }

        return moves
    }
}