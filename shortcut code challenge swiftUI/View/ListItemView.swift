//
//  ListItemView.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import SwiftUI

struct ListItemView: View {
    
    let item: ComicModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(item.safeTitle)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.accentColor)
            
            Text(item.publishedDate?.convertToLongDate() ?? "")
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .padding(.trailing, 8)
        }//: VSTACK
    }
}
