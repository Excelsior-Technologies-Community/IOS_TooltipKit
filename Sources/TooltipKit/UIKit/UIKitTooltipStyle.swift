import UIKit
public struct UIKitTooltipStyle {

    public enum ArrowPosition {
        case top, bottom, left, right
    }
    public var showsArrow: Bool = true
    public var arrowSize: CGSize = CGSize(width: 22, height: 12)

    public var backgroundColor: UIColor = .systemBlue
    public var textColor: UIColor = .white
    public var cornerRadius: CGFloat = 12

    public var arrowPosition: ArrowPosition = .top
    public var arrowSize: CGSize = CGSize(width: 20, height: 12)
    public var usesAbsolutePositioning: Bool = false

    // ✅ NEW: control arrow visibility
    public var showsArrow: Bool = true

    public var offsetX: CGFloat = 0
    public var offsetY: CGFloat = 0

    public init() {}
}

