import UIKit

public protocol EventDescriptorHolder: UIView {

    var descriptor: EventDescriptor? { get }

    func updateWithDescriptor(event: EventDescriptor)
}
