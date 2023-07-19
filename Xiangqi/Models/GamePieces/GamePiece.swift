//
//  GamePiece.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation


enum PieceSide {
    case red
    case black
}

enum MoveError: Error {
    // Invalid move
    case invalid
    case loseKing
}

protocol GamePieceDelegate: AnyObject {
    func canMove(piece: GamePiece, to: Position) throws -> Bool
    func didMove(piece: GamePiece, to: Position)
}

class GamePiece {
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

    func simulateMove(from: Position, to: Position) throws -> Bool {
        // Make a copy of the pieces array to simulate the move
//        var simulatedPieces = pieces.map { $0.copy() }
//
//        // Find the piece at the starting position
//        guard let piece = simulatedPieces.filter({ $0.position == from && $0.side == side }).first else {
//            throw MoveError.invalidMove("No piece at starting position")
//        }
//
//        // Simulate the move
//        piece.position = to
//
//        // Check if the move puts the king in check
//        let kingPosition = simulatedPieces.filter { $0 is King && $0.side == side }.first!.position
//        for enemyPiece in simulatedPieces.filter({ $0.side != side }) {
//            if try enemyPiece.canAttack(position: kingPosition, pieces: simulatedPieces) {
//                return true
//            }
//        }

        return false
    }

    final func makeVerticalStep(_ step: Int) -> Int {
        side == .red ? -step : step
    }
}
