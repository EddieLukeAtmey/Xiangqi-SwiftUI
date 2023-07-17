//
//  GameManager.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

let boardSize = (h: 9, v: 10)

// To handle game logic
final class GameManager {

    private(set) var pieces: [GamePiece]
    private(set) var capturedPieces = [GamePiece]()
    private(set) var moves = [(GamePiece, Position)]()

    // MARK: - Setup
    static var instance: GameManager?
    init() {

        // setup pieces and poisition
        var pieces = [GamePiece]()

        GameManager.allStartingPositions.forEach { pos in

            let side: PieceSide = pos.y > 5 ? .red : .black

            switch (pos.x, pos.y) {

            case (_, 3): fallthrough
            case (_, 6):
                pieces.append(Pawn(position: pos, side: side))

            case (_, 2): fallthrough
            case (_, 7):
                pieces.append(Cannon(position: pos, side: side))

            case (let x, _):
                let piece: GamePiece
                switch x {
                case 0, 8: piece = Rook(position: pos, side: side)
                case 1, 7: piece = Knight(position: pos, side: side)
                case 2, 6: piece = Bishop(position: pos, side: side)
                case 3, 5: piece = Advisor(position: pos, side: side)
                case 4: piece = General(position: pos, side: side)
                default: fatalError("Uknown Position")
                }

                pieces.append(piece)
            }
        }
        self.pieces = pieces
        Self.instance = self
    }

    static let allStartingPositions: [Position] = {
        var p = [Position]()
        for i in 0..<9 {
            p.append(.init(x: i, y: 0))

            // Pawn
            if i & 1 == 0 { p.append(.init(x: i, y: 3)) }
        }

        // Cannon
        p.append(.init(x: 1, y: 2))
        p.append(.init(x: 7, y: 2))

        // Other side
        var p2 = [Position]()
        p.forEach { p2.append(.init(x: $0.x, y: 9 - $0.y)) }

        p.append(contentsOf: p2)
        return p
    }()

    // MARK: - Actions
}

extension GameManager: GamePieceDelegate {
    func canMove(piece: GamePiece, to: Position) throws -> Bool {
        return false
    }

    func didMove(piece: GamePiece, to: Position) {

        if let idx = pieces.firstIndex(where: { $0.position == to }) {
            capturedPieces.append(pieces[idx])
            pieces.remove(at: idx)
        }
        moves.append((piece, to))

        // Check
        let king = pieces.first { $0 is General && $0.side != piece.side }!
        if (try? isInCheck(king: king)) == true {
            print("\(king.side) is in check!")
        }

        // Update UI?
    }

    private func isInCheck(king: GamePiece) throws -> Bool {
        // Check if any of the opposing pieces can capture the king
        let opposingPieces = pieces.filter { $0.side != king.side }
        for piece in opposingPieces {
            if try piece.canMove(to: king.position) {
                return true
            }
        }

        return false
    }
}
