//
//  Move.swift
//  Xiangqi
//
//  Created by Eddie on 19/07/2023.
//

import Foundation

// A single move a game piece can do at a turn
struct Move {
    let from: GamePiece
    let to: Position
    let captured: GamePiece?

    init?(from: GamePiece, to: Position) {
        self.from = from
        self.to = to

        guard let piece = to.gamePiece else { captured = nil; return } // ok to move to empty spot
        guard piece.side != from.side else { return nil } // move to ally

        captured = piece
    }
}
