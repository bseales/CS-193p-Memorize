//
//  EmojiMemoryGame.swift
//  CS-193p-Memorize
//
//  Created by Batson Seales on 10/17/22.
//

// ViewModel

import SwiftUI

class EmojiMemoryGame {
    static let emojis = ["🚗", "🚙", "🏎", "🚕", "🚓", "🚜", "✈️", "🏍", "🚲", "🚀", "🛶", "🚢", "🚛", "🚑", "🚚", "🚒", "🛻", "⛵️", "🚤", "⛴"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
