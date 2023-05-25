//
//  NewHabitView.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 24.05.2023.
//

import UIKit

final class NewTrackerView {
    
    lazy var newHabitLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 16, weight: .medium)
        element.textColor = .ypBlack
        return element
    }()
    
    lazy var habitNameTextField: UITextField = {
        let element = UITextField()
        element.placeholder = "Введите название трекера"
        element.backgroundColor = .ypBackground
        element.layer.cornerRadius = 16
        element.clearButtonMode = .whileEditing
        element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        element.leftViewMode = .always
        element.returnKeyType = .go
        element.font = .systemFont(ofSize: 17, weight: .regular)
        element.textColor = .ypBlack
        return element
    }()
    
    lazy var categoryAndScheduleTableView: UITableView = {
        let element = UITableView()
        element.separatorStyle = .singleLine
        element.layer.cornerRadius = 16
        return element
    }()
    
    lazy var collectionView: UICollectionView = {
        let element = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        element.backgroundColor = .ypWhite
        return element
    }()
    
    lazy var cancelButton: UIButton = {
        let element = UIButton()
        element.layer.cornerRadius = 16
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.ypRed.cgColor
        element.setTitle("Отменить", for: .normal)
        element.titleLabel?.textAlignment = .center
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.backgroundColor = .ypWhite
        element.setTitleColor(.ypRed, for: .normal)
        return element
    }()
    
    lazy var createButton: UIButton = {
        let element = UIButton()
        element.layer.cornerRadius = 16
        element.setTitle("Создать", for: .normal)
        element.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        element.setTitleColor(.white, for: .normal)
        element.backgroundColor = .ypGray
        return element
    }()
}
