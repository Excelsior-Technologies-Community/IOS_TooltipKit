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

        let targetFrame = targetView.convert(
            targetView.bounds,
            to: container
        )

        let bubble = TooltipView(
            text: text,
            style: style,
            onDismiss: { [weak self] in
                self?.hide()
            }
        )

        container.addSubview(bubble)

        var arrow: TooltipArrowView?

        if style.showsArrow {
            let arrowView = TooltipArrowView(
                position: style.arrowPosition,
                color: style.backgroundColor
            )
            container.addSubview(arrowView)
            arrowView.frame.size = style.arrowSize
            arrow = arrowView
        }

        let bubbleSize = CGSize(width: 220, height: 90)
        bubble.frame.size = bubbleSize

        var x = targetFrame.midX - bubbleSize.width / 2
        var y = targetFrame.midY

        switch style.arrowPosition {
        case .top:
            y = targetFrame.maxY + style.arrowSize.height
        case .bottom:
            y = targetFrame.minY - bubbleSize.height - style.arrowSize.height
        case .left:
            x = targetFrame.maxX + style.arrowSize.width
            y = targetFrame.midY - bubbleSize.height / 2
        case .right:
            x = targetFrame.minX - bubbleSize.width - style.arrowSize.width
            y = targetFrame.midY - bubbleSize.height / 2
        }

        bubble.frame.origin = CGPoint(
            x: x + style.offsetX,
            y: y + style.offsetY
        )

        arrow?.center = CGPoint(
            x: targetFrame.midX,
            y: targetFrame.midY
        )

        bubbleView = bubble
        arrowView = arrow
    }


    public func hide() {
        bubbleView?.removeFromSuperview()
        arrowView?.removeFromSuperview()
        bubbleView = nil
        arrowView = nil
    }
}
