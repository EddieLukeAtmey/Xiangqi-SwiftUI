//
//  GameView.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import SwiftUI

struct GameView: View {

    var gameManager: GameManager

    var body: some View {
        VStack {
            TopMenuView(p1Name: "p1",
                        p2Name: "p2",
                        p1Timer: 15*60,
                        p2Timer: 15*60) {

                // Start the game
            }
            BoardView(pieces: gameManager.pieces)
        }
        .padding(.zero)
        .frame(maxWidth: .infinity)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameManager: .init())
    }
}
