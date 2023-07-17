//
//  Advisor.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 仕 or 士
final class Advisor: GamePiece {
    override var title: String {
        side == .red ? "仕" : "士"
    }

    override func canMove(to: Position) throws -> Bool {

        let dx = abs(to.x - position.x)
        let dy = abs(to.y - position.y)

        if dx == 1 && dy == 1 {
            // Advisor moves diagonally one step
            if side == .red {
                // Advisor can only move inside the palace
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
