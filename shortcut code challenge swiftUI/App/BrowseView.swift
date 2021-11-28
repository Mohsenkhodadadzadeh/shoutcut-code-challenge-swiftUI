//
//  BrowseView.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import SwiftUI
import Combine

struct BrowseView: View {
    
    @ObservedObject var viewModel: BrowseViewModel = BrowseViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.remoteData, id: \.num) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        ListItemView(item: item)
                        
                    }
                    
                }//: FOREACH
                if viewModel.comicLoadedCount >= (viewModel.comicBunchCount ) {
                    Rectangle()
                        .onAppear {
                            print("count is: \(viewModel.comicLoadedCount)")
                            viewModel.comicLoadedCount = 0
                            viewModel.loadComicBunch(comicId: viewModel.remoteData.last?.num)
                        }
                }
            }//: LIST
            .navigationBarTitle("Browse Comics", displayMode: .large)
        }//: NAVIGATIONVIEW
        
    }
}
