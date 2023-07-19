//
//  GameManager.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

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

            let side: PieceSide = pos.y > BoardMarkerV.redRiver ? .red : .black

            switch (pos.x, pos.y) {

            case (_, BoardMarkerV.blackRiver - 1): fallthrough
            case (_, BoardMarkerV.redRiver + 1):
                pieces.append(Pawn(position: pos, side: side))

            case (_, BoardMarkerV.blackMid): fallthrough
            case (_, BoardMarkerV.redMid):
                pieces.append(Cannon(position: pos, side: side))

            case (let x, _):
                let piece: GamePiece
                switch x {
                case BoardMarkerH.left, BoardMarkerH.right: piece = Rook(position: pos, side: side)
                case BoardMarkerH.leftCanon, BoardMarkerH.rightCanon: piece = Knight(position: pos, side: side)
                case BoardMarkerH.midLeft, BoardMarkerH.midRight: piece = Bishop(position: pos, side: side)
                case BoardMarkerH.castleL, BoardMarkerH.castleR: piece = Advisor(position: pos, side: side)
                case BoardMarkerH.center: piece = General(position: pos, side: side)
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
        for i in BoardMarkerH.left...BoardMarkerH.right {
            p.append(.init(x: i, y: BoardMarkerV.blackBot))
            p.append(.init(x: i, y: BoardMarkerV.redBot))

            // Pawn
            if i & 1 == 0 {
                p.append(.init(x: i, y: BoardMarkerV.blackRiver - 1))
                p.append(.init(x: i, y: BoardMarkerV.redRiver + 1))
            }

            if i == BoardMarkerH.leftCanon || i == BoardMarkerH.rightCanon {
                // Cannon
                p.append(.init(x: i, y: BoardMarkerV.blackMid))
                p.append(.init(x: i, y: BoardMarkerV.redMid))
            }
        }

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
