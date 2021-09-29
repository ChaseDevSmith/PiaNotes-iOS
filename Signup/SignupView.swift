import SwiftUI
import Firebase
import FirebaseAuth
struct SignupView: View {
    @ObservedObject var viewModel: SignupViewModel
    let coordinator: SignupCoordinator
    
    var body: some View {
        VStack{
            Text("Signup Page")
            Form {
                TextField("First Name", text: $viewModel.firstName)
                
                TextField("Last Name", text: $viewModel.lastName)
                
                TextField("Email", text: $viewModel.email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                SecureField("Password - Minimum 8 characters, 1 Uppercase, 1 Number", text: $viewModel.password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                SecureField("Confirm Password", text: $viewModel.confirmedPassword)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                PianoButton(action: {
                    viewModel.signUp()
                }, label: "SignUp")
            }

            viewModel.loginErrorMessage($viewModel.errorMessage.wrappedValue, fontSize: 16)
                .padding(.bottom, 16)
            
            NavigationLink(
                destination: self.coordinator.view(for: .mainTabView),
                isActive: $viewModel.shouldNavigateToMainTabView,
                label: { EmptyView() }
            )
            Spacer()
        }
        .padding()
        Spacer()
    }
    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            let viewModel = SignupViewModel()
            let coordinator = SignupCoordinator(viewModel: viewModel)
            return SignupView(viewModel: viewModel, coordinator: coordinator)
        }
    }
}
