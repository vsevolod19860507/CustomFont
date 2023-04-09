//
//  ContentView.swift
//  CustomFontDemo
//
//  Created by Vsevolod on 09.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Custom Font Demo")
                .font(.custom(.hugeTitle))
                .foregroundColor(.red)
            FontView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
