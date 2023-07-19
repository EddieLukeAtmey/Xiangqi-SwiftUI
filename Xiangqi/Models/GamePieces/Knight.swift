//
//  Knight.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 傌 or 馬
final class Knight: GamePiece {
    override var title: String {
        side == .red ? "傌" : "馬"
    }

    override var availableUpMoves: [Move] {
        
    }
}
