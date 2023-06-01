//
//  ScheduleViewControllerDelegate.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import Foundation

protocol ScheduleViewControllerDelegate: Any {
    func addDaysToSchedule(cell: ScheduleTableViewCell)
}
