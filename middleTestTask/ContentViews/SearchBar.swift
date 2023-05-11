//
//  SearchBar.swift
//  middleTestTask
//
//  Created by Dmytro Vakulinsky on 10.05.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    
    var onSearchTextChange: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text, onEditingChanged: { editing in
                isEditing = editing
            })
            .font(.custom("OpenSans-Regular", size: 16))
            .foregroundColor(Color(hex: 0x949494))
            .frame(height: 40)
            .padding(.horizontal, 16)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 6)
            .overlay(
                HStack {
                    Spacer()
                    Image("icon_search")
                        .foregroundColor(Color(hex: 0x949494))
                        .padding(.trailing, 16)
                }
                    .alignmentGuide(HorizontalAlignment.trailing) { dimension in
                        dimension.width
                    }
            )
            .onChange(of: text) { newValue in
                if newValue.count >= 3 {
                    onSearchTextChange(newValue)
                } else if newValue.isEmpty {
                    onSearchTextChange("")
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

