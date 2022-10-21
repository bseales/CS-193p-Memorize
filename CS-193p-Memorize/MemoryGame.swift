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
    private var indexOfFaceUpCard: Int?
    private(set) var score: Int
    private var seenCards: Array<Int>
    private(set) var pairsRemaining: Int
    private(set) var theme: String
    private(set) var changedScore: Int
    
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
                
                indexOfFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
        
    }
    
    init(numberOfPairsOfCards: Int, themeName: String, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
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
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
