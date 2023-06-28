//
//  ScheduleViewModel.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.06.2023.
//

import Foundation

final class ScheduleViewModel: ScheduleViewModelProtocol {
    private let dataProvider = DataProvider.shared
    private let scheduleService = ScheduleService()
    
    @ScheduleObservable
    private(set) var schedule: [Int] = []
    
    init() {
        dataProvider.bindScheduleViewModel(controller: self)
    }
    
    func addDaysToSchedule(day: Int) {
        schedule.append(day)
    }
    
    func removeDayFromSchedule(index: Int) {
        schedule.remove(at: index)
    }
    
    func setSchedule() {
        let scheduleDay = schedule.count == 7 ? "Каждый день" : scheduleService.arrayToString(array: schedule)
        dataProvider.selectedSchedule = scheduleDay
        dataProvider.trackerSchedule = schedule
        
        schedule = []
    }
}
