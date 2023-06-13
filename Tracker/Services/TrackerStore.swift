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
    private let dataProvider = DataProvider()
    
    weak var delegate: TrackersDelegate?
    
    private lazy var appDelegate = {
        (UIApplication.shared.delegate as! AppDelegate)
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController<TrackerCoreData> = {
        let fetchRequest = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "category.name", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: nil,
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
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        insertedIndexes = IndexSet()
        deletedIndexes = IndexSet()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let insertedIndexes = insertedIndexes,
              let deletedIndexes = deletedIndexes,
              let section = section else { return }
        
        dataProvider.fetchVisibleCategoriesFromStore()
        
        delegate?.didUpdate(CollectionStoreUpdate(insertedIndexes: insertedIndexes,
                                                  deletedIndexes: deletedIndexes),
                            section: section)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                insertedIndexes?.insert(indexPath.item)
            }
        case .delete:
            if let indexPath = indexPath {
                deletedIndexes?.insert(indexPath.item)
            }
        default:
            break
        }
    }
}
