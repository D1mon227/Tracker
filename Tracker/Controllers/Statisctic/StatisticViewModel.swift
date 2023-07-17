//
//  StatisticViewModel.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 17.07.2023.
//

import Foundation

final class StatisticViewModel: StatisticViewModelProtocol {
    private let dataProvider = DataProvider.shared
    
    init() {
        dataProvider.bindStatisticViewModel(controller: self)
    }
}
