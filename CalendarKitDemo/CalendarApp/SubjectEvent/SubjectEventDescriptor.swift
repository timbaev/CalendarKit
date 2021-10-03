import UIKit
import CalendarKit

final class SubjectEventDescriptor: EventDescriptor {

    // MARK: - Instance Properties

    var startDate: Date
    var endDate: Date
    var editedEvent: EventDescriptor?

    let isAllDay: Bool
    let text: String
    let attributedText: NSAttributedString?
    let lineBreakMode: NSLineBreakMode?
    let font: UIFont
    let color: UIColor
    let textColor: UIColor
    let backgroundColor: UIColor

    // MARK: - Initializers

    init(startDate: Date, subjectName: String, subjectColor: UIColor, editedEvent: EventDescriptor? = nil) {
        self.startDate = startDate
        self.endDate = startDate.addingTimeInterval(60 * 40)
        self.editedEvent = editedEvent
        self.isAllDay = false
        self.text = subjectName
        self.attributedText = nil
        self.lineBreakMode = nil
        self.font = .systemFont(ofSize: 12, weight: .bold)
        self.color = subjectColor
        self.textColor = .black
        self.backgroundColor = .white
    }

    // MARK: - EventDescriptor

    func makeEditable() -> SubjectEventDescriptor {
        SubjectEventDescriptor(startDate: startDate, subjectName: text, subjectColor: color, editedEvent: self)
    }

    func commitEditing() {
        guard let editedEvent = editedEvent else {
            return
        }

        editedEvent.startDate = startDate
        editedEvent.endDate = endDate
    }
}
