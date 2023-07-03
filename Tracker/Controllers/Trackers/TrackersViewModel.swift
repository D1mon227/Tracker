//
//  TrackersViewModel.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 28.06.2023.
//

import UIKit

final class TrackersViewModel: TrackersViewModelProtocol {
  
    private let dataProvider = DataProvider.shared
    private let dateService = DateService()
    
    var currentDate: Date? {
        didSet {
            filterTrackers(text: "")
            emptyImage = Resourses.Images.trackerEmptyImage
            emptyLabel = "Что будем отслеживать?"
        }
    }
    
    var numberOfVisibleCategories: Int {
        visibleCategories.count
    }
    
    var emptyImage: UIImage?
    var emptyLabel: String?
    var searchText: String? {
        didSet {
            filterTrackers(text: searchText)
            emptyImage = Resourses.Images.searchEmptyImage
            emptyLabel = "Ничего не найдено"
        }
    }
    
    @TrackersObservable
    private(set) var visibleCategories: [TrackerCategory] = []
    
    init() {
        dataProvider.trackerStore = TrackerStore()
        dataProvider.trackerCategoryStore = TrackerCategoryStore()
        dataProvider.trackerRecordStore = TrackerRecordStore()
        dataProvider.fetchVisibleCategoriesFromStore()
        dataProvider.getCategoryName()
        dataProvider.fetchRecordFromStore()
        dataProvider.bindTrackersViewModel(controller: self)
    }
    
    func areVisibleCategoriesEmpty() -> Bool {
        if visibleCategories.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func fetchCompletedCategoriesFromStore() {
        dataProvider.fetchRecordFromStore()
    }
    
    func getCompletedCategories() -> [TrackerRecord] {
        dataProvider.getCompletedTrackers()
    }
    
    func deleteTracker(id: UUID) {
        dataProvider.deleteTrackerFromStore(id: id)
    }
    
    func setupVisibleTrackers() {
        visibleCategories = dataProvider.getVisibleCategories()
    }
    
    func addRecord(tracker: TrackerRecord) {
        dataProvider.addRecord(record: tracker)
    }
    
    func deleteRecord(tracker: TrackerRecord) {
        dataProvider.deleteRecord(tracker: tracker)
    }
    
    func checkDate() -> Bool {
        guard let currentDate = currentDate else { return false }
        let date = Date()
        
        return date > currentDate
    }
    
    func filterTrackers(text: String?) {
        guard let date = currentDate,
              let text = text?.lowercased() else { return }
        
        setupVisibleTrackers()
        visibleCategories = visibleCategories.compactMap { category in
            let filterTrackers = category.trackerArray.filter { tracker in
                guard let schedule = tracker.schedule else { return false }
                let filterText = text.isEmpty || tracker.name.lowercased().contains(text)
                let trackerDate = dateService.getNumberOfSelectedDay(date: date)
                
                return schedule.contains(trackerDate) && filterText
            }
            
            if filterTrackers.isEmpty {
                return nil
            }
            
            return TrackerCategory(name: category.name,
                                   trackerArray: filterTrackers)
        }
    }
    
}
