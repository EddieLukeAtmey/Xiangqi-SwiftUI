//
//  MoveView.swift
//  ChessGames
//
//  Created by Eddie on 21/07/2023.
//

import SwiftUI

struct MoveView: View {
    let move: Move
    let spacing: CGFloat

    var body: some View {
        Circle()
            .fill(move.captured == nil ? Color.green : Color.red)
            .frame(width: spacing / 5, height: spacing / 5)
            .position(x: CGFloat(move.to.x) * spacing, y: CGFloat(move.to.y) * spacing)
    }
}
