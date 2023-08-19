//
//  FontFamily.swift
//  
//
//  Created by Vsevolod on 19.08.2023.
//

import Foundation

/// Protocol that describes a custom font.
///
/// Important:
///    - Add the font names you want to use to a type that conforms to this protocol.
///    - Don't add cases for italic fonts; use the `.italic()` view modifier instead!
///    - Ensure you include italic fonts in the project, or the `.italic()` view modifier won't work!
///
///  Note:
///   - Order matters: start with the least bold and progress to the boldest.
///
///   To adapt your fonts to `LegibilityWeight` settings, include slightly bolder font styles besides your primary ones.
///
/// Examples:
/// ```
/// // If using `NewYorkExtraLarge-SemiBold`, also add the `Bold` variant.
/// fileprivate enum NewYorkExtraLarge: String, CaseIterable, FontFamily {
///     static let baseName = "NewYorkExtraLarge-"
///     case SemiBold, Bold
/// }
///
/// // If using `Barlow-Thin` and `Barlow-Regular`, include `Barlow-ExtraLight` and `Barlow-Medium`.
/// fileprivate enum Barlow: String, CaseIterable, FontFamily {
///     static let baseName = "Barlow-"
///     case Thin, ExtraLight, Regular, Medium
/// }
///
/// // For `DancingScript-Bold`, no additional weights are needed.
/// fileprivate enum DancingScript: String, CaseIterable, FontFamily {
///     static let baseName = "DancingScript-"
///     case Bold
/// }
/// ```
public protocol FontFamily {
    /// The base name of the font. Example: For "NewYorkExtraLarge-SemiBold", it's "NewYorkExtraLarge-".
    static var baseName: String { get }
    
    /// Full font name: base name + style. Example: "NewYorkExtraLarge-SemiBold".
    var name: String { get }
    
    /// Returns a bolder style. If current style is boldest, it returns the same style.
    var bolder: Self { get }
}

public extension FontFamily where Self: Equatable,
                                  Self: RawRepresentable<String>,
                                  Self: CaseIterable,
                                  AllCases == [Self] {
    /// Full font name: base name + style.
    var name: String {
        Self.baseName + rawValue
    }
    
    /// Provides a bolder font style. If current is the boldest, it returns the same style.
    var bolder: Self {
        let allCases = Self.allCases
        
        guard let firstIndex = allCases.firstIndex(of: self),
              self != allCases.last
        else { return self }
        
        return allCases[firstIndex + 1]
    }
}

