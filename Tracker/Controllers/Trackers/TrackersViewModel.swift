//
//  TrackersViewModel.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 28.06.2023.
//

import Foundation

final class TrackersViewModel: TrackersViewModelProtocol {
  
    private let dataProvider = DataProvider.shared
    
    var currentDate: Date?
    
}
