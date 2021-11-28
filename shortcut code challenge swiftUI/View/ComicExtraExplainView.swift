//
//  ComicExtraExplainView.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import SwiftUI

struct ComicExtraExplainView: View {
    
    var item: ComicModel
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("More information") {
                
                Divider().padding(.vertical, 5)
                HStack(alignment: .top) {
                    Group {
                        Image(systemName: "number")
                        Text("Comic Number")
                    }//: GROUP
                    .foregroundColor(.accentColor)
                    .font(Font.system(.body).bold())
                    
                    Spacer(minLength: 20)
                    Text("\(item.num)")
                        .multilineTextAlignment(.trailing)
                }//: HSTACK FOR COMIC NUMBER
                
                
                Divider().padding(.vertical, 5)
                HStack(alignment: .top) {
                    Group {
                        Image(systemName: "calendar")
                        Text("Published on")
                    }//: GROUP
                    .foregroundColor(.accentColor)
                    .font(Font.system(.body).bold())
                    
                    Spacer(minLength: 20)
                    Text("\(item.publishedDate?.convertToLongDate() ?? "")")
                        .multilineTextAlignment(.trailing)
                }//: HSTACK FOR PUBLISHED DATE
                
                if let url = URL(string: item.link) {
                    Divider().padding(.vertical, 5)
                    HStack(alignment: .top) {
                        Group {
                            Image(systemName: "link")
                            Text("External link")
                        }//: GROUP
                        .foregroundColor(.accentColor)
                        .font(Font.system(.body).bold())
                        
                        Spacer(minLength: 20)
                        Link("Click to see", destination: url)
                        Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
                        
                    }//: HSTACK FOR COMIC NUMBER
                }
            }
        }//: GROUPBOX
    }
}

