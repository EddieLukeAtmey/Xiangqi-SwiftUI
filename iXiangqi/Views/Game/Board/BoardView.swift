//
//  BoardView.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import SwiftUI

struct BoardView: View {

    @EnvironmentObject var gameManager: GameManager
    @State var selectedPiece: GamePiece?
    @State private var message: String?

    var body: some View {
        let width = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 8/9
        let spacing = width / 8 // horizontal

        // vertical
        let fullHeight = spacing * 9
        let halfHeigth = spacing * 4

        ZStack {
            Color(red: 240/255, green: 208/255, blue: 160/255)
            
            LinesView(width: width, height: fullHeight, halfHeight: halfHeigth, spacing: spacing)
            
            // Add the game pieces
            ForEach(gameManager.pieces, id: \.self) { piece in
                GamePieceView(piece: piece, selected: piece == selectedPiece)
                    .position(x: CGFloat(piece.position.x) * spacing, y: CGFloat(piece.position.y) * spacing)
                    .animation(.easeInOut, value: piece.position)
                    .onTapGesture {
                        guard case .isPlaying(let currentSide) = gameManager.state else { return }

                        if selectedPiece == piece { selectedPiece = nil } // Deselect
                        else if piece.side == currentSide {
                            // Set the selected piece in the GameManager
                            selectedPiece = piece
                        } else if let sp = selectedPiece, let move = Move(sp, to: piece.position) { // Capture
                            do {
                                try gameManager.performMove(move)
                                selectedPiece = nil
                            } catch {
                                // Display toast error
                                toastMessage(error.localizedDescription)
                            }
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
                                toastMessage(error.localizedDescription)
                            }
                        }
                }
            }

            if let message {
                ToastView(message: message)
                    .position(x: width / 2, y: fullHeight / 2)
                    .zIndex(1)
            }
        }
        .frame(width:  width, height: fullHeight)
    }

    private func toastMessage(_ message: String) {
        withAnimation {
            self.message = message
        }

        print(message)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.message = nil
            }
        }
    }
}

#Preview {
    BoardView().environmentObject(GameManager())
}
