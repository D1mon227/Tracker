//
//  StatisticServiceProtocol.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 17.07.2023.
//

import Foundation

protocol StatisticServiceProtocol: AnyObject {
    var statisticModel: TrackerStatistic? { get }
    func provideStatisticModel(record: [TrackerRecord]?)
    func removeAllStatistics()
}
