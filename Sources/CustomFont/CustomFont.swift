import SwiftUI

public struct CustomFont {
    public static func custom(_ customTextStyle: CustomTextStyle) -> CustomFont {
        CustomFont(customTextStyle: customTextStyle)
    }
    
    private let customTextStyle: CustomTextStyle
    
    fileprivate func callAsFunction(_ legibilityWeight: LegibilityWeight?) -> Font {
        customTextStyle(legibilityWeight)
    }
}

public struct CustomTextStyle {
    private let fontFamily: FontFamily
    private let size: CGFloat
    private let textStyle: Font.TextStyle?
    
    public init(_ fontFamily: FontFamily, size: CGFloat, relativeTo textStyle: Font.TextStyle = .body) {
        self.fontFamily = fontFamily
        self.size = size
        self.textStyle = textStyle
    }
    
    public init(_ fontFamily: FontFamily, fixedSize: CGFloat) {
        self.fontFamily = fontFamily
        self.size = fixedSize
        self.textStyle = nil
    }
    
    fileprivate func callAsFunction(_ legibilityWeight: LegibilityWeight?) -> Font {
        let fontFamily: FontFamily
        switch legibilityWeight {
        case .bold:
            fontFamily = self.fontFamily.bolder
        default:
            fontFamily = self.fontFamily
        }
        
        if let textStyle = textStyle {
            return .custom(fontFamily.name, size: size, relativeTo: textStyle)
        }
        return .custom(fontFamily.name, fixedSize: size)
    }
}

public protocol FontFamily {
    static var baseName: String { get }
    
    var name: String { get }
    var bolder: Self { get }
}

public extension FontFamily where Self: Equatable,
                                  Self: RawRepresentable<String>,
                                  Self: CaseIterable,
                                  AllCases == [Self] {
    var name: String {
        Self.baseName + rawValue
    }
    
    var bolder: Self {
        let allCases = Self.allCases
        
        guard self != allCases.last,
              let firstIndex = allCases.firstIndex(of: self)
        else { return self }
        
        return allCases[firstIndex + 1]
    }
}

public extension Text {
    func font(_ customFont: CustomFont, consider legibilityWeight: LegibilityWeight?) -> Text {
        self.font(customFont(legibilityWeight))
    }
}

public extension View {
    func font(_ customFont: CustomFont) -> some View {
        modifier(FontViewModifier(customFont: customFont))
    }
}

public struct FontViewModifier: ViewModifier {
    @Environment(\.legibilityWeight) private var legibilityWeight
    
    public let customFont: CustomFont
    
    public func body(content: Content) -> some View {
        content.font(customFont(legibilityWeight))
    }
}
