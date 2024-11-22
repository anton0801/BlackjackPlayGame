import SwiftUI

struct ContentView: View {
    
    @State private var isSoundOn = UserDefaults.standard.bool(forKey: "isSoundsOn")
    @State private var pokerBought = UserDefaults.standard.bool(forKey: "pokerBought")
    @State private var slotsBought = UserDefaults.standard.bool(forKey: "slotsBought")
    
    @State private var settingsVisible = false
    
    @State var balance = 0
    
    @State var pokerBoughtErrorAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("fon2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    ZStack{
                        Image("blockUpper")
                            .resizable()
                            .frame(width: 700, height: 90)
                        HStack{
                            Image("yourlevel")
                                .resizable()
                                .frame(width: 50, height: 50)
                            ZStack {
                                Image("level")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                                Text("1")
                                    .font(.custom("LilitaOne", size: 24))
                                    .foregroundColor(.white)
                            }
                            ZStack(alignment: .leading) {
                                Image("progress")
                                    .resizable()
                                    .frame(width: 200, height: 20)
                                Image("completed")
                                    .resizable()
                                    .frame(width: CGFloat(((Double(balance) / 1000.0) / 200.0)) * 200.0, height: 20)
                            }
                            ZStack {
                                Image("coins1")
                                    .resizable()
                                    .frame(width: 150, height: 50)
                                
                                Text("\(balance)")
                                    .font(.custom("LilitaOne", size: 14))
                                    .foregroundColor(.white)
                                    .offset(x: -20)
                            }
                            
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    settingsVisible = true
                                }
                            }, label: {
                                VStack(spacing: 0){
                                    Image("settings")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Image("settingsText")
                                        .resizable()
                                        .frame(width: 50, height: 15)
                                }
                            })
                        }
                    }
                    HStack{
                        Spacer()
                        VStack{
                            Image("bjGame")
                                .resizable()
                                .frame(width: 200, height: 200)
                            NavigationLink(destination: BlackjackGameView()
                                .navigationBarBackButtonHidden()) {
                                    Image("play")
                                        .resizable()
                                        .frame(width: 200, height: 100)
                                }
                        }
                        Spacer()
                        VStack{
                            ZStack{
                                Image("sevenslot")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                
                                if !slotsBought {
                                    RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                        .fill(.black)
                                        .opacity(0.6)
                                    
                                    VStack {
                                        Text("CLOSED")
                                            .font(.custom("Bhel Puri", size: 24))
                                            .foregroundColor(Color.init(red: 1, green: 214/255, blue: 0))
                                        
                                        Text("BUY FOR 15 000 TO OPEN")
                                            .font(.custom("Bhel Puri", size: 16))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                        
                                        Text("FOR BUY PULSE PLAY")
                                            .font(.custom("Bhel Puri", size: 16))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                            .padding(.top)
                                        
                                    }
                                }
                            }
                            .frame(width: 200, height: 200)
                            
                            Button(action: {
                                if slotsBought {
                                    
                                } else {
                                    if balance >= 15000 {
                                        slotsBought = true
                                        UserDefaults.standard.set(true, forKey: "slotsBought")
                                        balance -= 15000
                                    } else {
                                        pokerBoughtErrorAlert = true
                                    }
                                }
                            }, label: {
                                Image("play")
                                    .resizable()
                                    .frame(width: 200, height: 100)
                            })
//                            NavigationLink(destination: SevenSlotsGameView()
//                                .navigationBarBackButtonHidden()) {
//                                    Image("play")
//                                        .resizable()
//                                        .frame(width: 200, height: 100)
//                                }
                        }
                        Spacer()
                        VStack {
                            ZStack{
                                Image("poker")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                
                                if !pokerBought {
                                    RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                        .fill(.black)
                                        .opacity(0.6)
                                    
                                    VStack {
                                        Text("CLOSED")
                                            .font(.custom("Bhel Puri", size: 24))
                                            .foregroundColor(Color.init(red: 1, green: 214/255, blue: 0))
                                        
                                        Text("BUY FOR 20 000 TO OPEN")
                                            .font(.custom("Bhel Puri", size: 16))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                        
                                        Text("FOR BUY PULSE PLAY")
                                            .font(.custom("Bhel Puri", size: 16))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                            .padding(.top)
                                        
                                    }
                                }
                            }
                            .frame(width: 200, height: 200)
                            
                            Button(action: {
                                if pokerBought {
                                    
                                } else {
                                    if balance >= 20000 {
                                        pokerBought = true
                                        UserDefaults.standard.set(true, forKey: "pokerBought")
                                        balance -= 20000
                                    } else {
                                        pokerBoughtErrorAlert = true
                                    }
                                }
                            }, label: {
                                Image("play")
                                    .resizable()
                                    .frame(width: 200, height: 100)
                            })
                        }
                        Spacer()
                    }
                }
                .onAppear {
                    balance = UserDefaults.standard.integer(forKey: "userBalance")
                    if balance == 0 {
                        balance = 1000
                        UserDefaults.standard.set(1000, forKey: "userBalance")
                    }
                }
                .alert(isPresented: $pokerBoughtErrorAlert) {
                    Alert(title: Text("Buy error!"), message: Text("Not enough credits on your game balance!"))
                }
                
                if settingsVisible {
                    settings
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var cardBackground = UserDefaults.standard.string(forKey: "card_game_background") ?? "cards_game_bg"
    private var allBackgroundsOfGames = [
        "cards_game_bg",
        "cards_game_bg2",
        "cards_game_bg3",
        "cards_game_bg4"
    ]
    @State private var currentIndexBackground = 0
    
    private var settings: some View {
        ZStack {
            VStack {
                Text("SOUND")
                    .font(.custom("Bhel Puri", size: 24))
                    .foregroundColor(Color.init(red: 1, green: 214/255, blue: 0))
                
                HStack {
                    Button {
                        withAnimation(.linear) {
                            isSoundOn = !isSoundOn
                        }
                    } label: {
                        Image("arrow_back")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    
                    Text(isSoundOn ? "ON" : "OFF")
                        .font(.custom("Bhel Puri", size: 26))
                        .foregroundColor(.white)
                    
                    Button {
                        withAnimation(.linear) {
                            isSoundOn = !isSoundOn
                        }
                    } label: {
                        Image("arrow_forward")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                }
                
                Text("BACKGROUND")
                    .font(.custom("Bhel Puri", size: 24))
                    .foregroundColor(Color.init(red: 1, green: 214/255, blue: 0))
                
                HStack {
                    Button {
                        withAnimation(.easeInOut) {
                            if currentIndexBackground > 0 {
                                currentIndexBackground -= 1
                            } else {
                                currentIndexBackground = allBackgroundsOfGames.count - 1
                            }
                        }
                    } label: {
                        Image("arrow_back")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    
                    Image(allBackgroundsOfGames[currentIndexBackground])
                        .resizable()
                        .frame(width: 50, height: 30)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            if currentIndexBackground < allBackgroundsOfGames.count - 1 {
                                currentIndexBackground += 1
                            } else {
                                currentIndexBackground = 0
                            }
                        }
                    } label: {
                        Image("arrow_forward")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                }
            }
            .background(
                Image("settings_bg")
                    .resizable()
                    .frame(width: 250, height: 250)
            )
            .onAppear {
                currentIndexBackground = allBackgroundsOfGames.firstIndex(of: cardBackground) ?? 0
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.easeInOut) {
                            settingsVisible = false
                        }
                    } label: {
                        Image("close")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding(.top)
            
            Button {
                UserDefaults.standard.set(allBackgroundsOfGames[currentIndexBackground], forKey: "card_game_background")
                UserDefaults.standard.set(isSoundOn, forKey: "isSoundsOn")
            } label: {
                Image("save_btn")
                    .resizable()
                    .frame(width: 200, height: 50)
            }
            .offset(y: 125)
        }
        .frame(width: 250, height: 250)
        .background(
            Rectangle()
                .fill(.black)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 20)
                .opacity(0.6)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    ContentView()
}
