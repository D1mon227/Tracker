//
//  NewTrackerView.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 24.05.2023.
//

import UIKit

final class CreateTrackerView {
    lazy var createTrackerLabel: UILabel = {
        let element = UILabel()
        element.text = "Создание трекера"
        element.font = .systemFont(ofSize: 16, weight: .medium)
        element.textColor = .ypBlack
        return element
    }()
    
    lazy var habitButton: UIButton = {
        let element = UIButton(type: .system)
        element.layer.cornerRadius = 16
        element.setTitle("Привычка", for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.titleLabel?.textAlignment = .center
        element.backgroundColor = .ypBlack
        element.tintColor = .ypWhite
        return element
    }()
    
    lazy var unregularEventButtton: UIButton = {
        let element = UIButton(type: .system)
        element.layer.cornerRadius = 16
        element.setTitle("Нерегулярное событие", for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.titleLabel?.textAlignment = .center
        element.backgroundColor = .ypBlack
        element.tintColor = .ypWhite
        return element
    }()
}
