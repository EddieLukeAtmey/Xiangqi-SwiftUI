//
//  LinesView.swift
//  ChessGames
//
//  Created by Eddie Luke Atmey on 20/07/2023.
//

import SwiftUI

struct LinesView: View {

    let width: CGFloat
    let height: CGFloat
    let halfHeight: CGFloat
    let spacing: CGFloat

    var body: some View {
        Group {
            // Draw H-Lines
            Path { p in
                for i in 0..<10 {
                    let line = CGFloat(i) * spacing
                    p.move(to: .init(x: 0, y:  line))
                    p.addLine(to: .init(x: width, y: line))
                }
            }
            .stroke(.black, lineWidth: 0.5)

            // Draw V-Lines
            Path { p in
                // 0st
                p.move(to: .init(x: 0, y:  0))
                p.addLine(to: .init(x: 0, y: height))

                // 1-7
                for i in 1...7 {
                    let col = spacing * CGFloat(i)

                    p.move(to: .init(x: col, y: 0))
                    p.addLine(to: .init(x: col, y: halfHeight))

                    p.move(to: .init(x: col, y: height - halfHeight))
                    p.addLine(to: .init(x: col, y: height))
                }

                // 8
                p.move(to: .init(x: width, y:  0))
                p.addLine(to: .init(x: width, y: height))
            }
            .stroke(.black, lineWidth: 0.5)

            // Draw Castle Path
            Path {
                $0.move(to: .init(x: spacing * 3, y:  spacing * 2))
                $0.addLine(to: .init(x: spacing * 5, y: 0))

                $0.move(to: .init(x: spacing * 3, y: 0))
                $0.addLine(to: .init(x: spacing * 5, y: spacing * 2))

                $0.move(to: .init(x: spacing * 3, y: spacing * 7))
                $0.addLine(to: .init(x: spacing * 5, y: spacing * 9))

                $0.move(to: .init(x: spacing * 3, y: spacing * 9))
                $0.addLine(to: .init(x: spacing * 5, y: spacing * 7))
            }
            .stroke(.black, lineWidth: 0.5)

            // Draw Mountain Path
            Path {
                let radius = spacing * 0.2

                let centers = [CGPoint(x: spacing, y: spacing * 2),
                               CGPoint(x: spacing * 7, y: spacing * 2),
                               CGPoint(x: spacing, y: spacing * 7),
                               CGPoint(x: spacing * 7, y: spacing * 7)]

                for center in centers {
                    $0.move(to: .init(x: center.x - radius, y: center.y - radius))
                    $0.addLine(to: .init(x: center.x + radius, y: center.y + radius))
                    $0.move(to: .init(x: center.x - radius, y: center.y + radius))
                    $0.addLine(to: .init(x: center.x + radius, y: center.y - radius))
                }
            }
            .stroke(.black, lineWidth: 0.5)
        }
    }
}
