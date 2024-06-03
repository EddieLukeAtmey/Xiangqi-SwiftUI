//
//  TopMenuView.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import SwiftUI

struct TopMenuView: View {
    
    let p1Name: String
    let p2Name: String

    @EnvironmentObject var gameManager: GameManager

    var body: some View {
        HStack {
            PlayerInfoView(name: p1Name, alignment: .leading, timer: $gameManager.p1Timer)
            Spacer()

            switch gameManager.state {
            case .initialized: 
                Button(action: {
                    gameManager.start()
                }, label: {
                    Text("Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })

            case .ended(let losingSide):
                VStack {
                    if let losingSide {
                        Text("\(losingSide)'s lose")
                            .font(.title)
                            .textCase(.uppercase)
                    } else {
                        Text("Draw")
                            .font(.subheadline)
                            .textCase(.uppercase)
                    }

                    Button(action: {
                        gameManager.resetBoard()
                    }, label: {
                        Text("Restart")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                }

            case .isPlaying(let movingSide):
                Text("\(movingSide)'s turn")
                    .font(.title)
                    .textCase(.uppercase)
            }

            Spacer()
            PlayerInfoView(name: p2Name, alignment: .trailing, timer: $gameManager.p2Timer)
        }
        .frame(maxWidth: .infinity)
    }

}

struct TopMenuView_Previews: PreviewProvider {

    static var previews: some View {
        TopMenuView(p1Name: "P1", p2Name: "P2")
        .environmentObject(GameManager())
    }
}
