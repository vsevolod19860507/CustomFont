import SwiftUI

extension Font {
    public static func custom(_ customTextStyle: CustomTextStyle) -> CustomFont {
        CustomFont(customTextStyle: customTextStyle)
    }
}

public struct CustomFont {
    public static func custom(_ customTextStyle: CustomTextStyle) -> CustomFont {
        CustomFont(customTextStyle: customTextStyle)
    }
    
    fileprivate let customTextStyle: CustomTextStyle
    
    public func getFont(consider legibilityWeight: LegibilityWeight?) -> Font {
        customTextStyle(legibilityWeight)
    }
}

/// A type that describes the custom text styles that are used in your application.
///
/// You should extend it and add your custom text styles.
///
///     extension CustomTextStyle {
///         /// DancingScript, 700, 36, fixed
///         static let hugeTitleFixed = CustomTextStyle(DancingScript.bold, fixedSize: 36)
///         /// DancingScript, 700, 36
///         static let hugeTitle = CustomTextStyle(DancingScript.bold, size: 36, relativeTo: .largeTitle)
///         /// Barlow, 100, 34
///         static let largeTitle = CustomTextStyle(Barlow.thin, size: 34, relativeTo: .largeTitle)
///         /// NewYorkExtraLarge, 600, 28
///         static let title = CustomTextStyle(NewYorkExtraLarge.semiBold, size: 28, relativeTo: .title)
///         /// NewYorkExtraLarge, 600, 17
///         static let headline = CustomTextStyle(NewYorkExtraLarge.semiBold, size: 17, relativeTo: .headline)
///         /// Barlow, 400, 17
///         static let body = CustomTextStyle(Barlow.regular, size: 17)
///         /// Barlow, 100, 17
///         static let body2 = CustomTextStyle(Barlow.thin, size: 17)
///         /// DancingScript, 700, 13
///         static let footnote = CustomTextStyle(DancingScript.bold, size: 13, relativeTo: .footnote)
///     }
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

/// Protocol describing a custom font.
///
/// Add any font names you want to use to the enum that implements this protocol. Don't add cases for italic fonts, use the .italic() view modifier instead!
///
/// Order is important, add less bold fonts first!
///
/// Also add bolder fonts in addition to the ones you use to account for LegibilityWeight settings.
/// For example, if you only need NewYorkExtraLarge-Semibold (the semiBold case)then also add a bold case.
/// If you need Barlow thin and regular add also extraLight and medium respectively.
/// In the case of DancingScript bold, this is the maximum weight, so only one is added.
///
///     fileprivate enum NewYorkExtraLarge: String, CaseIterable, FontFamily {
///         static let baseName = "NewYorkExtraLarge-"
///
///         case semiBold, bold
///     }
///
///     fileprivate enum Barlow: String, CaseIterable, FontFamily {
///         static let baseName = "Barlow-"
///
///         case thin, extraLight, regular, medium
///     }
///
///     fileprivate enum DancingScript: String, CaseIterable, FontFamily {
///         static let baseName = "DancingScript-"
///
///         case bold
///     }
/// But you still have to add italic fonts to the project, otherwise, the .italic() view modifier won't work!
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
        self.font(customFont.getFont(consider: legibilityWeight))
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
    
    public init(customFont: CustomFont) {
        self.customFont = customFont
    }
    
    public func body(content: Content) -> some View {
        content.font(customFont.getFont(consider: legibilityWeight))
    }
}
