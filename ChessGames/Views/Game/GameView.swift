//
//  GameView.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import SwiftUI

struct GameView: View {

    @EnvironmentObject var gameManager: GameManager

    var body: some View {
        VStack {
            TopMenuView(p1Name: "p1",
                        p2Name: "p2") {

                // Start the game
                gameManager.start()
            }
            BoardView()
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
