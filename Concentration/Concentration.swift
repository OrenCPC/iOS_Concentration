//
//  Concentration.swift
//  Concentration
//
//  Created by Oren Dinur on 08/02/2022.
//

import Foundation

class Concentration{
    
    var cards = Array <Card>()
    //Same as [Card]()
    
    var flipCount = 0
    
    var score = 0
    
    var seenCards = [Int:Int]()

    var indexOfOneAndOnlyFaceUpCard: Int?
     
    //The beginning of our game
    var previousClick = Date()

    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                else{
                    if seenCards[matchIndex] != nil {
                        score -= 1
                    } else{
                        seenCards[matchIndex] = 1
                    }
                    
                    if seenCards[index] != nil {
                        score -= 1
                    } else{
                        seenCards[index] = 1
                    }
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are faced up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                    
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
        
        //The time of the last click a player made plus another 30 seconds
        let future = Date(timeInterval: 30, since: previousClick)
        
        let fallsBetween = (previousClick ... future).contains(Date())
        //If the player hadn't play for 30 seconds he is punished with -3 points
        if !fallsBetween{
            score -= 3
        }
        previousClick = Date()
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        var i = 0
        while i < numberOfPairsOfCards {
            let randomIndex = Int(arc4random_uniform(UInt32(numberOfPairsOfCards - 1)))
            let temp = cards.remove(at: randomIndex)
            cards += [temp]
            i += 1
        }

    }
}
