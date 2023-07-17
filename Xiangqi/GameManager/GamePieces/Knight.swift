//
//  Knight.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 傌 or 馬
final class Knight: GamePiece {
    override var title: String {
        side == .red ? "傌" : "馬"
    }

    override func canMove(to: Position) throws -> Bool {
        let dx = abs(to.x - position.x)
        let dy = abs(to.y - position.y)

        if (dx == 1 && dy == 2) || (dx == 2 && dy == 1) {
            // Knight moves in an L shape
            return true
        }

        return false
    }
}
