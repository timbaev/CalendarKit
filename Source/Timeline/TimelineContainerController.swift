import UIKit

public final class TimelineContainerController<EventView: EventDescriptorHolder>: UIViewController {
  /// Content Offset to be set once the view size has been calculated
  public var pendingContentOffset: CGPoint?
  
  public lazy var timeline = TimelineView<EventView>()
  public lazy var container: TimelineContainer<EventView> = {
    let view = TimelineContainer<EventView>(timeline)
    view.addSubview(timeline)
    return view
  }()
  
  public override func loadView() {
    view = container
  }
  
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    container.contentSize = timeline.frame.size
    if let newOffset = pendingContentOffset {
      // Apply new offset only once the size has been determined
      if view.bounds != .zero {
        container.setContentOffset(newOffset, animated: false)
        container.setNeedsLayout()
        pendingContentOffset = nil
      }
    }
  }
}
