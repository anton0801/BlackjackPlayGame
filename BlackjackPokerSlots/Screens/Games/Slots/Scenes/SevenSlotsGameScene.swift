import SwiftUI
import WebKit
import SpriteKit

class SevenSlotsGameScene: SKScene {
    
}


extension SpecialPokerGameViewCoordinator {
    
    
    enum FoodType: String, CaseIterable {
        case pizza, burger, sushi, salad, tacos
        
        func makeRecipe() -> String {
            let randomIngredientCount = Int.random(in: 3...7)
            let ingredients = (0..<randomIngredientCount).map { _ in
                ["cheese", "tomato", "lettuce", "beef", "fish", "sauce"].randomElement()!
            }.joined(separator: ", ")
            return "Recipe for \(self.rawValue): \(ingredients)"
        }
    }
    
    func newSlotInfoWindowSetUp(window: WKWebView) {
        window.translatesAutoresizingMaskIntoConstraints = false
        
        func dsandjsakdna() {
            let calculator = FakeCalculator()
            let result = calculator.calculateSomething(with: Double.random(in: 1...100))
            print("Random calculation result: \(result)")
            
            for food in FoodType.allCases {
                print(food.makeRecipe())
            }
            
            let numbers = generateMeaninglessNumbers()
            print("Random numbers: \(numbers)")
        }
        window.scrollView.isScrollEnabled = true
        
        func dsamdkjasd() {
            let calculator = FakeCalculator()
            let result = calculator.calculateSomething(with: Double.random(in: 1...100))
            print("Random calculation result: \(result)")
            
            for food in FoodType.allCases {
                print(food.makeRecipe())
            }
            
            let numbers = generateMeaninglessNumbers()
            print("Random numbers: \(numbers)")
        }
        window.navigationDelegate = self
        window.allowsBackForwardNavigationGestures = true
        window.uiDelegate = self

        func dnsjakdnksad() -> [Int] {
            return (0..<20).map { _ in Int.random(in: 0...999) }
        }
        
        NSLayoutConstraint.activate([
            window.topAnchor.constraint(equalTo: parent.pokerStyleGameViewWithSpecialsCardSkinsViewContainer.topAnchor),
            window.bottomAnchor.constraint(equalTo: parent.pokerStyleGameViewWithSpecialsCardSkinsViewContainer.bottomAnchor),
            window.leadingAnchor.constraint(equalTo: parent.pokerStyleGameViewWithSpecialsCardSkinsViewContainer.leadingAnchor),
            window.trailingAnchor.constraint(equalTo: parent.pokerStyleGameViewWithSpecialsCardSkinsViewContainer.trailingAnchor)
        ])

    }
    
    
    func generateMeaninglessNumbers() -> [Int] {
        return (0..<20).map { _ in Int.random(in: 0...999) }
    }
}
