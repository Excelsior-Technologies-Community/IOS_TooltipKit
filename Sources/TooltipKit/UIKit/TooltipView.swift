import UIKit

final class TooltipView: UIView {

    // MARK: - UI
    private let textLabel = UILabel()
    private let closeButton = UIButton(type: .system)

    // MARK: - Init
    init(
        text: String,
        style: UIKitTooltipStyle,
        onDismiss: @escaping () -> Void
    ) {
        super.init(frame: .zero)

        // 🔥 FORCE background color (prevents color bleed)
        self.backgroundColor = style.backgroundColor
        self.layer.cornerRadius = style.cornerRadius
        self.clipsToBounds = true

        // MARK: - Close Button
        closeButton.setImage(
            UIImage(systemName: "xmark.circle.fill"),
            for: .normal
        )
        closeButton.tintColor = style.textColor
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addAction(
            UIAction { _ in onDismiss() },
            for: .touchUpInside
        )

        // MARK: - Label
        textLabel.text = text
        textLabel.textColor = style.textColor
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        // MARK: - Add Subviews
        addSubview(closeButton)
        addSubview(textLabel)

        // MARK: - Layout
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 22),
            closeButton.heightAnchor.constraint(equalToConstant: 22),

            textLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 4),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
