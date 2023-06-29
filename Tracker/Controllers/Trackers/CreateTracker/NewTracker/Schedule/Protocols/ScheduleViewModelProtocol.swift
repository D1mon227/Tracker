//
//  ScheduleViewModelProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.06.2023.
//

import Foundation

protocol ScheduleViewModelProtocol: AnyObject {
    func addDaysToSchedule(day: Int)
    func removeDayFromSchedule(index: Int)
    func setSchedule()
}
