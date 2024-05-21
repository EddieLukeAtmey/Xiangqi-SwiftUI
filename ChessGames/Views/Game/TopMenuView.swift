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
            VStack(alignment: .leading) {
                Text(p1Name)
                    .foregroundColor(.red)
                    .font(.title)

                Text("\(formattedTime(from: gameManager.p1Timer))")
                    .font(.title)
            }

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
                    if var losingSide {
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

            VStack(alignment: .trailing) {
                Text(p2Name)
                    .foregroundColor(.black)
                    .font(.title)

                Text("\(formattedTime(from: gameManager.p2Timer))")
                    .font(.title)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private func formattedTime(from totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct TopMenuView_Previews: PreviewProvider {

    static var previews: some View {
        TopMenuView(p1Name: "P1", p2Name: "P2")
        .environmentObject(GameManager())
    }
}
