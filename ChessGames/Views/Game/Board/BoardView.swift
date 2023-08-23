//
//  BoardView.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import SwiftUI

struct BoardView: View {

    @ObservedObject var gameManager: GameManager

//    @State var pieces: [GamePiece]
    @State var selectedPiece: GamePiece?

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
            ForEach(gameManager.pieces, id: \.self) { piece in
                GamePieceView(piece: piece, selected: piece == selectedPiece)
                    .position(x: CGFloat(piece.position.x) * spacing, y: CGFloat(piece.position.y) * spacing)
                    .animation(.easeInOut, value: piece.position)
                    .onTapGesture {
                        if selectedPiece == piece { selectedPiece = nil } // Deselect
                        else if piece.side == gameManager.currentPlayer {
                            // Set the selected piece in the GameManager
                            selectedPiece = piece
                        }
                    }
                    .animation(.easeIn(duration: 0.1), value: selectedPiece)
            }

            // Add available moves
            if let selectedPiece = selectedPiece,
               selectedPiece.side == gameManager.currentPlayer {

                ForEach(selectedPiece.availableMoves, id: \.to) { move in
                    MoveView(move: move, spacing: spacing)
                        .onTapGesture {
                            // Perform the piece movement here
                            do {
                                try gameManager.performMove(move)
                                self.selectedPiece = nil
                            }
                            catch {
                                // Display toast error
                                print(error)
                            }
                        }
                }
            }
        }
        .frame(width:  width, height: fullHeigth)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        let gm = GameManager()
        BoardView(gameManager: gm)
    }
}
