//
//  Bishop.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 相 or 象
final class Bishop: GamePiece {
    override var title: String {
        side == .red ? "相" : "象"
    }

    override func canMove(to: Position) throws -> Bool {
        let dx = abs(to.x - position.x)
        let dy = abs(to.y - position.y)

        if dx == dy, dx == 2 {
            // Bishop moves diagonally 2 square
            return true
        }

        return false
    }
}
