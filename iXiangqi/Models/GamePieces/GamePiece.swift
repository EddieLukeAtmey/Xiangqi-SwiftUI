//
//  GamePiece.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

class GamePiece: Identifiable {
    let id = UUID()
    weak private(set) var gameManager: GameManager?
    final var pieces: [GamePiece] { gameManager?.pieces ?? [] }

    var side: GameSide
    var position: Position

    // abstracts
    var availableMoves: [Move] { [] }

    var title: String { "" }

    init(position: Position, side: GameSide, gameManager: GameManager) {
        self.position = position
        self.side = side
        self.gameManager = gameManager
    }

//    func canMove(to: Position) throws -> Bool {
////        guard availableMoves.contains(position) else { throw MoveError.invalid }
////        return try delegate?.canMove(piece: self, to: position) ?? false
//        return false
//    }

    func canCheck(_ king: General) -> Bool {
        availableMoves.contains(where: { $0.captured == king })
    }

    final func makeVerticalStep(_ step: Int) -> Int {
        side == .red ? -step : step
    }
}
