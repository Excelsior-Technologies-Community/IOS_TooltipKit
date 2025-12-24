# TooltipKit

**TooltipKit** is a lightweight tooltip library for **SwiftUI and UIKit**, providing **manual X/Y positioning**, **arrow support (top / bottom / left / right)**, and **independent tooltips**.

Designed for:

* Fine-grained control over tooltip position
* SwiftUI & UIKit parity
* Clean, predictable layout behavior
* Swift Package Manager compatibility

---

## Features

* ✅ SwiftUI & UIKit support
* ✅ Manual X / Y positioning
* ✅ Arrow support (top / bottom / left / right)
* ✅ Multiple independent tooltips
* ✅ Absolute positioning mode
* ✅ iOS 15+

---

## Screenshots

### UIKit

<img src="Assets/UIKit.png" width="320"/>

### SwiftUI

<img src="Assets/SwiftUI.jpg" width="320"/>

---

## Installation (Swift Package Manager)

### Option 1: Local Package (Recommended)

1. Open your Xcode project
2. Go to **File → Add Packages…**
3. Select **Add Local Package**
4. Choose the repository folder:

```
IOS_TooltipKit
```

5. Add **TooltipKit**

---

### Option 2: Git Repository (if hosted)

```
https://github.com/your-username/IOS_TooltipKit
```

---

## Import

```swift
import TooltipKit
```

---

# SwiftUI Usage

---

## 1️⃣ SwiftUI Setup

Create one controller per tooltip:

```swift
@StateObject private var topTooltip = TooltipController()
@StateObject private var rightTooltip = TooltipController()
@StateObject private var leftTooltip = TooltipController()
@StateObject private var bottomTooltip = TooltipController()
```

---

## 2️⃣ Full SwiftUI Example (FINAL – Simplified)

```swift
import SwiftUI
import TooltipKit


// MARK: - Demo Content View
struct ContentView: View {
   @StateObject private var topTooltip = TooltipController()
   @StateObject private var bottomTooltip = TooltipController()
   @StateObject private var leftTooltip = TooltipController()
   @StateObject private var rightTooltip = TooltipController()
   @State private var rightFrame: CGRect = .zero

   var body: some View {
       ZStack {
           Color(UIColor.systemGroupedBackground)
               .ignoresSafeArea()
           
           VStack(spacing: 60) {
            
               Spacer()
               VStack(spacing: 12) {
                   Button("TOP") {
                       topTooltip.show(
                           "This tip view cannot be presented with the arrow on the top position."
                       )
                   }
                   .foregroundColor(.white)
                   .padding()
                   .background(
                       RoundedRectangle(cornerRadius: 12)
                           .fill(Color.purple)
                   )
                   .tooltip(
                       controller: topTooltip,
                       style: {
                           var s = TooltipStyle()
                           s.backgroundColor = .purple
                           s.arrowPosition = .bottom
                           s.offsetX = 45
                           s.offsetY = -40
                           return s
                       }()
                   )
               }

               HStack(spacing: 12) {
                   Button("RIGHT") {
                       rightTooltip.show(
                           "Tip view positioned with the arrow on the left."
                       )
                   }
                   .foregroundColor(.white)
                   .padding()
                   .background(
                       RoundedRectangle(cornerRadius: 12)
                           .fill(Color.blue)
                   )
                   .tooltip(
                       controller: rightTooltip,
                       style: {
                           var s = TooltipStyle()
                           s.backgroundColor = .blue
                           s.arrowPosition = .left
                           s.offsetX = 150
                           s.offsetY = 30
                           return s
                       }()
                   )

                   Spacer()
               }

               HStack(spacing: 12) {
                   Spacer()

                   Button("LEFT") {
                       leftTooltip.show(
                           "Tip view positioned with the arrow on the right."
                       )
                   }
                   .foregroundColor(.white)
                   .padding()
                   .background(
                       RoundedRectangle(cornerRadius: 12)
                           .fill(Color.blue)
                   )
                   .tooltip(
                       controller: leftTooltip,
                       style: {
                           var s = TooltipStyle()
                           s.backgroundColor = .blue
                           s.arrowPosition = .right
                           s.offsetX = -80
                           s.offsetY = 35
                           return s
                       }()
                   )
               }

               
               
               Spacer()
               
               VStack(spacing: 12) {
                   Button("BOTTOM") {
                       bottomTooltip.show(
                           "Tip view inside the navigation controller's view."
                       )
                   }
                   .foregroundColor(.white)
                   .padding()
                   .background(
                       RoundedRectangle(cornerRadius: 12)
                           .fill(Color.green)
                   )
                   .tooltip(
                       controller: bottomTooltip,
                       style: {
                           var s = TooltipStyle()
                           s.backgroundColor = .green
                           s.arrowPosition = .top
                           s.offsetX = 40
                           s.offsetY = 100
                           return s
                       }()
                   )
               }

               
               Spacer()
           }
           .padding()
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

## SwiftUI Notes

* One `TooltipController` per tooltip
* `offsetX / offsetY` move **bubble + arrow together**
* Arrow is anchored to the tooltip, not the button

---

# UIKit Usage

---

## 1️⃣ UIKit Setup

### Required properties

```swift
private var rightTooltip: TooltipManager!
private var leftTooltip: TooltipManager!
private var topTooltip: TooltipManager!
private var bottomTooltip: TooltipManager!
```

### Initialize in `viewDidLoad`

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    rightTooltip = TooltipManager(containerView: view)
    leftTooltip = TooltipManager(containerView: view)
    topTooltip = TooltipManager(containerView: view)
    bottomTooltip = TooltipManager(containerView: view)
}
```

---

## 2️⃣ Full UIKit Example (FINAL)

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
        style.showsArrow = true
        style.arrowPosition = .left
        style.usesAbsolutePositioning = true
        style.offsetX = -10
        style.offsetY = 0

        rightTooltip.show(
            text: "Right Tooltip",
            from: sender,
            style: style
        )
    }

    @IBAction func leftTap(_ sender: UIButton) {
        var style = UIKitTooltipStyle()
        style.backgroundColor = .orange
        style.showsArrow = true
        style.arrowPosition = .right
        style.usesAbsolutePositioning = true
        style.offsetX = -20
        style.offsetY = 10

        leftTooltip.show(
            text: "Left Tooltip",
            from: sender,
            style: style
        )
    }

    @IBAction func topTap(_ sender: UIButton) {
        var style = UIKitTooltipStyle()
        style.backgroundColor = .green
        style.showsArrow = true
        style.arrowPosition = .top
        style.usesAbsolutePositioning = true
        style.offsetX = 0
        style.offsetY = 30

        topTooltip.show(
            text: "Top Tooltip",
            from: sender,
            style: style
        )
    }

    @IBAction func bottomTap(_ sender: UIButton) {
        var style = UIKitTooltipStyle()
        style.backgroundColor = .purple
        style.showsArrow = true
        style.arrowPosition = .bottom
        style.usesAbsolutePositioning = true
        style.offsetX = 10
        style.offsetY = -20

        bottomTooltip.show(
            text: "Bottom Tooltip",
            from: sender,
            style: style
        )
    }
}
```

---

## UIKit Notes

* One `TooltipManager` per tooltip
* Absolute positioning is opt-in
* Arrow visibility controlled via `showsArrow`

 
