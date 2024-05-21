//
//  GameManager.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation
import Combine

enum GameState {
    case initialized
    case isPlaying(_ movingTurn: GameSide)
    case ended(_ losingSide: GameSide?)
}

// To handle game logic
final class GameManager: ObservableObject {

    private(set) var pieces: [GamePiece]
    private(set) var capturedPieces = [GamePiece]()

    // moves and their original position
    private(set) var moves = [(Move, Position)]()
    private(set) var state = GameState.initialized
    private(set) var currentPlayer: GameSide = .red {
        didSet { state = .isPlaying(currentPlayer) }
    }

    @Published var p1Timer: Int
    @Published var p2Timer: Int

    private var timer: AnyCancellable?

    // MARK: - Setup
    static var instance: GameManager?
    init() {

        // setup pieces and poisition
        var pieces = [GamePiece]()

        GameManager.allStartingPositions.forEach { pos in

            let side: GameSide = pos.y > BoardMarkerV.redRiver ? .red : .black

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
        self.p1Timer = 15 * 60
        self.p2Timer = 15 * 60
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

    func getGeneral(of side: GameSide) -> General {
        pieces.first(where: { $0.side == side && $0 is General }) as! General
    }

    func start() {
        state = .isPlaying(.red)
        startTimer()
    }

    private func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.currentPlayer == .red {
                    self.p1Timer -= 1
                } else {
                    self.p2Timer -= 1
                }

                if self.p1Timer <= 0 || self.p2Timer <= 0 {
                    self.endGame(loser: self.currentPlayer)
                }
            }
    }
}

// MARK: - Actions
extension GameManager {
    func canMove(_ move: Move) throws -> Bool {
        let myKing = getGeneral(of: move.from.side)

        // simulate move
        var otherSidePieces = Set(pieces.filter({ $0.side != move.from.side }))

        if let c = move.captured {
            otherSidePieces.remove(c)
        }

        // check if move is valid
        try otherSidePieces.forEach {
            if $0.canCheck(myKing) {
                throw MoveError.loseKing
            }
        }

        return true
    }

    func performMove(_ move: Move) throws {
        // Check if the move is valid and update the game state accordingly
        guard try canMove(move) else { return }
        if let captured = move.captured, let idx = pieces.firstIndex(of: captured) {
            capturedPieces.append(captured)
            pieces.remove(at: idx)
        }

        let org = move.perform()
        moves.append((move, org))

        updateGameStatus()
    }

    private func endGame(loser: GameSide? = nil) {
        timer?.cancel()
        state = .ended(loser)
    }

    func updateGameStatus() {

        // Update turn
        currentPlayer.toggle()

        // King in check status
    }
}
