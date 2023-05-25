//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 24.05.2023.
//

import UIKit
import SnapKit

enum TypeOfTracker {
    case habit
    case unregularEvent
}

final class NewTrackerViewController: UIViewController {
    
    private let tableViewTitle = ["Категория", "Расписание"]
    private let newTrackerView = NewTrackerView()
    var tracker: TypeOfTracker?
    
    var emojies: [String] = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪",
        ]
    
    var colors: [UIColor] = [
        .colorSelection1, .colorSelection2, .colorSelection3, .colorSelection4, .colorSelection5, .colorSelection6,
        .colorSelection7, .colorSelection8, .colorSelection9, .colorSelection10, .colorSelection11, .colorSelection12,
        .colorSelection13, .colorSelection14, .colorSelection15, .colorSelection16, .colorSelection17, .colorSelection18,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupCollectionView()
    }
    
    private func setupTableView() {
        newTrackerView.categoryAndScheduleTableView.register(NewTrackerTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        newTrackerView.categoryAndScheduleTableView.dataSource = self
        newTrackerView.categoryAndScheduleTableView.delegate = self
    }
    
    private func setupCollectionView() {
        newTrackerView.collectionView.register(NewTrackerEmojiCollectionViewCell.self, forCellWithReuseIdentifier: "EmojiCollectionViewCell")
        newTrackerView.collectionView.register(NewTrackerColorsCollectionViewCell.self, forCellWithReuseIdentifier: "ColorsCollectionViewCell")
        newTrackerView.collectionView.register(NewTrackerSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        newTrackerView.collectionView.dataSource = self
        newTrackerView.collectionView.delegate = self
    }
    
    @objc private func switchToCategoryViewController() {
        let categoryVC = CategoryViewController()
        present(categoryVC, animated: true)
    }
    
    @objc private func switchToScheduleViewController() {
        let scheduleVC = ScheduleViewController()
        present(scheduleVC, animated: true)
    }
}

extension NewTrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tracker {
        case .habit:
            return 2
        case .unregularEvent:
            return 1
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? NewTrackerTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(text: tableViewTitle[indexPath.row])
        cell.backgroundColor = .ypBackground
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension NewTrackerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            switchToCategoryViewController()
        case IndexPath(row: 1, section: 0):
            switchToScheduleViewController()
        default:
            return
        }
    }
}

extension NewTrackerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return emojies.count
        case 1:
            return colors.count
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionViewCell", for: indexPath) as? NewTrackerEmojiCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureCell(emoji: emojies[indexPath.row])
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorsCollectionViewCell", for: indexPath) as? NewTrackerColorsCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureCell(color: colors[indexPath.row])
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
        default:
            id = ""
        }
        
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: id,
                                                                         for: indexPath) as? NewTrackerSupplementaryView else { return UICollectionReusableView() }
        switch indexPath.section {
        case 0:
            view.headerLabel.text = "Emoji"
        case 1:
            view.headerLabel.text = "Цвет"
        default:
            view.headerLabel.text = ""
        }
        
        return view
    }
}

extension NewTrackerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: 32, height: 38)
        case 1:
            return CGSize(width: 40, height: 40)
        default:
            return CGSize(width: 40, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 14
        case 1:
            return 12
        default:
            return 14
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 25
        case 1:
            return 17
        default:
            return 25
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: collectionView.frame.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 29, bottom: 47, right: 29)
        case 1:
            return UIEdgeInsets(top: 0, left: 25, bottom: 47, right: 25)
        default:
            return UIEdgeInsets(top: 0, left: 29, bottom: 47, right: 29)
        }
    }
}

extension NewTrackerViewController {
    private func setupViews() {
        view.backgroundColor = .ypWhite
        view.addSubview(newTrackerView.newHabitLabel)
        view.addSubview(newTrackerView.habitNameTextField)
        view.addSubview(newTrackerView.categoryAndScheduleTableView)
        view.addSubview(newTrackerView.collectionView)
        view.addSubview(newTrackerView.cancelButton)
        view.addSubview(newTrackerView.createButton)
        addConstraints()
        setupTitle()
    }
    
    private func setupTitle() {
        newTrackerView.newHabitLabel.text = tracker == .habit ? "Новая привычка" : "Новое нерегулярное событие"
    }
    
    private func addConstraints() {
        newTrackerView.newHabitLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        newTrackerView.habitNameTextField.snp.makeConstraints { make in
            make.top.equalTo(newTrackerView.newHabitLabel.snp.bottom).offset(38)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(75)
        }
        
        newTrackerView.categoryAndScheduleTableView.snp.makeConstraints { make in
            if tracker == .habit {
                make.height.equalTo(150)
            } else {
                make.height.equalTo(75)
                newTrackerView.categoryAndScheduleTableView.separatorStyle = .none
            }
            
            make.top.equalTo(newTrackerView.habitNameTextField.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        newTrackerView.collectionView.snp.makeConstraints { make in
            make.top.equalTo(newTrackerView.categoryAndScheduleTableView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(newTrackerView.cancelButton.snp.top).offset(-16)
        }
        
        newTrackerView.cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(60)
            make.trailing.equalTo(newTrackerView.createButton.snp.leading).offset(-8)
        }
        
        newTrackerView.createButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(newTrackerView.cancelButton.snp.width)
        }
    }
}
