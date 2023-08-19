//
//  CustomFont.swift
//
//
//  Created by Vsevolod on 19.08.2023.
//

import SwiftUI

/// Represents a customizable font object that integrates with `CustomTextStyle`.
public struct CustomFont {
    fileprivate let customTextStyle: CustomTextStyle
    
    /// Creates a custom font object associated with a specific custom text style.
    /// - Parameter customTextStyle: The custom text style to be used.
    /// - Returns: A custom font object.
    ///
    /// Example:
    /// ```
    /// let customFont = CustomFont.custom(.largeTitle)
    /// ```
    public static func custom(_ customTextStyle: CustomTextStyle) -> CustomFont {
        CustomFont(customTextStyle: customTextStyle)
    }
    
    /// Retrieves the font object according to the given legibility weight.
    /// - Parameter legibilityWeight: The weight to influence font choice.
    /// - Returns: The selected font.
    ///
    /// Example:
    /// ```
    /// let font = customFont.getFont(accordingTo: legibilityWeight)
    /// ```
    public func getFont(accordingTo legibilityWeight: LegibilityWeight?) -> Font {
        customTextStyle(legibilityWeight)
    }
}

public extension Font {
    /// Allows for the creation of a custom font using a specific text style.
    /// - Parameter customTextStyle: The custom text style to be used.
    /// - Returns: A custom font object.
    ///
    /// Example:
    /// ```
    /// let customFont = Font.custom(.largeTitle)
    /// ```
    static func custom(_ customTextStyle: CustomTextStyle) -> CustomFont {
        CustomFont(customTextStyle: customTextStyle)
    }
}

public extension Text {
    /// Applies the custom font to the Text view according to the specified legibility weight.
    /// - Parameters:
    ///   - customFont: The custom font object.
    ///   - legibilityWeight: The weight to influence font choice.
    /// - Returns: A modified text view with the custom font applied.
    ///
    /// Example:
    /// ```
    /// Text("Hello World!")
    ///     .font(.custom(.title), accordingTo: legibilityWeight)
    /// ```
    func font(_ customFont: CustomFont, accordingTo legibilityWeight: LegibilityWeight?) -> Text {
        font(customFont.getFont(accordingTo: legibilityWeight))
    }
}

public extension View {
    /// Applies the custom font to any view.
    /// - Parameter customFont: The custom font object.
    /// - Returns: A modified view with the custom font applied.
    ///
    /// Example:
    /// ```
    /// Text("Hello World!")
    ///     .font(.custom(.largeTitle))
    /// ```
    func font(_ customFont: CustomFont) -> some View {
        modifier(FontViewModifier(customFont: customFont))
    }
}

fileprivate struct FontViewModifier: ViewModifier {
    @Environment(\.legibilityWeight) private var legibilityWeight
    let customFont: CustomFont
    
    func body(content: Content) -> some View {
        content.font(customFont.getFont(accordingTo: legibilityWeight))
    }
}
