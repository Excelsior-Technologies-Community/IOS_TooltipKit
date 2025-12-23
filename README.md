# TooltipKit

**TooltipKit** is a lightweight tooltip library for **SwiftUI and UIKit**, providing **manual X/Y positioning**, optional arrows, and dismiss support.

It is designed for:

* Fine-grained control over tooltip position
* SwiftUI & UIKit parity
* Clean architecture
* Swift Package Manager compatibility

---

## Features

* ✅ SwiftUI & UIKit support
* ✅ Manual X / Y positioning
* ✅ Optional arrow (enable / disable)
* ✅ Multiple independent tooltips
* ✅ Dismiss button support
* ✅ No PreferenceKey abuse
* ✅ iOS 15+

---

## Installation (Swift Package Manager)

### Add TooltipKit to your project

1. Open your Xcode project
2. Go to **File → Add Packages…**
3. Choose **Add Local Package**
4. Select the repository folder:

```
IOS_TooltipKit
```

5. Add **TooltipKit**

---

## Import

```swift
import TooltipKit
```

---

# SwiftUI Usage

---

## 1️⃣ Minimal SwiftUI Usage

### Required line

```swift
@StateObject private var tooltip = TooltipController()
```

### Attach tooltip to any view

```swift
Button("Show Tooltip") {
    tooltip.show("Hello from TooltipKit")
}
.tooltip(
    controller: tooltip,
    style: TooltipStyle()
)
```

---

## 2️⃣ SwiftUI – Manual X/Y Positioning

```swift
.tooltip(
    controller: tooltip,
    style: {
        var style = TooltipStyle()
        style.offsetX = 40
        style.offsetY = -70
        return style
    }()
)
```

---

## 3️⃣ Full SwiftUI Example

```swift
import SwiftUI
import TooltipKit

struct ContentView: View {

    @StateObject private var topTooltip = TooltipController()
    @StateObject private var bottomTooltip = TooltipController()
    @StateObject private var leftTooltip = TooltipController()
    @StateObject private var rightTooltip = TooltipController()

    var body: some View {
        ZStack {

            VStack(spacing: 40) {

                Button("Top Tooltip") {
                    topTooltip.show("This is a top tooltip")
                }
                .tooltip(
                    controller: topTooltip,
                    style: {
                        var s = TooltipStyle()
                        s.arrowPosition = .bottom
                        s.offsetY = -70
                        return s
                    }()
                )

                Button("Right Tooltip") {
                    rightTooltip.show("This is a right tooltip")
                }
                .tooltip(
                    controller: rightTooltip,
                    style: {
                        var s = TooltipStyle()
                        s.arrowPosition = .left
                        s.offsetX = 140
                        return s
                    }()
                )

                Button("Left Tooltip") {
                    leftTooltip.show("This is a left tooltip")
                }
                .tooltip(
                    controller: leftTooltip,
                    style: {
                        var s = TooltipStyle()
                        s.arrowPosition = .right
                        s.offsetX = -80
                        return s
                    }()
                )

                Button("Bottom Tooltip") {
                    bottomTooltip.show("This is a bottom tooltip")
                }
                .tooltip(
                    controller: bottomTooltip,
                    style: {
                        var s = TooltipStyle()
                        s.arrowPosition = .top
                        s.offsetY = 100
                        return s
                    }()
                )
            }
        }
        .onTapGesture {
            topTooltip.hide()
            bottomTooltip.hide()
            leftTooltip.hide()
            rightTooltip.hide()
        }
    }
}
```

---

# UIKit Usage

---

## 1️⃣ Minimal UIKit Setup

### Required property

```swift
private var tooltip: TooltipManager!
```

### Initialize in `viewDidLoad`

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    tooltip = TooltipManager(containerView: view)
}
```

---

## 2️⃣ UIKit – Manual X/Y Positioning (Absolute)

```swift
var style = UIKitTooltipStyle()
style.showsArrow = false
style.usesAbsolutePositioning = true
style.offsetX = 120
style.offsetY = -50

tooltip.show(
    text: "Hello UIKit Tooltip",
    from: sender,
    style: style
)
```

---

## 3️⃣ Full UIKit Example

```swift
import UIKit
import TooltipKit

class ViewController: UIViewController {

    private var rightTooltip: TooltipManager!
    private var leftTooltip: TooltipManager!
    private var topTooltip: TooltipManager!
    private var bottomTooltip: TooltipManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        rightTooltip = TooltipManager(containerView: view)
        leftTooltip = TooltipManager(containerView: view)
        topTooltip = TooltipManager(containerView: view)
        bottomTooltip = TooltipManager(containerView: view)
    }

    @IBAction func rightTap(_ sender: UIButton) {
        var style = UIKitTooltipStyle()
        style.backgroundColor = .blue
        style.showsArrow = false
        style.usesAbsolutePositioning = true
        style.offsetX = 70
        style.offsetY = -40

        rightTooltip.show(
            text: "Right Tooltip",
            from: sender,
            style: style
        )
    }

    @IBAction func leftTap(_ sender: UIButton) {
        var style = UIKitTooltipStyle()
        style.backgroundColor = .orange
        style.showsArrow = false
        style.usesAbsolutePositioning = true
        style.offsetX = -280
        style.offsetY = -30

        leftTooltip.show(
            text: "Left Tooltip",
            from: sender,
            style: style
        )
    }

    @IBAction func topTap(_ sender: UIButton) {
        var style = UIKitTooltipStyle()
        style.backgroundColor = .green
        style.showsArrow = false
        style.usesAbsolutePositioning = true
        style.offsetX = -110
        style.offsetY = 50

        topTooltip.show(
            text: "Top Tooltip",
            from: sender,
            style: style
        )
    }

    @IBAction func bottomTap(_ sender: UIButton) {
        var style = UIKitTooltipStyle()
        style.backgroundColor = .purple
        style.showsArrow = false
        style.usesAbsolutePositioning = true
        style.offsetX = -110
        style.offsetY = -120

        bottomTooltip.show(
            text: "Bottom Tooltip",
            from: sender,
            style: style
        )
    }
}
```

---

## Notes

* `TooltipManager` controls **one tooltip instance**
* Use **multiple managers** for independent tooltips
* `usesAbsolutePositioning = true` enables full X/Y control
* `arrowPosition` acts as an anchor when arrows are enabled

---
 