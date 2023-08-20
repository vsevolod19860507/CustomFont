# CustomFont

The `CustomFont` is designed for intuitive integration and management of fonts within a SwiftUI application. It provides a user-friendly interface for crafting text styles and introduces mechanisms to dynamically control text boldness based on user-defined accessibility settings with `LegibilityWeight`.

## Key Features

- **Custom Text Style**: Design styles with either automatic scaling or specified fixed sizes.
- **Dynamic Boldness**: Adjust text boldness in alignment with accessibility settings.
- **Easy Font Integration**: Effortlessly introduce and deploy your fonts.
- **SwiftUI Integration**: Apply text styles seamlessly within your SwiftUI views.

## How to Use

### 1. Adding Fonts to the Project

Add the desired fonts to your project as per usual. Also, remember to list them in the `Info.plist` file.

### 2. Defining Fonts

Define your fonts using the provided protocols. Take note:

- **Font Names**: Ensure that you've added the font names you intend to use to a type that conforms to the `FontFamily` protocol.
- **Italic Fonts**: Do not add specific cases for italic fonts. Instead, use the `.italic()` view modifier to achieve the italic style. However, ensure that italic variants of your fonts are included in your project. Without them, the `.italic()` view modifier won't have any effect.
- **Font Weight Order**: Arrange your font weights sequentially, starting from the "Light" variants and progressing to the "Bold" ones.
- **Adapting to LegibilityWeight**: To allow your fonts to adapt to `LegibilityWeight` settings, both include the font of the next boldest weight in your project and list it as a case in your `FontFamily` type. This is vital for the `LegibilityWeight` functionality to work correctly.

```swift
fileprivate enum NewYorkExtraLarge: String, CaseIterable, FontFamily {
    static let baseName = "NewYorkExtraLarge-"
    
    case semiBold, bold
}

extension CustomTextStyle {
    /// NewYorkExtraLarge, 600, 28, fixed
    static let titleFixed = CustomTextStyle(NewYorkExtraLarge.semiBold, fixedSize: 28)
    /// NewYorkExtraLarge, 600, 28
    static let title = CustomTextStyle(NewYorkExtraLarge.semiBold, size: 28, relativeTo: .title)
}
```

### 3. Using Fonts

```swift
struct ContentView: View {
    @Environment(\.legibilityWeight) private var legibilityWeight
    
    private var attributedString: AttributedString {
        var result = AttributedString("Hello World!")
        result.font = .custom(.title).getFont(accordingTo: legibilityWeight)
        return result
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello World!")
                .font(.custom(.titleFixed))
                
            Text("Hello World!")
                .font(.custom(.title))
                
            Text("Hello World!")
                .font(.custom(.title))
                .italic()
            
            Text(attributedString)
            
            Text("Hello World!")
                .font(.custom(.title), accordingTo: legibilityWeight)
        }
        .padding()
    }
}
```

[More examples](Examples/)
