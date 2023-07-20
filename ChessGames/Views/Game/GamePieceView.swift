//
//  GamePieceView.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import SwiftUI

struct GamePieceView: View {

    let piece: GamePiece

    var body: some View {

        Text(piece.title)
            .padding(5)
            .foregroundColor(piece.color)
            .fontWeight(.bold)
            .background (
                Circle()
                    .stroke(piece.color, lineWidth: 1)
                    .background(Circle().fill(Color(white: 0.8)))
            )
    }
}

struct GamePieceView_Previews: PreviewProvider {
    static var previews: some View {
        GamePieceView(piece: Pawn(position: .init(x: 0, y: 0), side: .red))
    }
}
