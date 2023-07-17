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

    override var availableMoves: [Position] {
        var moves: [Position] = []

        let forwardOffset = side == .red ? -1 : 1
        let forwardPosition = Position(x: position.x, y: position.y + forwardOffset)

        // Move one step forward
        if let piece = pieces.filter({ $0.position == forwardPosition }).first {
            if piece.side != side {
                moves.append(forwardPosition)
            }
        } else if isPositionOnBoard(forwardPosition) {
            moves.append(forwardPosition)
        }

        // Move one step horizontally after passing the river
        if (side == .red && position.y <= 4) || (side == .black && position.y >= 5) {
            let leftPosition = Position(x: position.x - 1, y: position.y)
            if let piece = pieces.filter({ $0.position == leftPosition }).first {
                if piece.side != side {
                    moves.append(leftPosition)
                }
            }

            let rightPosition = Position(x: position.x + 1, y: position.y)
            if let piece = pieces.filter({ $0.position == rightPosition }).first {
                if piece.side != side {
                    moves.append(rightPosition)
                }
            }
        }

        return moves
    }

    override func canMove(to: Position) throws -> Bool {
//        let dy = abs(to.y - position.y)
//        let dx = abs(to.x - position.x)
//
//        if dy == 1 && dx == 0 {
//            // Pawn can only move one step forward
//            if side == .red && to.y > position.y {
//                return try !simulateMove(from: position, to: to, pieces: pieces, side: side)
//            } else if side == .black && to.y < position.y {
//                return try !simulateMove(from: position, to: to, pieces: pieces, side: side)
//            }
//        } else if dy == 0 && dx == 1 {
//            // Pawn can only move one step sideways after crossing the river
//            if side == .red && position.y <= 4 && to.y <= 4 {
//                return try !simulateMove(from: position, to: to, pieces: pieces, side: side)
//            } else if side == .black && position.y >= 5 && to.y >= 5 {
//                return try !simulateMove(from: position, to: to, pieces: pieces, side: side)
//            }
//        }

        return false
    }

}
