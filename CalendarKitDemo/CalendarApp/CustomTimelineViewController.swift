import UIKit
import CallKit
import CalendarKit

final class CustomTimelineViewController: UIViewController {

    public weak var dataSource: EventDataSource?

    private func setupTimelineController() -> TimelineContainerController<EventView> {
        let viewController = TimelineContainerController<EventView>()

        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        viewController.didMove(toParent: self)

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let timelineController = setupTimelineController()
        let container = timelineController.container
        let timeline = timelineController.timeline

        var style = TimelineStyle()
        var separatorStyle = SeparatorStyle()

        separatorStyle.color = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
        separatorStyle.leadingInset = 20.0
        separatorStyle.trailingInset = 8.0
        separatorStyle.lineStyle = .dashed
        separatorStyle.lineLength = 1.0

        style.separatorStyle = separatorStyle
        style.timeColor = UIColor(red: 0.1, green: 0.0, blue: 0.2, alpha: 1.0)
        style.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        style.font = .systemFont(ofSize: 12.0, weight: .regular)
        style.leadingInset = 70.0
        style.isNowLineHidden = true
        style.dateStyle = .twentyFourHour

        timeline.updateStyle(style)
        container.backgroundColor = style.backgroundColor

        timeline.delegate = self
        timeline.calendar = .autoupdatingCurrent
        timeline.date = Date().dateOnly(calendar: .autoupdatingCurrent)

        let date = timeline.date.dateOnly(calendar: .autoupdatingCurrent)
        let events = eventsForDate(date)
        let end = Calendar.autoupdatingCurrent.date(byAdding: .day, value: 1, to: date)!
        let day = date ... end
        let validEvents = events.filter{ $0.datePeriod.overlaps(day) }

        timeline.layoutAttributes = validEvents.map(EventLayoutAttributes.init)
    }
}

// MARK: - TimelineViewDelegate

extension CustomTimelineViewController: TimelineViewDelegate {

    func timelineView<EventView: EventDescriptorHolder>(
        _ timelineView: TimelineView<EventView>,
        didTapAt date: Date
    ) {
        print("timelineViewDidTapAt(date: \(date))")
    }

    func timelineView<EventView: EventDescriptorHolder>(
        _ timelineView: TimelineView<EventView>,
        didLongPressAt date: Date
    ) {
        print("timelineViewDidLongPressAt(date: \(date))")
    }

    func timelineView<EventView: EventDescriptorHolder>(
        _ timelineView: TimelineView<EventView>,
        didTap event: EventView
    ) {
        print("timelineViewDidTap(event: \(String(describing: event.descriptor)))")
    }

    func timelineView<EventView: EventDescriptorHolder>(
        _ timelineView: TimelineView<EventView>,
        didLongPress event: EventView
    ) {
        print("timelineViewDidLongPress(event: \(String(describing: event.descriptor)))")
    }
}

// MARK: - EventDataSource

extension CustomTimelineViewController: EventDataSource {

    // MARK: - Instance Methods

    func eventsForDate(_ date: Date) -> [EventDescriptor] {
        let event = Event()

        event.startDate = date.addingTimeInterval(60 * 60 * 16)
        event.endDate = date.addingTimeInterval(60 * 60 * 17)
        event.text = "Английский язык - 11 класс"

        return [event]
    }
}
