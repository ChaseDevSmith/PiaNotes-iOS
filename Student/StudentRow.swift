import SwiftUI

struct StudentRow: View {
    let student: Student

    var statusText: String {
        switch student.status {
        case .paid: return "Paid"
        case .notpaid: return "Not Paid"
        default: return ""
        }
    }

    var statusFontColor: Color {
        switch student.status {
        case .paid: return .green
        case .notpaid: return .red
        default: return .white
        }
    }

    var statusBackgroundColor: Color {
        switch student.status {
        case .paid: return .green.opacity(0.2)
        case .notpaid: return .red.opacity(0.2)
        default: return .white
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top){
                Text(student.name)
                    .foregroundColor(.black)
                    .font(.system(size: 16))

                Spacer()
                Text(statusText)
                    .font(.system(size: 11))
                    .padding(3)
                    .foregroundColor(statusFontColor)
                    .background(statusBackgroundColor)
            }
            HStack {
                Text("Lesson: " + student.notes)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                Spacer()
            }
            Divider()
            HStack(spacing: 12) {
                HStack {
                    Text("age: " + String(student.age))
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Last Appointment: " + student.lastAppointment)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color.white)
        .border(Color.gray)
    }
}

struct StudentRow_Previews: PreviewProvider {
    static var previews: some View {
        StudentRow(
            student: Student.example
        ).padding()
    }
}
