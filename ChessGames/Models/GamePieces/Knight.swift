//
//  Knight.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 馬 or 傌
final class Knight: GamePiece {
    override var title: String {
        side == .red ? "傌" : "馬"
    }

    override var availableMoves: [Move] {
        var moves = [Move]()

        for direction in Position.MoveDirection.allCases {
            guard let orthogonalPos = position.move(direction, 1), orthogonalPos.gamePiece == nil else { continue }
            
            let diagonalDirections: [Position.MoveDirection]
            switch direction {
            case .up, .down:
                diagonalDirections = [.left, .right]
            case .left, .right:
                diagonalDirections = [.up, .down]
            default: fatalError("Invalid case!")
            }
            
            for diagonalDirection in diagonalDirections {
                if let pos = orthogonalPos.move(direction, 1)?.move(diagonalDirection, 1), let move = Move(from: self, to: pos) {
                    moves.append(move)
                }
            }
        }

        return moves
    }
}
