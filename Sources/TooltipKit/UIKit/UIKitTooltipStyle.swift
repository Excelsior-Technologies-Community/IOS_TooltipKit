import UIKit

public struct UIKitTooltipStyle {

    // MARK: - Arrow Position
    public enum ArrowPosition {
        case top
        case bottom
        case left
        case right
    }

    // MARK: - Appearance
    public var backgroundColor: UIColor = .systemBlue
    public var textColor: UIColor = .white
    public var cornerRadius: CGFloat = 12

    // MARK: - Arrow Configuration
    public var showsArrow: Bool = true
    public var arrowPosition: ArrowPosition = .top
    public var arrowSize: CGSize = CGSize(width: 22, height: 12)

    // MARK: - Positioning
    /// When `true`, tooltip ignores arrowPosition anchoring
    /// and uses pure X/Y offsets relative to the target view.
    public var usesAbsolutePositioning: Bool = false
    public var offsetX: CGFloat = 0
    public var offsetY: CGFloat = 0

    // MARK: - Init
    public init() {}
}
