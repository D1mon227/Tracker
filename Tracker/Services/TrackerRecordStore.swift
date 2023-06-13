//
//  TrackerRecordStore.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 09.06.2023.
//

import UIKit
import CoreData

final class TrackerRecordStore: NSObject {
    
    private let context: NSManagedObjectContext
    private var insertedIndexes: IndexSet?
    private var deletedIndexes: IndexSet?
    
    private let dataProvider = DataProvider.shared
    
    private lazy var appDelegate = {
        (UIApplication.shared.delegate as! AppDelegate)
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController<TrackerRecordCoreData> = {
        let fetchRequest = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
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
    
    func addTrackerRecord(tracker: TrackerRecord) {
        if !isRecordExist(tracker: tracker) {
            let record = TrackerRecordCoreData(context: context)
            record.id = tracker.id
            record.date = tracker.date
            
            appDelegate.saveContext()
        }
    }
    
    func fetchTrackerRecords() -> [TrackerRecord] {
        guard let records = fetchedResultsController.fetchedObjects else { return [] }
        
        var currentRecord: [TrackerRecord] = []
        
        for record in records {
            currentRecord.append(TrackerRecord(id: record.id ?? UUID(),
                                               date: record.date ?? Date()))
        }
        return currentRecord
    }
    
    func isRecordExist(tracker: TrackerRecord) -> Bool {
        guard let objects = fetchedResultsController.fetchedObjects else { return false }
        
        var result = false
        
        objects.forEach { object in
            if object.id == tracker.id &&
                object.date == tracker.date {
                result = true
            }
        }
        return result
    }
}

extension TrackerRecordStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
}
