//
//  Storage.swift
//  shortcut code challenge swiftUI
//
//  Created by Mohsen on 11/28/21.
//


import SwiftUI
import CoreData

public final class Storage {
    private var viewContext = PersistenceController.shared.container.viewContext
    
    public static var shared: Storage = Storage()
    
    private init() { }
    
    public func fetchAll() -> [ComicModel]{
        let fetch = prepareFetchRequestForComicEntity(query: "num > -1")
        var retObj: [ComicModel] = []
        if let fetchData = try? viewContext.fetch(fetch) {
            for item in fetchData {
                var image: UIImage?
                if let imageData = item.imageData {
                    image = UIImage(data: imageData)
                }
                let dbData: ComicModel = ComicModel(num: Int(item.num), description: item.comicDescription ?? "" , publishedDate: item.publishedDate ?? Date(), link: item.link ?? "", image: image, news: item.news ?? "", safeTitle: item.safeTitle ?? "", title: item.title ?? "", transcript: item.transcript ?? "")
                retObj.append(dbData)
            }
        }
        return retObj
    }
    
    public func fetchData(for id: Int) -> ComicModel? {
        
        let fetch = prepareFetchRequestForComicEntity(query: "num == \(id)")
        var retObj: ComicModel? = nil
        if let fetchData = try? viewContext.fetch(fetch), let item = fetchData.first {
                var image: UIImage?
                if let imageData = item.imageData {
                    image = UIImage(data: imageData)
                }
                let dbData: ComicModel = ComicModel(num: Int(item.num), description: item.comicDescription ?? "" , publishedDate: item.publishedDate ?? Date(), link: item.link ?? "", image: image, news: item.news ?? "", safeTitle: item.safeTitle ?? "", title: item.title ?? "", transcript: item.transcript ?? "")
                retObj = dbData
            
        }
        return retObj
    }
    
    @discardableResult
    public func saveData(with item: ComicModel) -> Bool {
        
        let fetch = prepareFetchRequestForComicEntity(query: "num == \(item.num)")
        let count = try! viewContext.count(for: fetch)
        
        if count > 0 {
            return false
        }//: row has been saved before
        
        let entity = NSEntityDescription.entity(forEntityName: "ComicEntity", in: viewContext)!
        let newItem = ComicEntity(entity: entity, insertInto: viewContext)
        
        newItem.num = Int32(item.num)
        newItem.title = item.title
        newItem.comicDescription = item.description
        newItem.link = item.link
        newItem.news = item.news
        newItem.publishedDate = item.publishedDate
        newItem.safeTitle = item.safeTitle
        newItem.transcript = item.transcript
        let photoData = item.image?.pngData()
        newItem.imageData = photoData
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return true
    }
    
    @discardableResult
    public func removeItem(_ itemIndex: Int) -> Bool {
        
        let fetch = prepareFetchRequestForComicEntity(query: "num == \(itemIndex)")
        
        if let object = (try? viewContext.fetch(fetch))?.first {
            viewContext.delete(object)
        }
        do {
            try viewContext.save()
        } catch {
            return false
        }
        return true
        
    }
    
    
    private func prepareFetchRequestForComicEntity(query: String) -> NSFetchRequest<ComicEntity> {
        let fetch = NSFetchRequest<ComicEntity>(entityName: "ComicEntity")
        fetch.predicate = NSPredicate(format: query)
        return fetch
    }
    
}
