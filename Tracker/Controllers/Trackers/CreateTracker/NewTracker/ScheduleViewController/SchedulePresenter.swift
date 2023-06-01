//
//  SchedulePresenter.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 01.06.2023.
//

import Foundation

final class SchedulePresenter: ScheduleViewPresenterProtocol {
    var daysInInt: [Int] = []
    var days: [String] = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
}
