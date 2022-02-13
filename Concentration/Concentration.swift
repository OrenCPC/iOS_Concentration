//
//  Concentration.swift
//  Concentration
//
//  Created by Oren Dinur on 08/02/2022.
//

import Foundation

class Concentration {
    
   private(set) var cards = Array <Card>()
    //Same as [Card]()
    
    private(set) var flipCount = 0
    
    var score = 0
    
    var seenCards = [Int:Int]()
    
    var previousClick: Date

   private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func matchOccured(firstIndex matchIndex: Int, secondIndex index: Int) {
        cards[matchIndex].isMatched = true
        cards[index].isMatched = true
        score += 2
    }
    
    func noMatchOccured(firstIndex matchIndex: Int, secondIndex index: Int) {
        if seenCards[matchIndex] != nil {
            score -= 1
        } else {
            seenCards[matchIndex] = 1
        }
        
        if seenCards[index] != nil {
            score -= 1
        } else {
            seenCards[index] = 1
        }
    }
    

    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    matchOccured(firstIndex: matchIndex, secondIndex: index)
                }
                else {
                    noMatchOccured(firstIndex: matchIndex, secondIndex: index)
                }
                cards[index].isFaceUp = true
            } else {
                //either no cards or 2 cards are faced up
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
        
        //The time of the last click a player made plus another 30 seconds
        let future = Date(timeInterval: 30, since: previousClick)
        
        let fallsBetween = (previousClick ... future).contains(Date())
        //If the player hadn't play for 30 seconds he is punished with -3 points
        if !fallsBetween {
            score -= 3
        }
        previousClick = Date()
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)):you must have at least one pair of cards")
       
        //The beginning of our game
        previousClick = Date()
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
}
