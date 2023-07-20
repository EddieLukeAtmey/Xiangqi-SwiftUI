//
//  Bishop.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 象 or 相
final class Bishop: GamePiece {
    override var title: String {
        side == .red ? "相" : "象"
    }

    override var availableMoves: [Move] {
        var moves = [Move]()

        for direction in [Position.MoveDirection.up, .down] {
            for side in [Position.MoveDirection.left, .right] {
                if let pos = position.move([direction, side], 2), canMoveByRule(to: pos) {
                    if let move = Move(from: self, to: pos) {
                        moves.append(move)
                    }
                }
            }
        }

        return moves
    }
    
    private func canMoveByRule(to: Position) -> Bool {
        // Can't cross the river
        if (side == .red && to.y > 4) || (side == .black && to.y < 5) {
            return false
        }
        
        // Check if there is a piece blocking the move
        let midX = (position.x + to.x) / 2
        let midY = (position.y + to.y) / 2
        let midPos = Position(x: midX, y: midY)
        
        return midPos.gamePiece == nil 
    }
}
