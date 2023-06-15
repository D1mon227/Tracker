//
//  DataProvider.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 09.06.2023.
//

import UIKit

struct CollectionStoreUpdate {
    let insertedIndexes: IndexSet
    let deletedIndexes: IndexSet
}

final class DataProvider {
    static let shared = DataProvider()
    
    var trackerStore: TrackerStoreProtocol?
    var trackerCategoryStore: TrackerCategoryStoreProtocol?
    var trackerRecordStore: TrackerRecordStoreProtocol?
    
    var selectedCategory: String?
    var selectedSchedule: String?
    
    var trackerName: String?
    var trackerEmoji: String?
    var trackerColor: UIColor?
    var schedule: [Int]?
    
    var categories: [TrackerCategory]? = []
    var visibleCategories: [TrackerCategory]? = []
    var completedTrackers: [TrackerRecord]? = []
    
    var emojies = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    var colors: [UIColor] = [
        .colorSelection1, .colorSelection2, .colorSelection3, .colorSelection4, .colorSelection5, .colorSelection6,
        .colorSelection7, .colorSelection8, .colorSelection9, .colorSelection10, .colorSelection11, .colorSelection12,
        .colorSelection13, .colorSelection14, .colorSelection15, .colorSelection16, .colorSelection17, .colorSelection18,
    ]
    
    func resetNewTrackerInfo() {
        trackerName = nil
        selectedCategory = nil
        selectedSchedule = nil
        trackerEmoji = nil
        trackerColor = nil
        schedule = nil
    }
    
    func setTrackerStoreDelegate(view: TrackersDelegate) {
        trackerStore?.delegate = view
    }
    
    func getVisibleCategories() -> [TrackerCategory] {
        visibleCategories ?? []
    }
    
    func fetchVisibleCategoriesFromStore() {
        visibleCategories = trackerStore?.fetchTrackers()
    }
    
    func getCompletedTrackers() -> [TrackerRecord] {
        completedTrackers ?? []
    }
    
    //MARK: TrackerStore:
    func addTrackerToStore(_ tracker: Tracker) {
        trackerStore?.addTracker(tracker)
    }
    
    func deleteTrackerFromStore(id: UUID) {
        trackerStore?.deleteTracker(id: id)
    }
    
    func getTracker(category: String, index: Int) -> Tracker {
        let tracker = trackerStore?.getTracker(category: category, index: index)
        
        return Tracker(id: tracker?.id ?? UUID(),
                       name: tracker?.name ?? "",
                       color: tracker?.color ?? .clear,
                       emoji: tracker?.emoji ?? "",
                       schedule: tracker?.schedule)
    }
    
    //MARK: TrackerCategoryStore:
    var numberOfCategories: Int {
        trackerCategoryStore?.numberOfCategories ?? 0
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        trackerCategoryStore?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func addCategory(category: String) {
        trackerCategoryStore?.addCategory(category: category)
    }
    
    func fetchCategoryName(index: Int) -> String {
        trackerCategoryStore?.fetchCategoryName(index: index) ?? ""
    }
    
    func fetchNewCategoryName(category: String) -> TrackerCategoryCoreData? {
        trackerCategoryStore?.fetchNewCategoryName(name: category)
    }
    
    //MARK: TrackerRecordStore:
    func addRecord(record: TrackerRecord) {
        trackerRecordStore?.addTrackerRecord(tracker: record)
    }
    
    func deleteRecord(tracker: TrackerRecord) {
        trackerRecordStore?.deleteTrackerRecord(tracker: tracker)
    }
    
    func fetchRecordFromStore() {
        completedTrackers = trackerRecordStore?.fetchTrackerRecords()
    }
    
}

