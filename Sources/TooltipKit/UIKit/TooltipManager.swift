import UIKit

public final class TooltipManager {

    private weak var containerView: UIView?
    private var bubbleView: UIView?
    private var arrowView: UIView?

    public init(containerView: UIView) {
        self.containerView = containerView
    }

    public func show(
        text: String,
        from targetView: UIView,
        style: UIKitTooltipStyle
    ) {
        hide()

        guard let container = containerView else { return }

        // 1️⃣ Convert target frame
        let targetFrame = targetView.convert(
            targetView.bounds,
            to: container
        )

        // 2️⃣ Create bubble
        let bubble = TooltipView(
            text: text,
            style: style,
            onDismiss: { [weak self] in
                self?.hide()
            }
        )

        let bubbleSize = CGSize(width: 240, height: 90)
        bubble.frame.size = bubbleSize

        // 3️⃣ Calculate bubble position FIRST
        var bubbleX = targetFrame.midX - bubbleSize.width / 2
        var bubbleY = targetFrame.midY - bubbleSize.height / 2

        switch style.arrowPosition {
        case .top:
            bubbleY = targetFrame.maxY + style.arrowSize.height
        case .bottom:
            bubbleY = targetFrame.minY - bubbleSize.height - style.arrowSize.height
        case .left:
            bubbleX = targetFrame.maxX + style.arrowSize.height
        case .right:
            bubbleX = targetFrame.minX - bubbleSize.width - style.arrowSize.height
        }

        bubble.frame.origin = CGPoint(
            x: bubbleX + style.offsetX,
            y: bubbleY + style.offsetY
        )

        // ✅ ADD BUBBLE FIRST
        container.addSubview(bubble)
        self.bubbleView = bubble

        // 4️⃣ Create arrow AFTER bubble exists
        guard style.showsArrow else { return }

        let arrow = TooltipArrowView(
            position: style.arrowPosition,
            color: style.backgroundColor
        )

        arrow.frame.size = style.arrowSize

        // 5️⃣ Position arrow RELATIVE TO BUBBLE
        switch style.arrowPosition {

        case .top:
            arrow.frame.origin = CGPoint(
                x: bubble.frame.midX - style.arrowSize.width / 2,
                y: bubble.frame.minY - style.arrowSize.height
            )

        case .bottom:
            arrow.frame.origin = CGPoint(
                x: bubble.frame.midX - style.arrowSize.width / 2,
                y: bubble.frame.maxY
            )

        case .left:
            arrow.frame.origin = CGPoint(
                x: bubble.frame.minX - style.arrowSize.height,
                y: bubble.frame.midY - style.arrowSize.width / 2
            )

        case .right:
            arrow.frame.origin = CGPoint(
                x: bubble.frame.maxX,
                y: bubble.frame.midY - style.arrowSize.width / 2
            )
        }

        // ✅ ADD ARROW AFTER POSITIONING
        container.addSubview(arrow)
        container.bringSubviewToFront(arrow)

        self.arrowView = arrow
    }



    public func hide() {
        bubbleView?.removeFromSuperview()
        arrowView?.removeFromSuperview()
        bubbleView = nil
        arrowView = nil
    }
}
