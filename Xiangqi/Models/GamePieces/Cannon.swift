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
        side == .red ? "炮" : "砲"
    }

    override func canMove(to: Position) throws -> Bool {
        let dx = abs(to.x - position.x)
        let dy = abs(to.y - position.y)
        let piecesBetween = pieces.filter { $0.position.x == position.x && min(position.y, to.y) < $0.position.y && $0.position.y < max(position.y, to.y) } +
        pieces.filter { $0.position.y == position.y && min(position.x, to.x) < $0.position.x && $0.position.x < max(position.x, to.x) }

        if piecesBetween.count == 0 {
            // Cannon can only move horizontally or vertically
            if dx == 0 || dy == 0 {
                return true
            }
        } else if piecesBetween.count == 1 {
            // Cannon can capture an opponent piece by jumping over one piece
            if dx == 0 || dy == 0 {
                let piece = piecesBetween.first!
                if piece.side != side && piece.position == to {
                    return true
                }
            }
        }

        return false
    }
}
