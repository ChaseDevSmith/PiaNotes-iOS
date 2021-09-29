import SwiftUI
import AVKit
import AVFoundation


struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    let coordinator: HomeCoordinator
    
    @State var shouldNavigateLogin = false
    @State var shouldNavigateSignUp = false
    @State var player = AVPlayer()

    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                ZStack {
                    VideoPlayer(player: player)
                        .edgesIgnoringSafeArea(.all)
                        .onAppear {
                            if let pianoUrl = viewModel.url {
                                player = AVPlayer(url: pianoUrl)
                            }
                        }
                }

                HStack(alignment: .center) {
                    Button(action:{
                        self.shouldNavigateLogin.toggle()
                    }, label:{
                        Text("Login")
                    })
                        .frame(height: 20.0)
                        .foregroundColor(.blue)
                        .padding(.leading, 20)

                    Spacer()

                    Button(action:{
                        self.shouldNavigateSignUp.toggle()
                    }, label:{
                        Text("Signup")
                    })
                        .frame(height: 20.0)
                        .foregroundColor(.blue)
                        .padding(.trailing, 20)
                }
                .frame(height: 50)
                .background(Color.white)

                NavigationLink(
                    destination:
                        self.coordinator.view(for: .signup),
                    isActive: $shouldNavigateSignUp,
                    label: {EmptyView()}
                )
                
                NavigationLink(
                    destination:
                        self.coordinator
                        .view(for: .login),
                    isActive:
                        $shouldNavigateLogin,
                    label: { EmptyView() }
                )
            }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel()
        let coordinator =
        HomeCoordinator(viewModel: viewModel)
        return HomeView(viewModel:
                            viewModel, coordinator:
                            coordinator)
        
    }
}
