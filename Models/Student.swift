import Foundation

enum OrderStatus {
    case inProgress
    case notStarted
    case closed
}

struct Student {
    let name: String
    let lastAppointment: String
    let age: Int
    let notes: String
    let status: StudentStatus
}

enum StudentStatus {
    case notpaid
    case paid

    var text: String {
        switch self {
        case .notpaid:
            return "Not Paid"
        case .paid:
            return "Paid"
        }
    }
}

extension Student {
    static var examples: [Student] {
        [
            Student(
                name: "Adam",
                lastAppointment: "November 12, 2020",
                age: 21,
                notes: "Lesson 1: Introduction",
                status: .notpaid
            ),
            Student(
                name: "Michael",
                lastAppointment: "October 12, 2020",
                age: 23,
                notes: "Lesson 2: Piano Fundamentals",
                status: .paid
            ),
            Student(
                name: "Chase",
                lastAppointment: "January 2, 2020",
                age: 15,
                notes: "Lesson 2: Piano Fundamentals",
                status: .paid
            )
        ]
    }
    static var example: Student {
        Student(
            name: "Adam",
            lastAppointment: "November 12, 2020",
            age: 21,
            notes: "lesson 2: Piano Fundamentals",
            status: .notpaid
        )
    }
}

