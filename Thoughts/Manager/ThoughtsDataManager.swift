////
////  ThoughtsDataManager.swift
////  Thoughts
////
////  Created by Hilmy Veradin on 26/04/22.
////
//
//import Foundation
//import CoreData
//
//class ThoughtsDataManager {
//  
//  //MARK: - Properties
//  static let shared = ThoughtsDataManager()
//  
//  //MARK: - Basic Function
//  lazy var managedContext: NSManagedObjectContext = {
//    return ThoughtsDataManager.persistentContainer.viewContext
//  }()
//  
//  private static var persistentContainer: NSPersistentContainer = {
//    let container = NSPersistentContainer(name: "ThoughtsData")
//    container.loadPersistentStores { _, error in
//      if let error = error as NSError? {
//        print("Unresolved error \(error), \(error.userInfo)")
//      }
//    }
//    return container
//  }()
//  
//  func saveContext () {
//    guard managedContext.hasChanges else { return }
//    
//    do {
//      try managedContext.save()
//    } catch let error as NSError {
//      print("Unresolved error \(error), \(error.userInfo)")
//    }
//  }
//  
//  //MARK: - Title Manager
//  func inserTitle(titleText: String) {
//    let context = ThoughtsDataManager.shared.managedContext
//    let text = Texts(context: context)
//    
//    text.textTitle = titleText
//    saveContext()
//  }
//  
//  //MARK: - Description Manager
//  func insertDescription(descText: String) {
//    let context = ThoughtsDataManager.shared.managedContext
//    let text = Texts(context: context)
//    
//    text.textDescription = descText
//    saveContext()
//  }
//  
//  //MARK: - Date Manager
//  func insertDate(date: Date) {
//    let context = ThoughtsDataManager.shared.managedContext
//    let text = Texts(context: context)
//    
//    text.dateInput = date
//    saveContext()
//  }
//  
//  //MARK: - Add Thoughts Functions
//  func saveThought(titleText: String, descText: String, date: Date) {
//    let context = ThoughtsDataManager.shared.managedContext
//    let text = Texts(context: context)
//    
//    text.textTitle = titleText
//    text.textDescription = descText
//    text.dateInput = date
//    
//    saveContext()
//  }
//  
//  func fetchThoughsController() -> NSFetchedResultsController<Texts> {
//    let request = NSFetchRequest<Texts>(entityName: "Texts")
//    let texts = try! ThoughtsManagerCoreData.shared.managedContext.fetch(request)
//    
//    print(texts.count)
//    
//    
//    let fetchRequest: NSFetchRequest<Texts> = Texts.fetchRequest()
//    
//    let context = ThoughtsDataManager.shared.managedContext
//    let dateSort = NSSortDescriptor(key: #keyPath(Texts.dateInput), ascending: false)
//    
//    fetchRequest.sortDescriptors = [dateSort]
//    
//    let fetchedResultsController = NSFetchedResultsController(
//      fetchRequest: fetchRequest,
//      managedObjectContext: context,
//      sectionNameKeyPath: nil,
//      cacheName: nil)
//    
//    return fetchedResultsController
//  }
//  
//  
//}
