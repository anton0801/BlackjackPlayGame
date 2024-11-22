import SpriteKit

struct BaseCardsDataModel: Decodable {
    var state: String?
    var userUUID: String

    private enum CodingKeys: String, CodingKey {
        case state = "response"
        case userUUID = "client_id"
    }
}

class BaseCardGameScene: SKScene {
    
    var homeBtn: SKSpriteNode!
    var infoBtn: SKSpriteNode!
    
    var balance = UserDefaults.standard.integer(forKey: "userBalance") {
        didSet {
            balanceLabel.text = "\(balance)"
            UserDefaults.standard.set(balance, forKey: "userBalance")
        }
    }
    var balanceLabel: SKLabelNode!
    
    var cards: [CardItem] = []
    
    var win: Int = 0 {
        didSet {
            winLabel.text = "\(win)"
        }
    }
    private var winLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 1350, height: 750)
        drawBackground()
        setUpCards()
        
        homeBtn = createNode(src: "home_btn", size: CGSize(width: 130, height: 150), position: CGPoint(x: 80, y: size.height - 80), name: "homeBtn")
        homeBtn.zPosition = 10
        addChild(homeBtn)
        
        infoBtn = createNode(src: "info_btn", size: CGSize(width: 130, height: 150), position: CGPoint(x: 200, y: size.height - 80), name: "infoBtn")
        infoBtn.zPosition = 10
        addChild(infoBtn)
        
        let winBackground = createNode(src: "win_bg", size: CGSize(width: 250, height: 200), position: CGPoint(x: 170, y: size.height / 2))
        winBackground.zPosition = 4
        addChild(winBackground)
        
        winLabel = SKLabelNode(text: "0")
        winLabel.position = CGPoint(x: 130, y: size.height / 2 - 40)
        winLabel.fontSize = 42
        winLabel.fontColor = .white
        winLabel.fontName = "LilitaOne"
        winLabel.zPosition = 5
        addChild(winLabel)
        
        let balanceBackground = createNode(src: "balance_bg", size: CGSize(width: 250, height: 130), position: CGPoint(x: size.width - 250, y: size.height - 80))
        addChild(balanceBackground)
        
        balanceLabel = SKLabelNode(text: "\(balance)")
        balanceLabel.position = CGPoint(x: size.width - 280, y: size.height - 95)
        balanceLabel.fontSize = 32
        balanceLabel.fontColor = .white
        balanceLabel.fontName = "LilitaOne"
        balanceLabel.zPosition = 5
        addChild(balanceLabel)
    }
    
    func createNode(src: String, size: CGSize, position: CGPoint, name: String? = nil) -> SKSpriteNode {
        let createNode = SKSpriteNode(imageNamed: src)
        createNode.size = size
        createNode.position = position
        createNode.name = name
        return createNode
    }
    
    private func setUpCards() {
        let values = ["ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jak", "queen", "king"]
        let suits = ["hearts", "diamonds", "spades", "clubs"]
        for suit in suits {
            for value in values {
                var cardValue: [Int]
                if value == "ace" {
                    cardValue = [1, 11]
                } else if value == "jak" || value == "queen" || value == "king" {
                    cardValue = [10]
                } else {
                    cardValue = [Int(value)!]
                }
                cards.append(CardItem(cardValue: cardValue, cardSrc: "\(suit)_\(value)"))
            }
        }
    }
    
    private func drawBackground() {
        let cardBackground = UserDefaults.standard.string(forKey: "card_game_background") ?? "cards_game_bg"
        let backgroundNode = SKSpriteNode(imageNamed: cardBackground)
        backgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backgroundNode.size = size
        backgroundNode.zPosition = -1
        addChild(backgroundNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let loc = touch.location(in: self)
            
            for node in nodes(at: loc) {
                if node == homeBtn {
                    NotificationCenter.default.post(name: Notification.Name("go_menu"), object: nil)
                }
                
                if node == infoBtn {
                    NotificationCenter.default.post(name: Notification.Name("open_info"), object: nil)
                }
                
                checkTouchNodes(node: node)
            }
        }
    }
    
    func checkTouchNodes(node: SKNode) { }
    
}
