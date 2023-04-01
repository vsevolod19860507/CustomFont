# CustomFont

## Installation

To install this package, import `https://github.com/vsevolod19860507/customFont` in SPM.

## Usage example

```swift
import SwiftUI
import CustomFont

extension CustomTextStyle {
    static let headline = CustomTextStyle(Barlow.semiBold, size: 17, relativeTo: .headline)
    static let body = CustomTextStyle(Barlow.regular, size: 17)
}

fileprivate enum Barlow: String, CaseIterable, FontFamily {
    static let baseName = "Barlow-"
    
    case regular, medium, semiBold, bold
}

struct ContentView: View {
    @Environment(\.legibilityWeight) private var legibilityWeight
    
    var body: some View {
        VStack {
            Text("Hello World!")
                .font(.custom(.headline))
            Text("Hello World!")
                .font(.custom(.body))
            
            Text("Hello")
                .font(.custom(.headline), consider: legibilityWeight)
                .italic() +
            Text("World!")
                .font(.custom(.body), consider: legibilityWeight)
        }
    }
}
```
You can see the full example here https://github.com/vsevolod19860507/SwiftUITemplate/blob/main/SwiftUITemplate/Font.swift
