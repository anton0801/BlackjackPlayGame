import SwiftUI
import SpriteKit

struct BlackjackGameView: View {
    
    @Environment(\.presentationMode) var presMode
    
    @State var blackjackScene: BlackjackGameScene!
    
    @State var rulesInfoViewVisible = false
    
    @State var alertVisible = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
    var body: some View {
        ZStack {
            VStack {
                if let blackjackScene = blackjackScene {
                    SpriteView(scene: blackjackScene)
                        .ignoresSafeArea()
                }
            }
            
            if rulesInfoViewVisible {
                rulesInfoView
            }
        }
        .onAppear {
            blackjackScene = BlackjackGameScene()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("open_info"))) { _ in
            withAnimation(.easeInOut) {
                rulesInfoViewVisible = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("restart_btn"))) { _ in
            blackjackScene = blackjackScene.restartScene()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("show_alert"))) { notification in
            if let info = notification.userInfo as? [String: Any],
                let title = info["title"] as? String,
                let message = info["message"] as? String {
                self.alertTitle = title
                self.alertMessage = message
                self.alertVisible = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("go_menu"))) { _ in
            presMode.wrappedValue.dismiss()
        }
        .alert(isPresented: $alertVisible) {
            Alert(title: Text(alertTitle), message: Text(alertMessage))
        }
    }
    
    private var rulesInfoView: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("""
    How to play Blackjack

    Blackjack Rules
    Blackjack is a classic casino card game where one or more players compete against the dealer. The cards are drawn in succession and the values of their hands are compared. The game is played with 3 player slots. The highest hand, not exceeding 21, wins. Players aim to beat the dealer in one of the following ways:
    - Get Blackjack – 21 points from the first 2 cards. Blackjack always beats any other hand with a value of 21.
    - Get a higher point value than the dealer, but not exceeding 21.
    - Let the dealer get additional cards, until 21 points аre exceeded (the dealer is 'bust'). The dealer will stand on 17 or higher, and hit to 16.
    A new set of 8 standard decks of 52 cards is used at the beginning of each round.
    All winning bets are returned to the player.

    Card Values & Hands:
    - Face Cards (K,Q,J) are counted as 10
    - 2 to 10 are counted as the value of the card
    - Ace may be used as either 1 or 11
    - No particular significance is given to any of the 4 suits
    - Hands of equal value to the dealer's are a PUSH, and your bet is returned.
    - If your hand is 22 or higher, you bust regardless of the value of the dealer's hand. You automatically stand when your hand has a value of 21.

    Game Controls
    Click on the chip value you wish to play, then click on the betting area to place or increase a bet. You can place a bet on any of the active betting fields.

    Starting Buttons & Actions
    PLAY - after placing a bet, use this button to start the game. Once you click on it, cards will be drawn from the deck.
    x2 DOUBLE - double your bet, before any cards are drawn
    CLEAR - remove all bets from the table

    First Dealing Buttons & Actions:
    HIT - Take another card from the dealer
    STAND - Do not take any more cards from the dealer
    x2 DOUBLE - Doubles the current bet and adds an additional card. No further cards may be requested from the dealer after doubling down - you are dealt one extra card and then your hand automatically stands. You can double down after the first two cards (except after splitting two Aces). The double down bet is equal to the initial bet. Double Down is allowed only on hands with a value of 9, 10 or 11.
    SPLIT - If the player is dealt a pair, then a SPLIT is an option to separate the two cards into two new hands. The second hand requires an additional bet at the same stake as the first, and the two new hands are each played in turn. Оnly one split per hand is allowed. You can hit multiple times for all split hands, except Aces.
    For split Aces, you can hit once only. If you have a split Ace and a card with a face value of 10, this is not considered Blackjack, but a regular 21.
    It is possible to double-down on a split hand.
    """)
                    .font(.custom("LilitaOne", size: 16))
                    .foregroundColor(.white)
                    .padding()
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.easeInOut) {
                            rulesInfoViewVisible = false
                        }
                    } label: {
                        Image("close")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                Spacer()
            }
        }
        .background(
            Rectangle()
                .fill(.black)
                .opacity(0.7)
                .ignoresSafeArea()
        )
    }
    
}

#Preview {
    BlackjackGameView()
}
