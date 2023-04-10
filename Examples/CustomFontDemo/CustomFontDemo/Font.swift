//
//  Font.swift
//  CustomFontDemo
//
//  Created by Vsevolod on 09.04.2023.
//

import SwiftUI
import CustomFont

extension CustomTextStyle {
    /// DancingScript, 700, 36, fixed
    static let hugeTitleFixed = CustomTextStyle(DancingScript.bold, fixedSize: 36)
    /// DancingScript, 700, 36
    static let hugeTitle = CustomTextStyle(DancingScript.bold, size: 36, relativeTo: .largeTitle)
    /// Barlow, 100, 34
    static let largeTitle = CustomTextStyle(Barlow.thin, size: 34, relativeTo: .largeTitle)
    /// NewYorkExtraLarge, 600, 28
    static let title = CustomTextStyle(NewYorkExtraLarge.semiBold, size: 28, relativeTo: .title)
    /// NewYorkExtraLarge, 600, 17
    static let headline = CustomTextStyle(NewYorkExtraLarge.semiBold, size: 17, relativeTo: .headline)
    /// Barlow, 400, 17
    static let body = CustomTextStyle(Barlow.regular, size: 17)
    /// Barlow, 100, 17
    static let body2 = CustomTextStyle(Barlow.thin, size: 17)
    /// DancingScript, 700, 13
    static let footnote = CustomTextStyle(DancingScript.bold, size: 13, relativeTo: .footnote)
}

fileprivate enum Barlow: String, CaseIterable, FontFamily {
    static let baseName = "Barlow-"
    
    case thin, extraLight, regular, medium
}

fileprivate enum DancingScript: String, CaseIterable, FontFamily {
    static let baseName = "DancingScript-"
    
    case bold
}

fileprivate enum NewYorkExtraLarge: String, CaseIterable, FontFamily {
    static let baseName = "NewYorkExtraLarge-"
    
    case semiBold, bold
}

struct FontView: View {
    @Environment(\.legibilityWeight) private var legibilityWeight
    
    private var attributedString: AttributedString {
        var result = AttributedString("Hello World!")
        result.font = .custom(.title).getFont(accordingTo: legibilityWeight)
        return result
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Hello World!")
                    .font(.custom(.hugeTitle))
                Text("Hello World!")
                    .font(.custom(.largeTitle))
                Text("Hello World!")
                    .font(.custom(.title))
                Text("Hello World!")
                    .font(.custom(.headline))
                Text("Hello World!")
                    .font(.custom(.body))
                Text("Hello World!")
                    .font(.custom(.body2))
                Text("Hello World!")
                    .font(.custom(.footnote))
            }
            VStack(alignment: .leading) {
                Text("Hello World!")
                    .font(.custom(.hugeTitleFixed))
                Text("Hello World!")
                    .font(.custom(.hugeTitle))
                Text("Hello World!")
                    .font(.custom(.title))
                    .italic()
                Text(attributedString)
                Text("Hello ")
                    .font(.custom(.title), accordingTo: legibilityWeight)
                    .italic() +
                Text("World!")
                    .font(.custom(.footnote), accordingTo: legibilityWeight)
            }
        }
    }
}

struct FontView_Previews: PreviewProvider {
    static var previews: some View {
        FontView()
    }
}
