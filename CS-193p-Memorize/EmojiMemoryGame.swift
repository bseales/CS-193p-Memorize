//
//  EmojiMemoryGame.swift
//  CS-193p-Memorize
//
//  Created by Batson Seales on 10/17/22.
//

// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let themes = [
        "Vehicles": [ "🚗", "🚙", "🏎", "🚕", "🚓", "🚜", "✈️", "🏍", "🚲", "🚀", "🛶", "🚢", "🚛", "🚑", "🚚", "🚒", "🛻", "⛵️", "🚤", "⛴"],
        "Halloween": ["🕷", "🕸", "🎃", "👻", "💀", "🍬", "🗡", "🍫"],
        "Animals": ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸"]
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        let randomTheme = themes.randomElement()!
        
        return MemoryGame(numberOfPairsOfCards: min(randomTheme.value.count, 8), themeName: randomTheme.key) { pairIndex in
            randomTheme.value[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var pairsRemainingZero: Bool {
        model.pairsRemaining == 0
    }
    var themeName: String {
        model.theme
    }
    
    var changedScore: Int {
        model.changedScore
    }
    
    // MARK: - Intents
    func choose(_ card: MemoryGame<String>.Card) -> Void {
        model.choose(card)
    }
    
    func newGame() -> Void {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
