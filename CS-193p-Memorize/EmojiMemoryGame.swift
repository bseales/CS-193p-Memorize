//
//  EmojiMemoryGame.swift
//  CS-193p-Memorize
//
//  Created by Batson Seales on 10/17/22.
//

// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🚗", "🚙", "🏎", "🚕", "🚓", "🚜", "✈️", "🏍", "🚲", "🚀", "🛶", "🚢", "🚛", "🚑", "🚚", "🚒", "🛻", "⛵️", "🚤", "⛴"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    func choose(_ card: MemoryGame<String>.Card) -> Void {
        model.choose(card)
    }
    
    func newGame() -> Void {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
