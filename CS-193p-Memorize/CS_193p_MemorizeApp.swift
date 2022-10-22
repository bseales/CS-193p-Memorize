//
//  CS_193p_MemorizeApp.swift
//  CS-193p-Memorize
//
//  Created by Batson Seales on 10/17/22.
//

import SwiftUI

@main
struct CS_193p_MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
