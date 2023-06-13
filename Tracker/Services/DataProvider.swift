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
    
    var selectedCategory: String?
    var selectedSchedule: String?
    
    var trackerName: String?
    var trackerEmoji: String?
    var trackerColor: UIColor?
    var schedule: [Int]?
    
    var categories: [TrackerCategory]? = [
//        TrackerCategory(name: "Важное", trackerArray: [Tracker(id: UUID(),
//                                                               name: "Учиться делать iOS-приложения",
//                                                               color: .colorSelection1,
//                                                               emoji: "🐶",
//                                                               schedule: [ 2, 4, 6]),
//                                                       Tracker(id: UUID(),
//                                                               name: "Получить права",
//                                                               color: .colorSelection2,
//                                                               emoji: "😻",
//                                                               schedule: [ 3, 5, 6, 7])]),
//        TrackerCategory(name: "Уборка", trackerArray: [Tracker(id: UUID(),
//                                                               name: "Полить цветы",
//                                                               color: .colorSelection3,
//                                                               emoji: "🍔",
//                                                               schedule: [3, 4, 5, 6, 7]),
//                                                       Tracker(id: UUID(),
//                                                               name: "Влажная уборка",
//                                                               color: .colorSelection4,
//                                                               emoji: "😇",
//                                                               schedule: [ 4, 6])])
    ]
    
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
    
    func getVisibleCategories() -> [TrackerCategory] {
        visibleCategories ?? []
    }
    
    func fetchVisibleCategoriesFromStore() {
        visibleCategories = trackerStore?.fetchTrackers()
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
    
    
}

