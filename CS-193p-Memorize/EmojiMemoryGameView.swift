//
//  EmojiMemoryGameView.swift
//  CS-193p-Memorize
//
//  Created by Batson Seales on 10/17/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Score: \(game.score)")
                    Spacer()
                    Text(game.themeName)
                    Spacer()
                    Button("New Game", action: {
                        game.newGame()
                    })
                }.padding()
                AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                    if card.isMatched && !card.isFaceUp {
                        Rectangle().opacity(0)
                    } else {
                        CardView(card: card)
                            .padding(4)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
                .foregroundColor(.red)
                .padding(.horizontal)
                .alert(isPresented: .constant(game.pairsRemainingZero)) {
                    Alert(title: Text("You Win!"), message: Text("Final Score: \(game.score)"), dismissButton: .default (
                        Text("New Game"), action: {
                            game.newGame()
                        }
                    )
                    )
                }
            }
            if game.changedScore != 0 {
                VStack() {
                    Spacer()
                    Text("\(game.changedScore > 0 ? "+" + String(game.changedScore) : String(game.changedScore))")
                        .font(.system(size:40))
                        .foregroundColor(game.changedScore > 0 ? .green : .red)
                        
                }
            }
            
        }
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(6).opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill(.red.gradient)
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        
        
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
