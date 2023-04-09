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
