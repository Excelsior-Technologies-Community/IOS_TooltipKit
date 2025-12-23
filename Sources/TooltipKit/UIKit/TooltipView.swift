import UIKit

final class TooltipView: UIView {

    private let label = UILabel()
    private let closeButton = UIButton(type: .system)

    init(text: String, style: UIKitTooltipStyle, onDismiss: @escaping () -> Void) {
        super.init(frame: .zero)

        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius

        label.text = text
        label.textColor = style.textColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        closeButton.setImage(
            UIImage(systemName: "xmark.circle.fill"),
            for: .normal
        )
        closeButton.tintColor = .white
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addAction(
            UIAction { _ in onDismiss() },
            for: .touchUpInside
        )

        addSubview(label)
        addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            label.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) { nil }
}
