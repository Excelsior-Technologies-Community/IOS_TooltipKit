//
//  Created by Noman belim
//

import Foundation
import SwiftUI


public struct TooltipStyle {
    public enum ArrowPosition {
        case top, bottom, left, right
    }

    public var backgroundColor: Color = .blue
    public var textColor: Color = .white
    public var cornerRadius: CGFloat = 12
    public var arrowSize: CGSize = .init(width: 20, height: 12)
    public var font: Font = .system(size: 15, weight: .regular)
    public var maxWidth: CGFloat = 395
    public var padding: EdgeInsets = .init(top: 14, leading: 18, bottom: 14, trailing: 18)
    @State private var rightFrame: CGRect = .zero

    public var arrowPosition: ArrowPosition = .top
    public var arrowOffset: CGFloat = 0

    // ✅ USER X / Y CONTROL
    public var offsetX: CGFloat = 0
    public var offsetY: CGFloat = 0

    public var shadowRadius: CGFloat = 10
    public var shadowColor: Color = .black.opacity(0.2)

    public init() {}
}

struct TooltipSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

// MARK: - Tooltip Controller
public final class TooltipController: ObservableObject {
    @Published var isVisible: Bool = false
    @Published var message: String = ""
    @Published var targetFrame: CGRect = .zero
    
    public init() {}
    
    public func show(_ text: String, in frame: CGRect = .zero) {
        
        message = text
        targetFrame = frame
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            isVisible = true
        }
    }
    
    public func hide() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            isVisible = false
        }
    }
}

// MARK: - Tooltip Arrow Shape

struct TooltipArrow: Shape {
    let position: TooltipStyle.ArrowPosition
    let offset: CGFloat   // 🔴 NEW

    func path(in rect: CGRect) -> Path {
        var path = Path()

        switch position {

        case .left:
            let y = rect.midY + offset * rect.height

            path.move(to: CGPoint(x: rect.minX, y: y))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        case .right:
            let y = rect.midY + offset * rect.height

            path.move(to: CGPoint(x: rect.maxX, y: y))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        case .top:
            let x = rect.midX + offset * rect.width

            path.move(to: CGPoint(x: x, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        case .bottom:
            let x = rect.midX + offset * rect.width

            path.move(to: CGPoint(x: x, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }

        path.closeSubpath()
        return path
    }
}


// MARK: - Tooltip Bubble View
struct TooltipBubble: View {
    let text: String
    let style: TooltipStyle
    let onDismiss: () -> Void
    var body: some View {
        VStack(spacing: 0) {
            // Arrow at TOP = tooltip above button
            if style.arrowPosition == .top {
                arrowView
                content
            }
            // Arrow at BOTTOM = tooltip below button
            else if style.arrowPosition == .bottom {
                content
                arrowView
            }
            // Horizontal arrows
            else {
                HStack(spacing: 0) {
                    // Arrow at LEFT = tooltip to left of button
                    if style.arrowPosition == .left {
                        arrowView
                        content
                    }
                    // Arrow at RIGHT = tooltip to right of button
                    else {
                        content
                        arrowView
                    }
                }
            }
        }
        .shadow(color: style.shadowColor, radius: style.shadowRadius, x: 0, y: 4)
    }
    private var content: some View {
        VStack(alignment: .leading, spacing: 8) {

            HStack {
                Spacer()

                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white.opacity(0.9))
                        .font(.system(size: 18))
                }
            }

            Text(text)
                .font(style.font)
                .foregroundColor(style.textColor)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(
            minWidth: 150,
            maxWidth: style.maxWidth
        )
        .padding(style.padding)
        .background(style.backgroundColor)
        .cornerRadius(style.cornerRadius)
    }


    private var arrowView: some View {
        TooltipArrow(
            position: style.arrowPosition,
            offset: style.arrowOffset
        )

        .fill(style.backgroundColor)
        .frame(
            width: style.arrowPosition == .left || style.arrowPosition == .right
                ? style.arrowSize.height
                : style.arrowSize.width,
            height: style.arrowPosition == .left || style.arrowPosition == .right
                ? style.arrowSize.width
                : style.arrowSize.height
        )
    }

}
struct TooltipOverlay: View {
    @ObservedObject var controller: TooltipController
    let style: TooltipStyle

    @State private var tooltipSize: CGSize = .zero

    var body: some View {
        GeometryReader { proxy in
            if controller.isVisible {
                TooltipBubble(
                    text: controller.message,
                    style: style,
                    onDismiss: {
                        controller.hide()
                    }
                )

                    .background(
                        GeometryReader { geo in
                            Color.clear
                                .preference(
                                    key: TooltipSizeKey.self,
                                    value: geo.size
                                )
                        }
                    )
                    .onPreferenceChange(TooltipSizeKey.self) {
                        tooltipSize = $0
                    }
                    .position(calculatePosition())
                    .transition(.scale(scale: 0.9).combined(with: .opacity))
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
    private func calculatePosition() -> CGPoint {
        let frame = controller.targetFrame
        let arrow = style.arrowSize
        let bubble = tooltipSize
        let spacing: CGFloat = 8

        let basePoint: CGPoint

        switch style.arrowPosition {

        case .top:
            basePoint = CGPoint(
                x: frame.midX,
                y: frame.maxY + bubble.height / 2 + arrow.height + spacing
            )

        case .bottom:
            basePoint = CGPoint(
                x: frame.midX,
                y: frame.minY - bubble.height / 2 - arrow.height - spacing
            )

        case .left:
            basePoint = CGPoint(
                x: frame.maxX + bubble.width / 2 + arrow.width + spacing,
                y: frame.midY
            )

        case .right:
            basePoint = CGPoint(
                x: frame.minX - bubble.width / 2 - arrow.width - spacing,
                y: frame.midY
            )
        }

        // ✅ FINAL USER CONTROL
        return CGPoint(
            x: basePoint.x + style.offsetX,
            y: basePoint.y + style.offsetY
        )
    }




}


// MARK: - Global Frame Preference Key
struct GlobalFrameKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

// MARK: - View Extension
public extension View {
    func tooltip(
        controller: TooltipController,
        style: TooltipStyle = TooltipStyle()
    ) -> some View {
        self
             
            .overlay(
                TooltipOverlay(controller: controller, style: style)
            )
    }
}
