//
//  xingqiApp.swift
//  xingqi
//
//  Created by Eddie on 17/07/2023.
//

import SwiftUI

@main
struct xingqiApp: App {

    // TODO: Remove when implement later
    var tempGameManager = GameManager()

    var body: some Scene {
        WindowGroup {
            MainMenuView().environmentObject(tempGameManager)
//            GameView().environmentObject(tempGameManager)
        }
    }
}
