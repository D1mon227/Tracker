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
    
    var categoryViewModel: CategoryViewModelProtocol?
    var scheduleViewModel: ScheduleViewModelProtocol?
    var newTrackerViewModel: NewTrackerViewModelProtocol?
    var trackersViewModel: TrackersViewModelProtocol?
    
//    var trackerSchedule: [Int]?
    
    var visibleCategories: [TrackerCategory]? {
        didSet {
            trackersViewModel?.setupVisibleTrackers()
        }
    }
    
    var completedTrackers: [TrackerRecord]? = []
    
    private var categoryName: [String]? {
        didSet {
            categoryViewModel?.getVisibleCategories()
        }
    }
    
    var trackerName: String? {
        didSet {
            newTrackerViewModel?.isNewTrackerReady()
        }
    }
    
    var selectedCategory: String? {
        didSet {
            newTrackerViewModel?.isNewTrackerReady()
        }
    }
    
    var selectedSchedule: String? {
        didSet {
            newTrackerViewModel?.isNewTrackerReady()
        }
    }
    
    var trackerSchedule: [Int]? {
        didSet {
            scheduleViewModel?.isScheduleEmpty()
        }
    }
    
    var trackerEmoji: String? {
        didSet {
            newTrackerViewModel?.isNewTrackerReady()
        }
    }
    
    var trackerColor: UIColor? {
        didSet {
            newTrackerViewModel?.isNewTrackerReady()
        }
    }
    
    func resetNewTrackerInfo() {
        trackerName = nil
        selectedCategory = nil
        selectedSchedule = nil
        trackerEmoji = nil
        trackerColor = nil
        trackerSchedule = nil
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
    
    func didAllFieldsFill() -> Bool {
        trackerName != nil &&
        selectedCategory != nil &&
        trackerEmoji != nil &&
        trackerColor != nil ? true : false
    }
    
    func isCurrentDayFromScheduleExist(_ day: Int) -> Bool {
        guard let trackerSchedule = trackerSchedule else { return false }
        
        return trackerSchedule.contains(day) ? true : false
    }
    
    //MARK: ViewModel
    func updateCategoryViewModel() -> [String] {
        categoryName ?? []
    }
    
    //MARK: TrackerStore:
    func addTrackerToStore(_ tracker: Tracker) {
        trackerStore?.addTracker(model: tracker)
    }
    
    func editTracker(_ id: UUID) {
        guard let name = trackerName,
              let color = trackerColor,
              let emoji = trackerEmoji,
              let schedule = trackerSchedule else { return }
        
        trackerStore?.editTracker(model: Tracker(id: id,
                                                 name: name,
                                                 color: color,
                                                 emoji: emoji,
                                                 schedule: schedule))
    }
    
    func pinTracker(id: UUID) {
        trackerStore?.pinTracker(id: id)
    }
    
    func unpinTracker(id: UUID) {
        trackerStore?.unpinTracker(id: id)
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
    
    func editCategory(oldCategory: String, newCategory: String) {
        trackerCategoryStore?.editCategory(oldCategory: oldCategory, newCategory: newCategory)
    }
    
    func deleteCategory(category: String) {
        trackerCategoryStore?.deleteCategory(category: category)
    }
    
    func fetchCategoryName(index: Int) -> String {
        trackerCategoryStore?.fetchCategoryName(index: index) ?? ""
    }
    
    func getCategoryName() {
        categoryName = trackerCategoryStore?.getCategoriesNames()
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
    
    //MARK: SetupViewModelProtocols
    func bindCategoryViewModel(controller: CategoryViewModelProtocol) {
        categoryViewModel = controller
    }
    
    func bindScheduleViewModel(controller: ScheduleViewModelProtocol) {
        scheduleViewModel = controller
    }
    
    func bindNewTrackerViewModel(controller: NewTrackerViewModelProtocol) {
        newTrackerViewModel = controller
    }
    
    func bindTrackersViewModel(controller: TrackersViewModelProtocol) {
        trackersViewModel = controller
    }
}

