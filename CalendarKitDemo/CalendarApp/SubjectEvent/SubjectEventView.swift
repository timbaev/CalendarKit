import UIKit
import CalendarKit

final class SubjectEventView: UIView {

    // MARK: - Instance Properties

    private let colorView = UIView()
    private let nameLabel = UILabel()

    // MARK: -

    private(set) var descriptor: EventDescriptor?

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        backgroundColor = .white

        setupColorView()
        setupNameLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Instance Methods

    private func setupColorView() {
        addSubview(colorView)

        colorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: topAnchor),
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 5.0)
        ])
    }

    private func setupNameLabel() {
        addSubview(nameLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            nameLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 20.0),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8.0),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0)
        ])
    }
}

// MARK: - EventDescriptorHolder

extension SubjectEventView: EventDescriptorHolder {

    // MARK: - Instance Methods

    func updateWithDescriptor(event: EventDescriptor) {
        descriptor = event

        colorView.backgroundColor = event.color
        nameLabel.text = event.text
    }
}
