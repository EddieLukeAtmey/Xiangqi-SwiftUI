//
//  BoardView.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import SwiftUI

struct BoardView: View {

    @State var pieces: [GamePiece]

    var body: some View {
        let width = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 8/9
        let spacing = width / 8 // horizontal
        
        // vertical
        let fullHeigth = spacing * 9
        let halfHeigth = spacing * 4
        
        ZStack {
            Color(red: 240/255, green: 208/255, blue: 160/255)
            
            LinesView(width: width, height: fullHeigth, halfHeight: halfHeigth, spacing: spacing)
            
            // Add the game pieces
            ForEach(pieces, id: \.self) { piece in
                GamePieceView(piece: piece)
                    .position(x: CGFloat(piece.position.x) * spacing, y: CGFloat(piece.position.y) * spacing)
            }
        }
        .frame(width:  width, height: fullHeigth)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        let gm = GameManager()
        BoardView(pieces: gm.pieces)
    }
}
