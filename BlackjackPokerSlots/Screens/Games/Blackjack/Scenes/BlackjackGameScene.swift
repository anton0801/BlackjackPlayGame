import SwiftUI
import SpriteKit

class BlackjackGameScene: BaseCardGameScene {
    
    struct BetChip {
        var betValue: Int
        var src: String
    }
    
    enum GameState {
        case none
        case winDiller,
             winPlayer,
             draw
    }
    
    
    private var standBtn: SKSpriteNode!
    private var hitMeBtn: SKSpriteNode!
    private var startBtn: SKSpriteNode!
    
    private var betField: SKSpriteNode!
    private var betsPlaced: [BetChip] = [] {
        didSet {
            if !betsPlaced.isEmpty {
                totalBet = betsPlaced.map { $0.betValue }.reduce(0, +)
            }
        }
    }
    private var totalBet: Int = 0
    private var betChips = [
        BetChip(betValue: 2, src: "chip_2"),
        BetChip(betValue: 5, src: "chip_5"),
        BetChip(betValue: 25, src: "chip_25"),
        BetChip(betValue: 100, src: "chip_100"),
        BetChip(betValue: 500, src: "chip_500"),
        BetChip(betValue: 1000, src: "chip_1000")
    ]
    
    private var gameState: GameState = .none {
        didSet {
            if gameState != .none {
                showResultGame()
            }
        }
    }
    
    private var dillerCards: [CardItem] = []
    private var playerCards: [CardItem] = []
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        betField = createNode(src: "bet_zone", size: CGSize(width: 140, height: 160), position: CGPoint(x: 150, y: 120), name: "bet_field")
        addChild(betField)
        
        createBetChips()
        
        startBtn = createNode(src: "play_btn", size: CGSize(width: 145, height: 160), position: CGPoint(x: size.width / 2, y: 100))
        startBtn.zPosition = 15
        addChild(startBtn)
        
