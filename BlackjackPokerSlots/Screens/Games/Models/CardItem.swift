import Foundation

struct CardItem: Equatable {
    var cardValue: [Int]
    var cardSrc: String
    
    static func == (lhs: CardItem, rhs: CardItem) -> Bool {
        lhs.cardSrc == rhs.cardSrc
    }
}


struct Hand {
    init<Cards: Sequence>(cards: Cards) where Cards.Element == CardItem {
        let reduction = cards.reduce(into: (score: 0, aceCount: 0)) { result, card in
            switch card.cardValue {
            case [1, 11]:
                result.score += 1
                result.aceCount += 1
            case [10]:
                result.score += 10
            default:
                result.score += card.cardValue[0]
            }
        }
        var handScore = reduction.score
        (0..<reduction.aceCount).forEach { _ in
            if handScore <= 11 {
                handScore += 10
            }
        }
        self.score = handScore
    }

    let score: Int
}
