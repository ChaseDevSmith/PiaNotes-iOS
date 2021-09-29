import SwiftUI
import Combine



struct MainTabView: View {
    @ObservedObject var viewModel: MainTabViewModel
    let coordinator: MainTabCoordinator
    private let logout = CurrentValueSubject<NavigationButtonOption?, Never>(nil)
    var students: [Student] = Student.examples

    var body: some View {
        VStack{
            PianoButton(action: {
                logout.send(.logout)
                
            }, label: "logout")

            ScrollView {
                VStack {
                    ForEach(students, id: \.name) { student in
                        StudentRow(student: student)
                    }
                }
                .padding(.horizontal, 28)
                .padding(.vertical)
            }
                .onReceive(logout) { value in
            if value == .logout {
                coordinator.send(.confirmedLogout)
            }
        }
        }
    }

}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MainTabViewModel(dismissLogin: PassthroughSubject<Void, Never>())
        let coordinator = MainTabCoordinator(viewModel: viewModel)
        MainTabView(viewModel: viewModel, coordinator: coordinator)
    }
}
