import SwiftUI



extension Notification.Name {
    static let backerbacker = Notification.Name("backerbacker")
    static let pokerrloadgame = Notification.Name("pokerrloadgame")
}


struct WSB: View {
    @State private var isSoundOn = true
    @State private var isMusicOn = true
    
    var body: some View {
        ZStack {
            Image("fon4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            VStack{
                HStack(spacing:0 ){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image("menu")
                            .resizable()
                            .frame(width: 70, height: 70)
                    })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image("infa")
                            .resizable()
                            .frame(width: 70, height: 70)
                    })
                    Spacer()
                        .frame(width: 400)
                    Image("coins1")
                        .resizable()
                        .frame(width: 100, height: 35)
                }
                ZStack{
                    Image("WSB")
                        .resizable()
                        .frame(width: 500, height: 250)
                }
            }
        }
    }
}

#Preview {
    WSB()
}




