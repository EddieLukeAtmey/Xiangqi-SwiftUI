//
//  PlayerInfoView.swift
//  iXiangqi
//
//  Created by Eddie Luke Atmey on 1/6/24.
//

import SwiftUI

struct PlayerInfoView: View {

    let name: String
    let alignment: HorizontalAlignment
    @Binding var timer: Int

    var body: some View {
        VStack(alignment: alignment) {
            Text(name)
                .foregroundColor(.red)
                .font(.title)

            Text("\(formattedTime(from: timer))")
                .font(.title)
        }
    }

    private func formattedTime(from totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    PlayerInfoView(name: "Hhihi", alignment: .leading, timer: .constant(100))
}
