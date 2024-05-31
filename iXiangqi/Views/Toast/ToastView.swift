//
//  ToastView.swift
//  ChessGames
//
//  Created by Eddie Luke Atmey on 21/5/24.
//

import SwiftUI

struct ToastView: View {
    var message: String

    var body: some View {
        Text(message)
            .font(.body)
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(8)
            .shadow(radius: 10)
            .opacity(0.9)
            .multilineTextAlignment(.center)
            .transition(.opacity)
    }
}

#Preview {
    ToastView(message: "haha\nhuhuasdzx")
}
