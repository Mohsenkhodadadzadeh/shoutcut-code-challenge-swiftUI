//
//  FavoriteViewModel.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import SwiftUI

class FavoriteViewModel: ObservableObject {
    
    @Published var items: [ComicModel] = []
    
    
    func fetchObjects() {
        items = Storage.shared.fetchAll()
    }
    
    func removeComic(offsets: IndexSet)  {
        if let index = offsets.first, let obj = items[safe: index] {
            Storage.shared.removeItem(obj.num)
            items = Storage.shared.fetchAll()
        }
    }
    
}