        standBtn = createNode(src: "stand_btn", size: CGSize(width: 175, height: 180), position: CGPoint(x: size.width / 2 + 100, y: size.height / 2), name: "stand_btn")
        standBtn.zPosition = 12
        hitMeBtn = createNode(src: "hit_btn", size: CGSize(width: 175, height: 180), position: CGPoint(x: size.width / 2 - 100, y: size.height / 2), name: "hit_btn")
        standBtn.zPosition = 12
    }
    
    private func createBetChips() {
        let chipSize: CGFloat = 62
        let chipsAllSpaceWidth: CGFloat = (chipSize + 12) * CGFloat(betChips.count)
        let restOfPlace = size.width / 2 - chipsAllSpaceWidth
        let startPoint: CGFloat = size.width / 2 + restOfPlace
        for (index, betChip) in betChips.enumerated() {
            let chipPositionI = ((chipSize + 12) * CGFloat(index)) + startPoint
            let chipNode = createNode(src: betChip.src, size: CGSize(width: chipSize, height: chipSize), position: CGPoint(x: chipPositionI, y: 100), name: "chip_\(betChip.betValue)")
            addChild(chipNode)
        }
    }
    
    func restartScene() -> BlackjackGameScene {
        let newGameScene = BlackjackGameScene()
        view?.presentScene(newGameScene)
        return newGameScene
    }
    
    
    private func placeBet(placedChip: BetChip) {
        let morePlacedBet = placedChip.betValue
        // MARK: change condition
        if balance <= (totalBet + morePlacedBet) {
            if betsPlaced.count < 6 {
                betsPlaced.append(placedChip)
                
                let chipSize: CGFloat = 62
                let chipsAllSpaceWidth: CGFloat = (chipSize + 12) * CGFloat(betChips.count)
                let restOfPlace = size.width / 2 - chipsAllSpaceWidth
                let startPoint: CGFloat = size.width / 2 + restOfPlace
                let initialPointOfBetX = ((chipSize + 12) * CGFloat(betChips.firstIndex(where: {
                    $0.betValue == placedChip.betValue
                })!)) + startPoint
                
                let indexChip = betsPlaced.count - 1
                
                let newBetPlacedChip = createNode(src: placedChip.src, size: CGSize(width: 92, height: 92), position: CGPoint(x: initialPointOfBetX, y: 100), name: "placed_chip")
                newBetPlacedChip.zPosition = CGFloat(indexChip + 1)
                addChild(newBetPlacedChip)
                
                var baseLocationOfChips = betField.position
                baseLocationOfChips.x += CGFloat.random(in: -25...25)
                baseLocationOfChips.y += CGFloat.random(in: -25...25)
                let actionMove = SKAction.move(to: baseLocationOfChips, duration: 1)
                actionMove.timingMode = .easeInEaseOut
                let actionScale = SKAction.scale(to: 0.6, duration: 1)
                actionScale.timingMode = .easeInEaseOut
                let group = SKAction.group([actionMove, actionScale])
                newBetPlacedChip.run(group)
            } else {
                NotificationCenter.default.post(name: Notification.Name("show_alert"), object: nil, userInfo: ["title": "Bet error!", "message": "You can put only 6 bet chips on the table."])
            }
        } else {
            NotificationCenter.default.post(name: Notification.Name("show_alert"), object: nil, userInfo: ["title": "Bet error!", "message": "You don't have enought credits to use place this bet more."])
        }
    }
    
    override func checkTouchNodes(node: SKNode) {
        if node.name?.contains("chip") == true {
            let placedBet = Int(node.name!.components(separatedBy: "_")[1])
            if let placedBet = placedBet {
                if let betChip = betChips.filter({ $0.betValue == placedBet }).first {
                    placeBet(placedChip: betChip)
                    return
                }
            }
        }
        
        if node == startBtn {
            if gameState == .none {
                startGame()
            } else {
                NotificationCenter.default.post(name: Notification.Name("restart_btn"), object: nil)
            }
        }
        
        if node == hitMeBtn {
            let _ = getOneMorePlayerCard()
            return
        }
        
        if node == standBtn {
            checkDillerCards()
            return
        }
    }
    
    
    private func startGame() {
        if !betsPlaced.isEmpty {
            deskCards()
            showNeededButtonsForGame()
        } else {
            NotificationCenter.default.post(name: Notification.Name("show_alert"), object: nil, userInfo: ["title": "Error!", "message": "To start game, place bets first!"])
        }
    }
    
    private func getOneMorePlayerCard() -> CardItem {
        let deskCard = Array(cards.prefix(1))[0]
        cards.removeAll { card in
            card.cardSrc == deskCard.cardSrc
        }
        playerCards.append(deskCard)
        placeCard(card: deskCard, cardPos: CGFloat(playerCards.count - 1), startPoint: CGPoint(x: size.width / 2 - 50, y: 150)) {
            self.checkCards(cards: self.playerCards)
        }
        return deskCard
    }
    
    private func deskCards() {
        let deskCards = Array(cards.prefix(2))
        cards.removeAll { card in
            deskCards.contains(card)
        }
        let deskCards2 = Array(cards.prefix(2))
        dillerCards = deskCards
        playerCards = deskCards2
        
        for (index, playerCard) in playerCards.enumerated() {
            placeCard(card: playerCard, cardPos: CGFloat(index), startPoint: CGPoint(x: size.width / 2 - 50, y: 150))
        }
        
        for (index, dillerCard) in dillerCards.enumerated() {
            if index == 0 {
                placeCard(card: dillerCard, cardPos: CGFloat(index), startPoint: CGPoint(x: size.width / 2 - 50, y: size.height / 2 + 200))
            } else if index == 1 {
                placeCard(card: dillerCard, cardPos: CGFloat(index), startPoint: CGPoint(x: size.width / 2 - 50, y: size.height / 2 + 200), isFaceDown: true)
            }
        }
        
        checkCards(cards: playerCards)
    }
    
    private func showNeededButtonsForGame() {
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let fadeSeq = SKAction.sequence([fadeOutAction, SKAction.removeFromParent()])
        let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
        startBtn.run(fadeSeq) {
            self.addChild(self.standBtn)
            self.standBtn.run(fadeInAction)
            self.addChild(self.hitMeBtn)
            self.hitMeBtn.run(fadeInAction)
        }
    }
    
    private func getOneMoreDillerCard() -> CardItem {
        let deskCard = Array(cards.prefix(1))[0]
        cards.removeAll { card in
            card.cardSrc == deskCard.cardSrc
        }
        dillerCards.append(deskCard)
        placeCard(card: deskCard, cardPos: CGFloat(dillerCards.count - 1), startPoint: CGPoint(x: size.width / 2 - 50, y: size.height / 2 + 200)) {
            self.checkDillerCards()
        }
        return deskCard
    }
    
    private func placeCard(card: CardItem, cardPos: CGFloat, startPoint: CGPoint, isFaceDown: Bool = false, completion: (() -> Void)? = nil) {
        let startPositionCardsPlaced = CGPoint(x: size.width / 2 + 350, y: 400)
        let cardNode = createNode(src: isFaceDown ? "card_face_up" : card.cardSrc, size: CGSize(width: 80, height: 120), position: startPositionCardsPlaced)
        addChild(cardNode)
        let positionFinalCardX: CGFloat = startPoint.x + (cardPos * (cardNode.size.width - 30))
        let actionMove = SKAction.move(to: CGPoint(x: positionFinalCardX, y: startPoint.y), duration: 0.6)
        let rotateAction = SKAction.rotate(byAngle: .pi * 2, duration: 0.3)
        let rotateRepeate = SKAction.repeat(rotateAction, count: 2)
        let group = SKAction.group([actionMove, rotateRepeate])
        cardNode.run(group) {
            completion?()
        }
    }
    
    private func checkCards(cards: [CardItem]) {
        let hand = Hand(cards: cards)
        
        if hand.score == 21 && cards.count == 2 {
            blackjack = true
            openDillerCards()
        } else if hand.score > 21 {
            gameState = .winDiller
        }
    }
    
    private func fadeOutGameButtons() {
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let fadeSeq = SKAction.sequence([fadeOutAction, SKAction.removeFromParent()])
        let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
        
        self.standBtn.run(fadeSeq)
        self.hitMeBtn.run(fadeSeq) {
            self.addChild(self.startBtn)
            self.startBtn.run(fadeInAction)
        }
    }
    
    private func checkDillerCards() {
        if !cardDillerOpened {
            let node = atPoint(CGPoint(x: (size.width / 2 - 50) + (1 * (80 - 30)), y: size.height / 2 + 200))
            node.run(SKAction.setTexture(SKTexture(imageNamed: dillerCards[1].cardSrc)))
            cardDillerOpened = true
        }

        let playerHand = Hand(cards: playerCards)
        var dillerHand = Hand(cards: dillerCards)
        
        while dillerHand.score < 17 {
            let newCard = getOneMoreDillerCard()
            dillerCards.append(newCard)
            dillerHand = Hand(cards: dillerCards)
        }

        if dillerHand.score > 21 {
            gameState = .winPlayer
        } else if dillerHand.score >= playerHand.score {
            gameState = .winDiller
        } else if dillerHand.score == playerHand.score {
            gameState = .draw
        } else {
            gameState = .winPlayer
        }
    }
    
    private func openDillerCards() {
        let node = atPoint(CGPoint(x: (size.width / 2 - 50)  + (1 * (80 - 30)), y: size.height / 2 + 200))
        node.run(SKAction.setTexture(SKTexture(imageNamed: dillerCards[1].cardSrc)))
        cardDillerOpened = true
        
        let hand = Hand(cards: dillerCards)
        if hand.score == 21 {
            gameState = .draw
        } else {
            gameState = .winPlayer
        }
    }
    
    private var cardDillerOpened = false
    private var blackjack = false
    
    private func showResultGame() {
        fadeOutGameButtons()
        let background = SKSpriteNode(color: .black.withAlphaComponent(0.4), size: size)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = 10
        addChild(background)
        
        var text = "YOU LOSE"
        if gameState == .winPlayer {
            if blackjack {
                balance += totalBet * 3
                win = totalBet * 3
                text = "+\(totalBet * 3)"
            } else {
                balance += totalBet * 2
                win = totalBet * 2
                text = "+\(totalBet * 2)"
            }
        } else if gameState == .draw {
            text = "DRAW"
            win = totalBet
            balance += totalBet
        }
        let label: SKLabelNode = SKLabelNode(text: text)
        label.fontName = "LilitaOne"
        label.fontSize = 132
        label.fontColor = .white
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        label.zPosition = 11
        addChild(label)
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: BlackjackGameScene())
            .ignoresSafeArea()
    }
}
