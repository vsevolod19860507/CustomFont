//
//  CustomTextStyle.swift
//
//
//  Created by Vsevolod on 19.08.2023.
//

import SwiftUI

/// `CustomTextStyle` represents a specialized text style configuration tailored to your application's design system.
///
/// By extending `CustomTextStyle`, you can introduce various text styles to be used throughout your application, ensuring consistent typography.
///
/// Example usage:
/// ```swift
/// extension CustomTextStyle {
///     /// DancingScript, 700, 36, fixed
///     static let hugeTitleFixed = CustomTextStyle(DancingScript.bold, fixedSize: 36)
///     /// DancingScript, 700, 36
///     static let hugeTitle = CustomTextStyle(DancingScript.bold, size: 36, relativeTo: .largeTitle)
///     /// Barlow, 100, 34
///     static let largeTitle = CustomTextStyle(Barlow.thin, size: 34, relativeTo: .largeTitle)
///     /// NewYorkExtraLarge, 600, 28
///     static let title = CustomTextStyle(NewYorkExtraLarge.semiBold, size: 28, relativeTo: .title)
///     /// NewYorkExtraLarge, 600, 17
///     static let headline = CustomTextStyle(NewYorkExtraLarge.semiBold, size: 17, relativeTo: .headline)
///     /// Barlow, 400, 17
///     static let body = CustomTextStyle(Barlow.regular, size: 17)
///     /// Barlow, 100, 17
///     static let body2 = CustomTextStyle(Barlow.thin, size: 17)
///     /// DancingScript, 700, 13
///     static let footnote = CustomTextStyle(DancingScript.bold, size: 13, relativeTo: .footnote)
/// }
/// ```
public struct CustomTextStyle {
    private let fontFamily: FontFamily
    private let size: CGFloat
    private let textStyle: Font.TextStyle?
    
    /// Creates a custom font style that scales relative to the given textStyle.
    /// - Parameters:
    ///     - fontFamily: The custom font family.
    ///     - size: The base font size.
    ///     - textStyle: The font style which this custom style should be relative to.
    public init(_ fontFamily: FontFamily, size: CGFloat, relativeTo textStyle: Font.TextStyle = .body) {
        self.fontFamily = fontFamily
        self.size = size
        self.textStyle = textStyle
    }
    
    /// Creates a custom font style with a fixed size, not influenced by the user's Dynamic Type settings.
    /// - Parameters:
    ///     - fontFamily: The custom font family.
    ///     - fixedSize: The fixed font size.
    public init(_ fontFamily: FontFamily, fixedSize: CGFloat) {
        self.fontFamily = fontFamily
        self.size = fixedSize
        self.textStyle = nil
    }
    
    func callAsFunction(_ legibilityWeight: LegibilityWeight?) -> Font {
        let family = legibilityWeight == .bold ? fontFamily.bolder : fontFamily
        
        if let textStyle = textStyle {
            return .custom(family.name, size: size, relativeTo: textStyle)
        }
        return .custom(family.name, fixedSize: size)
    }
}
