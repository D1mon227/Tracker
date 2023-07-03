//
//  TrackerView.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 25.05.2023.
//

import UIKit

final class TrackersView {
    
    lazy var emptyLabel: UILabel = {
        let element = UILabel()
        element.textColor = .ypBlack
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 12, weight: .medium)
        return element
    }()
    
    lazy var emptyImage: UIImageView = {
        let element = UIImageView()
        //element.image = Resourses.Images.trackerEmptyImage
        return element
    }()
    
    lazy var trackersCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .ypWhite
        collectionView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    lazy var datePicker: UIDatePicker = {
        let element = UIDatePicker()
        element.preferredDatePickerStyle = .compact
        element.datePickerMode = .date
        element.layer.cornerRadius = 8
        element.locale = Locale(identifier: "ru_RU")
        element.calendar.firstWeekday = 2
        return element
    }()
    
    lazy var searchTextField: UISearchTextField = {
        let element = UISearchTextField()
        element.placeholder = "Поиск"
        element.font = .systemFont(ofSize: 17, weight: .regular)
        element.returnKeyType = .search
        element.textColor = .ypBlack
        element.clearButtonMode = .never
        return element
    }()
    
    lazy var cancelButton: UIButton = {
        let element = UIButton(type: .system)
        element.tintColor = .ypBlue
        element.setTitle("Отменить", for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        return element
    }()
    
    lazy var filterButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .ypBlue
        element.tintColor = .white
        element.layer.cornerRadius = 16
        element.setTitle("Фильтры", for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        return element
    }()
}
