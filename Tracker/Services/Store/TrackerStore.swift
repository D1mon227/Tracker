//
//  TrackerStore.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 09.06.2023.
//

import UIKit
import CoreData

final class TrackerStore: NSObject, TrackerStoreProtocol {
    
    private let context: NSManagedObjectContext
    private var insertedIndexes: IndexSet?
    private var deletedIndexes: IndexSet?
    private var section: Int?
    
    private let uiColorMarshalling = UIColorMarshalling()
    private let dataProvider = DataProvider.shared
    
    private lazy var appDelegate = {
        (UIApplication.shared.delegate as! AppDelegate)
    }()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<TrackerCoreData> = {
        let fetchRequest = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category.name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: "category.name",
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        return fetchedResultsController
    }()
    
    convenience override init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistantContainer.viewContext
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addTracker(_ model: Tracker) {
        let trackerCoreData = TrackerCoreData(context: context)
        let category = dataProvider.fetchNewCategoryName(category: dataProvider.selectedCategory ?? "")
        
        trackerCoreData.id = model.id
        trackerCoreData.name = model.name
        trackerCoreData.emoji = model.emoji
        trackerCoreData.color = uiColorMarshalling.hexString(from: model.color)
        trackerCoreData.schedule = model.schedule
        trackerCoreData.category = category
        
        appDelegate.saveContext()
    }
    
    func getTracker(category: String, index: Int) -> Tracker {
        let section = fetchedResultsController.sections?.first(where: { section in
            section.name == category
        })
        
        let tracker = section?.objects?[index] as? TrackerCoreData
        return Tracker(id: tracker?.id ?? UUID(),
                       name: tracker?.name ?? "",
                       color: uiColorMarshalling.color(from: tracker?.color ?? ""),
                       emoji: tracker?.emoji ?? "",
                       schedule: tracker?.schedule ?? [])
    }
    
    func fetchTrackers() -> [TrackerCategory] {
        guard let sections = fetchedResultsController.sections else { return [] }
        
        var currentCategory: [TrackerCategory] = []
        
        for section in sections {
            guard let object = section.objects as? [TrackerCoreData] else { return [] }
            var category = TrackerCategory(name: section.name, trackerArray: [] )
            
            for tracker in object {
                category.trackerArray.append(Tracker(id: tracker.id ?? UUID(),
                                                     name: tracker.name ?? "",
                                                     color: uiColorMarshalling.color(from: tracker.color ?? ""),
                                                     emoji: tracker.emoji ?? "",
                                                     schedule: tracker.schedule))
            }
            currentCategory.append(category)
        }
        
        return currentCategory
    }
    
    func deleteTracker(id: UUID) {
        guard let object = fetchedResultsController.fetchedObjects?.first(where: { trackerCoreData in
            trackerCoreData.id == id
        }) else { return }
        
        context.delete(object)
        appDelegate.saveContext()
    }
}

extension TrackerStore: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dataProvider.fetchVisibleCategoriesFromStore()
    }
}
