//
//  Bishop.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import Foundation

/// 相 or 象
final class Bishop: GamePiece {
    override var title: String {
        side == .red ? "相" : "象"
    }
}
