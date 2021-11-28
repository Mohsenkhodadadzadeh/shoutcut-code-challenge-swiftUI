//
//  FavoriteView.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var viewModel: FavoriteViewModel = FavoriteViewModel()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(viewModel.items, id: \.num) { item in
                    NavigationLink(destination: DetailView(item: item)
                    ) {
                        ListItemView(item: item)
                    }
                    
                }//: FOREACH
                .onDelete(perform: viewModel.removeComic)
                
            }//: LIST
            .navigationBarTitle("Favorite Comics", displayMode: .large)
            .onAppear {
                viewModel.fetchObjects()
            }
        }//: NAVIGATIONVIEW
    }
}
