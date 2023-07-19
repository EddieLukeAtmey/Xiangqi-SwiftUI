//
//  Rook.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 俥 or 車
final class Rook: GamePiece {
    override var title: String {
        side == .red ? "俥" : "車"
    }

    override func canMove(to: Position) throws -> Bool {
        let dx = to.x - position.x
        let dy = to.y - position.y

//        if dx == 0 || dy == 0 {
//            // Rook can move horizontally or vertically
//            return try canMoveBetween(position: to)
//        }

        return false
    }
}
