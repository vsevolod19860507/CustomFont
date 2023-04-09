# CustomFont

Convenient work with custom fonts in SwiftUI

## Installation

To install this package, import `https://github.com/vsevolod19860507/CustomFont` in SPM.

## Usage example

```swift
import SwiftUI
import CustomFont

extension CustomTextStyle {
    static let largeTitle = CustomTextStyle(Barlow.thin, size: 34, relativeTo: .largeTitle)
    static let body = CustomTextStyle(Barlow.regular, size: 17)
}

// Don't add cases for italic fonts, use the .italic() view modifier instead!
// Order is important, add less bold fonts first!
// Also add bolder fonts in addition to the ones you use to account for LegibilityWeight settings.
// If you need Barlow thin and regular add also extraLight and medium respectively.
fileprivate enum Barlow: String, CaseIterable, FontFamily {
    static let baseName = "Barlow-"
    
    case thin, extraLight, regular, medium
}

struct ContentView: View {    
    var body: some View {
        VStack {
            Text("Hello World!")
                .font(.custom(.largeTitle))
            Text("Hello World!")
                .font(.custom(.body))
        }
    }
}
```
[More examples](https://github.com/vsevolod19860507/CustomFont/tree/main/Examples)
