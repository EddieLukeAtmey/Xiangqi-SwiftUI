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

    @State var p1Timer: Int
    @State var p2Timer: Int

    let onStart: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(p1Name)
                    .foregroundColor(.red)
                    .font(.title)

                Text("\(p1Timer)")
                    .font(.title)
            }

            Button(action: {
                onStart()
            }, label: {
                Text("Start")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            })

            VStack(alignment: .trailing) {
                Text(p2Name)
                    .foregroundColor(.black)
                    .font(.title)

                Text("\(p2Timer)")
                    .font(.title)
            }
        }
        .frame(maxWidth: .infinity)
    }

}

struct TopMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TopMenuView(p1Name: "P1", p2Name: "P2", p1Timer: 15*60, p2Timer: 15*60) {
            // Nothing
        }
    }
}
