//
//  TrackerViewPreseneter.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 29.05.2023.
//

import Foundation

final class TrackerViewPresenter: TrackerViewPresenterProtocol {
    var categories: [TrackerCategory]? = [TrackerCategory(name: "Важное",
                                                          trackerArray: [Tracker(id: UUID(),
                                                                                 name: "Учиться делать iOS-приложения",
                                                                                 color: .colorSelection1,
                                                                                 emoji: "🐶",
                                                                                 schedule: nil)])]
    var emojies = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
}
