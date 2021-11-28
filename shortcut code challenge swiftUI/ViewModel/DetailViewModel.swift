//
//  DetailViewModel.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    
    @Published var item: ComicModel
    
    @Published var isFavorite: Bool
    
    init(item: ComicModel) {
        self.item = item
        self.isFavorite = false
    }
    
    @discardableResult
    func checkFavoriteStatus() -> Bool {
        
        let object = Storage.shared.fetchData(for: item.num)
        if let strongObject = object {
            item = strongObject
            self.isFavorite = true
            return true
        }
        return false
    }
    
    func saveComic() {
        Storage.shared.saveData(with: item)
        isFavorite = true
    }
    
    func removeComic() {
        Storage.shared.removeItem(item.num)
        isFavorite = false
    }
    
    func share() {
        if let image = item.image {
            let item = [image]
            let ac = UIActivityViewController(activityItems: item, applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController!.present(ac, animated: true)
        }
    }
}
