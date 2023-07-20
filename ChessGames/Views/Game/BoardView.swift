//
//  BoardView.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import SwiftUI

struct BoardView: View {

    @State var pieces: [GamePiece]

    var body: some View {
        let width = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - 30
        let spacing = width / 8 // horizontal
        
        // vertical
        let fullHeigth = spacing * 9
        let halfHeigth = spacing * 4
        
        ZStack {
            Color(red: 240/255, green: 208/255, blue: 160/255)
            
            LinesView(width: width, height: fullHeigth, halfHeight: halfHeigth, spacing: spacing)
            
            // Add the game pieces
            ForEach(pieces, id: \.self) { piece in
                GamePieceView(piece: piece)
                    .position(x: CGFloat(piece.position.x) * spacing, y: CGFloat(piece.position.y) * spacing)
            }
        }
        .frame(width:  width, height: fullHeigth)
    }
}

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

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        let gm = GameManager()
        BoardView(pieces: gm.pieces)
    }
}
