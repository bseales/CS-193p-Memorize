//
//  ContentView.swift
//  CS-193p-Memorize
//
//  Created by Batson Seales on 10/17/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Score: \(viewModel.score)")
                    Spacer()
                    Text(viewModel.themeName)
                    Spacer()
                    Button("New Game", action: {
                        viewModel.newGame()
                    })
                }.padding()
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    viewModel.choose(card)
                                }
                        }
                    }
                }
                .foregroundColor(.red)
                .padding(.horizontal)
                .alert(isPresented: .constant(viewModel.pairsRemainingZero)) {
                    Alert(title: Text("You Win!"), message: Text("Final Score: \(viewModel.score)"), dismissButton: .default (
                        Text("New Game"), action: {
                            viewModel.newGame()
                        }
                    )
                    )
                }
            }
            if viewModel.changedScore != 0 {
                VStack() {
                    Spacer()
                    Text("\(viewModel.changedScore > 0 ? "+" + String(viewModel.changedScore) : String(viewModel.changedScore))")
                        .font(.system(size:40))
                        .foregroundColor(viewModel.changedScore > 0 ? .green : .red)
                        
                }
            }
            
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill(.red.gradient)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
