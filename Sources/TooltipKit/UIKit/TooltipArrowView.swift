import UIKit

final class TooltipArrowView: UIView {

    let position: UIKitTooltipStyle.ArrowPosition
    let color: UIColor

    init(position: UIKitTooltipStyle.ArrowPosition, color: UIColor) {
        self.position = position
        self.color = color
        super.init(frame: .zero)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) { nil }

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()

        switch position {
        case .top:
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        case .bottom:
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        case .left:
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        case .right:
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }

        path.close()
        color.setFill()
        path.fill()
    }
}
