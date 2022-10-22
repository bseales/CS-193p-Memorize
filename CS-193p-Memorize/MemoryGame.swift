//
//  MemoryGame.swift
//  CS-193p-Memorize
//
//  Created by Batson Seales on 10/17/22.
//

// Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int
    private var seenCards: Array<Int>
    private(set) var pairsRemaining: Int
    private(set) var theme: String
    private(set) var changedScore: Int
    
    private var indexOfFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) -> Void {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            changedScore = 0
            
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    score += 2
                    changedScore = 2
                    pairsRemaining -= 1
                } else {
                    if seenCards[cards[chosenIndex].id] > 0 {
                        score -= 1
                        changedScore -= 1
                    }
                    if seenCards[cards[potentialMatchIndex].id] > 0 {
                        score -= 1
                        changedScore -= 1
                    }
                }
                
                seenCards[cards[chosenIndex].id] += 1
                seenCards[cards[potentialMatchIndex].id] += 1
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfFaceUpCard = chosenIndex
            }
            
            
        }
        
    }
    
    init(numberOfPairsOfCards: Int, themeName: String, createCardContent: (Int) -> CardContent) {
        cards = []
        score = 0
        changedScore = 0
        seenCards = Array(repeating: 0, count: numberOfPairsOfCards * 2 + 1)
        pairsRemaining = numberOfPairsOfCards
        theme = themeName
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
            
            seenCards[pairIndex * 2] = 0
            seenCards[pairIndex * 2 + 1] = 0
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        let id: Int
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
    }
    
}

extension Array {
    var oneAndOnly: Element? { 1 == count ? first : nil }
}
