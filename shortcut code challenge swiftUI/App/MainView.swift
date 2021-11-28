//
//  MainView.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import SwiftUI

struct MainView: View {
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        TabView {
            BrowseView()
                .tabItem {
                    Image(systemName: "photo.on.rectangle.angled")
                    Text("Browse")
                }
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorite")
                }
        }//: TABVIEW
    }
}
