//
//  General.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 帥 or 將
final class General: GamePiece {
    override var title: String {
        side == .red ? "帥" : "將"
    }

    override func canMove(to: Position) throws -> Bool {

        let dx = abs(to.x - position.x)
        let dy = abs(to.y - position.y)

        if dx + dy == 1 {
            // General moves one step horizontally or vertically
            if side == .red {
                // General can only move inside the palace
                if to.x >= 3 && to.x <= 5 && to.y >= 7 {
                    return true
                }
            } else {
                if to.x >= 3 && to.x <= 5 && to.y <= 2 {
                    return true
                }
            }
        }

        return false
    }
}
