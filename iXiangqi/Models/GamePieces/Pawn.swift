//
//  Pawn.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 兵 Or 卒
final class Pawn: GamePiece {
    override var title: String {
        side == .red ? "兵" : "卒"
    }

    override var availableMoves: [Move] {
        var moves = [Move]()

        let hMove = side == .red ? Position.MoveDirection.up : .down
        if let pos = position.move(hMove, 1), let move = Move(self, to: pos) {
            moves.append(move)
        }

        // Move horizontal
        guard hasCrossedRiver else { return moves }

        [Position.MoveDirection.right, .left].forEach {
            if let pos = position.move($0, 1), let move = Move(self, to: pos) {
                moves.append(move)
            }
        }

        return moves
    }

    // No backing for pawn
    private var hasCrossedRiver: Bool {
        return (side == .red && position.y <= 4) || (side == .black && position.y >= 5)
    }
}
