//
//  Canon.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 炮 or 砲
final class Cannon: GamePiece {
    override var title: String {
        side == .red ? "砲" : "炮"
    }

    override var availableMoves: [Move] {
        var moves = [Move]()

        for direction in Position.MoveDirection.allCases {
            var hasJumpOver = false
            
        posLoop: while let pos = position.move(direction, 1) {
                
                // empty space
                if pos.gamePiece == nil {
                    if !hasJumpOver { moves.append(Move(from: self, to: pos)!) }
                    continue
                }
                
                // has obstacle
                if hasJumpOver { // had one
                    if let m = (Move(from: self, to: pos)) { // Can capture
                        moves.append(m)
                    }
                    break posLoop
                }
                else { // blocked
                    hasJumpOver = true
                }
            }
        }
        return moves
    }
}
