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

    override var availableMoves: [Move] {
        var moves = [Move]()
        
        MoveDirection.allCases.forEach {
            guard let pos = position.move($0, 1), pos.isInCastle(side) else { return }
            guard let move = Move(from: self, to: pos) else { return }
            moves.append(move)
        }

        return moves
    }
}
