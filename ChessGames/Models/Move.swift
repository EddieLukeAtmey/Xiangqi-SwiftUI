//
//  Move.swift
//  Xiangqi
//
//  Created by Eddie on 19/07/2023.
//

import Foundation

// A single move a game piece can do at a turn
struct Move {
    let piece: GamePiece
    let to: Position
    let captured: GamePiece?

    init?(_ piece: GamePiece, to: Position) {
        self.piece = piece
        self.to = to

        guard let piece = piece.gameManager?.getPiece(at: to) else { captured = nil; return } // ok to move to empty spot
        guard piece.side != piece.side else { return nil } // move to ally

        captured = piece
    }

    /// - returns: original position
    func perform() -> Position {
        let org = piece.position
        piece.position = to
        return org
    }
}
