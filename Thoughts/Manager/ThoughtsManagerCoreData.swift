//
//  ThoughtsManagerCoreData.swift
//  Thoughts
//
//  Created by Hilmy Veradin on 28/04/22.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa

final class ThoughtsManagerCoreData {
    
    // nanti dibikin conforming to protocol, yang jadi dependency di VM bukan class-nya, tapi protocolnya
    static let shared = ThoughtsManagerCoreData()
    private init() { }
    
    // MARK: - Basic Function
    lazy var managedContext: NSManagedObjectContext = {
        return ThoughtsManagerCoreData.persistentContainer.viewContext
    }()
    
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ThoughtsData")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext () {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - CoreData
    private var textsFromCoreData = BehaviorRelay<[Texts]>(value: [])
    
    // MARK: - return observable todo
    func fetchObservableData() -> Observable<[Texts]> {
        print("Manager: fetch observable data called")
        textsFromCoreData.accept(fetchThoughs())
        return textsFromCoreData.asObservable()
    }
    
    // MARK: - Texts Functions
    func saveThought(titleText: String, descText: String, date: Date) {
        let context = ThoughtsManagerCoreData.shared.managedContext
        let text = Texts(context: context)
        
        text.textTitle = titleText
        text.textDescription = descText
        text.dateInput = date
        
        do {
            try managedContext.save()
            textsFromCoreData.accept(fetchThoughs())
            print("thought saved!")
        } catch {
            fatalError("error saving data")
        }
    }
    
    func deleteAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Texts")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = ThoughtsManagerCoreData.shared.managedContext
        
        do {
            try context.execute(batchDeleteRequest)
            print("deleted")
        } catch {
            print("failed")
        }
    }
    
    func removeTexts(withIndex index: Int) {
        managedContext.delete(textsFromCoreData.value[index])
        
        do {
            try managedContext.save()
            textsFromCoreData.accept(fetchThoughs())
        } catch {
            fatalError("error delete data")
        }
    }
    
    func fetchThoughs() -> [Texts] {
        print("Manager: fetch thoughts called")
        let request = NSFetchRequest<Texts>(entityName: "Texts")
        let texts = try! ThoughtsManagerCoreData.shared.managedContext.fetch(request)
        
        if texts.count > 0 {
            return texts
        } else {
            print("texts.count = 0")
            return []
        }
    }
}
