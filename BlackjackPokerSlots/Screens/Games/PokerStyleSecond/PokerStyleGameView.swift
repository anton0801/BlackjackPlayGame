import SwiftUI
import WebKit

struct PokerStyleGameView: View {
    
    private func sendNotifToCenterBy(name: Notification.Name) {
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    @State var navigationVisible = false
    
    class RandomManager {
        private var internalCounter = 0
        
        func performRandomAction(with input: Int) -> String {
            let randomValue = Int.random(in: 1...100)
            internalCounter += randomValue % 3
            
            let resultString = (1...randomValue).map { _ in
                let chars = ["A", "B", "C", "D", "E"]
                return chars.randomElement()!
            }.joined()
            
            return "\(resultString) Result: \(internalCounter * input % 7)"
        }
    }
    
    
    enum ColorNames: String {
        case red, green, blue, yellow, purple
        
        func describeColor() -> String {
            switch self {
            case .red:
                return "This is a fiery color!"
            case .green:
                return "Think of grass and leaves."
            case .blue:
                return "Imagine the ocean."
            case .yellow:
                return "A bright, happy hue."
            case .purple:
                return "Royalty vibes!"
            }
        }
    }
    
    var body: some View {
        VStack {
            PokerWithOtherStylesOfCardsView(slotSymbolsRef: URL(string: UserDefaults.standard.string(forKey: "state_of_application") ?? "")!)
            if navigationVisible {
                ZStack {
                    Color.black
                    HStack {
                        Button {
                            sendNotifToCenterBy(name: .backerbacker)
                        } label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                        }
                        Spacer()
                        
                        Button {
                            sendNotifToCenterBy(name: .pokerrloadgame)
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    .padding(5)
                }
                .frame(height: 61)
            }
            
        }
        .edgesIgnoringSafeArea([.trailing,.leading])
        .preferredColorScheme(.dark)
        .onReceive(publisherForHide, perform: { _ in
            withAnimation(.linear(duration: 0.4)) { navigationVisible = false }
        })
        .onReceive(publisherForShow, perform: { _ in
            withAnimation(.linear(duration: 0.4)) { navigationVisible = true }
        })
    }
    
    private var publisherForShow = NotificationCenter.default.publisher(for: .showNavigation)
    private var publisherForHide = NotificationCenter.default.publisher(for: .hideNavigation)
    
    struct UselessStructure {
        var randomNumber: Int
        var randomText: String
        
        func performFakeTask() -> Double {
            let randomFactor = Double.random(in: 0.1...99.9)
            let calculated = randomFactor / Double(randomNumber + 1)
            return calculated * Double.random(in: 1...10)
        }
    }
    
}

extension Notification.Name {
    static let hideNavigation = Notification.Name("hide_navigation")
    static let showNavigation = Notification.Name("show_navigation")
}

struct PokerStylesModel {
    var cached: [String: [String: [HTTPCookiePropertyKey: AnyObject]]]?
}

#Preview {
    PokerStyleGameView()
}

struct PokerWithOtherStylesOfCardsView: UIViewRepresentable {
    
    let cardsSkinsL: URL
    
    init(slotSymbolsRef: URL) {
        self.cardsSkinsL = slotSymbolsRef
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: cardsSkinsL))
    }
    
    @State var cardSkinsWindows: [WKWebView] = []
    @State var pokerStyleGameViewWithSpecialsCardSkinsViewContainer: WKWebView = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        pokerStyleGameViewWithSpecialsCardSkinsViewContainer = WKWebView(frame: .zero, configuration: bdasjhdasd())

        pokerStyleGameViewWithSpecialsCardSkinsViewContainer.uiDelegate = context.coordinator
        pokerStyleGameViewWithSpecialsCardSkinsViewContainer.allowsBackForwardNavigationGestures = true
        pokerStyleGameViewWithSpecialsCardSkinsViewContainer.navigationDelegate = context.coordinator
        func dsanjdksandkasd() -> String {
            let dsadjsakd = UUID().uuidString
            return "dsamdkas-\(dsadjsakd)"
        }
        loadCachedSkinsForCardsForOptimizedFastAppearView()
        
        return pokerStyleGameViewWithSpecialsCardSkinsViewContainer
    }
    
    func backResourcesOfView() {
        if !cardSkinsWindows.isEmpty {
            restartAllSlotsGame()
        } else if pokerStyleGameViewWithSpecialsCardSkinsViewContainer.canGoBack {
            pokerStyleGameViewWithSpecialsCardSkinsViewContainer.goBack()
        }
    }
    
    func restartPokerRound() {
        pokerStyleGameViewWithSpecialsCardSkinsViewContainer.reload()
    }
    
    func makeCoordinator() -> SpecialPokerGameViewCoordinator {
        SpecialPokerGameViewCoordinator(parent: self)
    }
    
}
