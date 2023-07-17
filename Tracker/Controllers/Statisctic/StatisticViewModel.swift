//
//  StatisticViewModel.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 17.07.2023.
//

import Foundation

final class StatisticViewModel: StatisticViewModelProtocol {
    
    private let dataProvider = DataProvider.shared
    
    @Observable
    private(set) var isStatisticsExist: Bool?
    @Observable
    private(set) var recordModel: TrackerStatistic?
    
    init() {
        dataProvider.bindStatisticViewModel(controller: self)
    }
    
    func isStatisticExists() {
        let statisticModel = dataProvider.getRecordsStatisticModel()
        if statisticModel.totalCompletedTrackers != 0 {
            isStatisticsExist = true
            recordModel = statisticModel
        } else {
            isStatisticsExist = false
        }
    }
}
