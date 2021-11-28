//
//  DetailView.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var imageLoader: RemoteDownloader
    
    @ObservedObject var viewModel: DetailViewModel
    
    //@State private var image:UIImage = UIImage()
    
    init(item: ComicModel) {
        self.viewModel = DetailViewModel(item: item)
        self.imageLoader = RemoteDownloader()
    }
    // @State var isShowNavBar: Bool = false
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 20) {
                
                Image(uiImage: viewModel.item.image == nil ? UIImage() : viewModel.item.image!)
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 20)
                    .frame(height: 300)
                    .onReceive(imageLoader.didChange) { data in
                        print("Data received")
                        self.viewModel.item.image = UIImage(data: data) ?? UIImage()
                    }
                    .onAppear {
                        if !viewModel.checkFavoriteStatus() {
                            imageLoader.download(urlString: viewModel.item.imageAddress, downloadStatus: viewModel.item.image != nil)
                        }
                        
                    }
                
                Text(viewModel.item.safeTitle.uppercased())
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)
                    .foregroundColor(.primary)
                    .background(
                        Color.accentColor
                            .frame(height:6)
                            .offset(y: 24)
                    )
                
                ComicExtraExplainView(item: viewModel.item)
                
                Text(viewModel.item.description)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.accentColor)
                    .padding(.horizontal)
                
                
                
            }//: VSTACK
            
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle(viewModel.item.safeTitle, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                if viewModel.item.image != nil {
                    viewModel.isFavorite ? viewModel.removeComic() : viewModel.saveComic()
                }
                print("item ables to save: \(viewModel.item.image != nil)")
            }, label: {
                Image(systemName: viewModel.isFavorite ? "bookmark.fill" : "bookmark")
                //  Text("Save")
            }))
            .navigationBarItems(trailing: Button(action: {
                if viewModel.item.image != nil {
                    viewModel.share()
                }
            }, label: {
                Image(systemName: "square.and.arrow.up")
                //   Text("Share")
            }))
        }//: SCROLLVIEW
        
    }
}
