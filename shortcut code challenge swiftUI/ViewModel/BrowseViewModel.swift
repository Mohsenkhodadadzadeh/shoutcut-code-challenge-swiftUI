//
//  BrowseVM.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//

import SwiftUI
import Combine

class BrowseViewModel: ObservableObject {
 
    @Published var remoteData: [ComicModel] = []
    
    var latestReceiveId: Int = -1
    
    let comicBunchCount: Int = 20
    
    @Published var comicLoadedCount: Int = 0
    
    init() {
        loadComicBunch(comicId: nil)
    }
    
    func loadComicBunch(comicId: Int? = nil)  {
        comicLoadedCount = 0
        Task.init {
            await getComicData(for: comicId)
        }
    }
    
    @MainActor
    private func getComicData(for comicId: Int?) async {
        
        if let url = Services.urlGenerator(with: comicId) {
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                if let decodedResponse = try? JSONDecoder().decode(ComicModel.self, from: data) {
                    remoteData.append(decodedResponse)
                   
                    comicLoadedCount = comicLoadedCount + 1
                    latestReceiveId = decodedResponse.num
                    if comicLoadedCount < comicBunchCount {
                        if decodedResponse.num > 1 {
                        await getComicData(for: decodedResponse.num - 1)
                        }
                    }
                }
            } catch {
                print("Invalid data")
            }
        }
    }
    
    
}
