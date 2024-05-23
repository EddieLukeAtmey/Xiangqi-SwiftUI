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
protocol GameManager: AnyObject {
    var pieces: [GamePiece] { get }
    var capturedPieces: [GamePiece] { get }
    var timer: AnyCancellable? { get }

    static var allStartingPositions: [Position] { get }
}

extension GameManager {

    func getPiece(at position: Position) -> GamePiece? {
        pieces.first { $0.position == position }
    }
}
