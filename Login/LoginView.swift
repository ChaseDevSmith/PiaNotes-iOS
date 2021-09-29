import SwiftUI
//import AVKit
//import AVFoundation
import Firebase
struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    let coordinator: LoginCoordinator

    @State var shouldNavigate = false
    @State var shouldNavigatesign = false
    // TO DO ACCESS PUBLISHED VARIABLES FOR LOGIN INFO
    
    // state vars for text fields
    @State private var username: String = ""
    @State private var isEditing = false
    @State private var password: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("LOGIN PAGE")
                    .font(.title)
                Form {
                    if #available(iOS 15.0, *) {
                        TextField(text: $username, prompt: Text("Email")){
                            Text("Email")
                        }
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        SecureField(text: $password, prompt: Text("Password")){
                            Text("Password").submitLabel(.join)
                        }
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        PianoButton(
                            action: {
                                viewModel.login()
                            }, label: "Submit")
                    } else {
                        // Fallback on earlier versions
                    }
                }
                viewModel.loginErrorMessage($viewModel.errorMessage.wrappedValue, fontSize: 16)
                    .padding(.bottom, 16)
                Spacer()
                Spacer()
                Spacer()

                PianoButton(action: {
                    viewModel.shouldNavigateToSignUp.toggle()
                } , label: "New User? Sign Up Here")
                    .frame(height: 12.0)
                    .padding()

                NavigationLink(
                    destination: self.coordinator.view(for: .mainTabView),
                    isActive: $viewModel.shouldNavigateToMainPage,
                    label: { EmptyView() }
                )

                NavigationLink(
                    destination: self.coordinator.view(for: .signup),
                    isActive: $viewModel.shouldNavigateToSignUp,
                    label: { EmptyView() }
                )
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LoginViewModel()
        let coordinator = LoginCoordinator(viewModel: viewModel)
        return LoginView(viewModel: viewModel, coordinator: coordinator)
    }
}
//class ViewController: UIViewController {
//    var player: AVPlayer?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print ("hey!!!!!!!")
//        playBackgroundVideo()
//    }
//
//    func playBackgroundVideo(){
//        let path = Bundle.main.path(forResource: "Andre Watts", ofType: ".mp4")
//        player = AVPlayer(url: URL(fileURLWithPath: path!))
//        player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.view.frame
//        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        self.view.layer.insertSublayer(playerLayer, at: 0)
//        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name:
//            NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
//        player!.seek(to: CMTime.zero)
//        player!.play()
//        self.player?.isMuted = true
//        print("video playing dfunction being called")
//    }
//    @objc func playerItemDidReachEnd(){
//        player!.seek(to: CMTime.zero)
//    }
//}
