//
//  GamePiece.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

protocol GamePieceDelegate: AnyObject {
    func canMove(piece: GamePiece, to: Position) throws -> Bool
    func didMove(piece: GamePiece, to: Position)
}

class GamePiece: Identifiable {
    let id = UUID()
    final var pieces: [GamePiece] { GameManager.instance?.pieces ?? [] }

    var side: PieceSide
    var position: Position
    weak var delegate: GamePieceDelegate?

    // abstracts
    var availableMoves: [Move] { [] }

    var title: String { "" }

    init(position: Position, side: PieceSide) {
        self.position = position
        self.side = side
    }

    func move(to: Position) throws {

        guard try canMove(to: position) else { throw MoveError.invalid }
        position = to
    }

    func canMove(to: Position) throws -> Bool {
//        guard availableMoves.contains(position) else { throw MoveError.invalid }
//        return try delegate?.canMove(piece: self, to: position) ?? false
        return false
    }

    final func makeVerticalStep(_ step: Int) -> Int {
        side == .red ? -step : step
    }
}
