# **CustomFont**

The CustomFont is designed for the convenient integration and management of custom fonts in a SwiftUI application. It offers an intuitive interface for creating custom text styles and mechanisms for dynamic text boldness control based on user-defined accessibility settings using LegibilityWeight.

## **Key Features**

- **Custom Text Style**: Create styles with automatic scaling or fixed size.
- **Dynamic Boldness**: Adjust text boldness according to accessibility settings.
- **Easy Font Integration**: Add and use your fonts effortlessly.
- **SwiftUI Integration**: Apply text styles directly in your SwiftUI views.

## **How to Use**

1. **Adding Fonts to the Project:**
First, add the desired fonts to your project as you usually would, and also make sure to list them in the Info.plist file.

2. **Defining a Custom Style:**
Here, we are using the NewYorkExtraLarge font as an example:
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

3. **Using the Style in SwiftUI:**
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


## **Conclusion**
CustomFont simplifies working with custom fonts in SwiftUI, providing a unified and consistent approach to managing text styles. With this package, your user interfaces will look polished and professional, irrespective of chosen accessibility settings.

[More examples](Examples/)
