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

final class NewTrackerViewController: UIViewController, NewTrackerViewControllerProtocol {
    var trackerPresenter: TrackerViewPresenterProtocol?
    var presenter: NewTrackerViewPresenterProtocol?
    private let newTrackerView = NewTrackerView()
    var tracker: TypeOfTracker?
    
    var selectedCategory: String?
    var selectedSchedule: String?
    
    var trackerName: String?
    var trackerEmoji: String?
    var trackerColor: UIColor?
    
    var colors: [UIColor] = [
        .colorSelection1, .colorSelection2, .colorSelection3, .colorSelection4, .colorSelection5, .colorSelection6,
        .colorSelection7, .colorSelection8, .colorSelection9, .colorSelection10, .colorSelection11, .colorSelection12,
        .colorSelection13, .colorSelection14, .colorSelection15, .colorSelection16, .colorSelection17, .colorSelection18,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
        presenter = NewTrackerViewPresenter()
        
        setupViews()
        setupTableView()
        setupCollectionView()
        setupTextField()
        setupTarget()
    }
    
    private func setupTableView() {
        newTrackerView.categoryAndScheduleTableView.register(NewTrackerTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        newTrackerView.categoryAndScheduleTableView.dataSource = self
        newTrackerView.categoryAndScheduleTableView.delegate = self
    }
    
    private func setupCollectionView() {
        newTrackerView.collectionView.register(NewTrackerCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        newTrackerView.collectionView.register(NewTrackerSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        newTrackerView.collectionView.dataSource = self
        newTrackerView.collectionView.delegate = self
    }
    
    private func setupTextField() {
        newTrackerView.habitNameTextField.delegate = self
    }
    
    private func setupTarget() {
        newTrackerView.cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc private func switchToCategoryViewController() {
        let categoryVC = CategoryViewController()
        categoryVC.presenter = trackerPresenter
        categoryVC.viewController = self
        present(categoryVC, animated: true)
    }
    
    @objc private func switchToScheduleViewController() {
        let scheduleVC = ScheduleViewController()
        scheduleVC.viewController = self
        present(scheduleVC, animated: true)
    }
    
    func reloadTableView() {
        newTrackerView.categoryAndScheduleTableView.reloadData()
    }
}

extension NewTrackerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newTrackerView.habitNameTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            newTrackerView.createButton.isEnabled = true
            newTrackerView.createButton.backgroundColor = .black
            return true
        } else {
            newTrackerView.createButton.isEnabled = false
            newTrackerView.createButton.backgroundColor = .ypGray
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        trackerName = textField.text
    }
}

//MARK: UITableViewDataSource
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
        cell.label.text = presenter?.tableViewTitle[indexPath.row]
        
        switch indexPath.row {
        case 0:
            if let selectedCategory = selectedCategory {
                cell.label.snp.removeConstraints()
                cell.configureCellWithCategory(selectedCategory)
            } else {
                cell.configureCellWithoutCategory()
            }
        case 1:
            if let selectedSchedule = selectedSchedule {
                cell.label.snp.removeConstraints()
                cell.configureCellWithCategory(selectedSchedule)
            } else {
                cell.configureCellWithoutCategory()
            }
        default:
            cell.configureCellWithoutCategory()
        }
        
        return cell
    }
}

//MARK: UITableViewDelegate
extension NewTrackerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

//MARK: UICollectionViewDataSource
extension NewTrackerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let emojies = trackerPresenter?.emojies.count else { return 0 }
        
        switch section {
        case 0:
            return emojies
        case 1:
            return colors.count
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? NewTrackerCollectionViewCell,
              let trackerPresenter = trackerPresenter else { return UICollectionViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.configureEmojiCell(emoji: trackerPresenter.emojies[indexPath.row])
            return cell
        case 1:
            cell.configureColorCell(color: colors[indexPath.row])
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
//MARK: UICollectionViewDelegateFlowLayout
extension NewTrackerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: 52, height: 52)
        case 1:
            return CGSize(width: 46, height: 46)
        default:
            return CGSize(width: 40, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 0
        default:
            return 14
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 5
        case 1:
            return 11
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
            return UIEdgeInsets(top: 0, left: 19, bottom: 40, right: 19)
        case 1:
            return UIEdgeInsets(top: 0, left: 22, bottom: 40, right: 22)
        default:
            return UIEdgeInsets(top: 0, left: 19, bottom: 40, right: 19)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewTrackerCollectionViewCell else { return }
        
        switch indexPath.section {
        case 0:
            cell.layer.cornerRadius = 16
            cell.backgroundColor = .ypLightGray
            trackerEmoji = cell.emojiLabel.text
        case 1:
            cell.layer.cornerRadius = 11
            cell.layer.borderColor = colors[indexPath.row].withAlphaComponent(0.3).cgColor
            cell.layer.borderWidth = 3
            trackerColor = colors[indexPath.row]
        default:
            cell.backgroundColor = .gray
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewTrackerCollectionViewCell else { return }
        
        cell.backgroundColor = .none
        cell.layer.borderWidth = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.indexPathsForSelectedItems?.filter({ $0.section == indexPath.section }).forEach({
            collectionView.deselectItem(at: $0, animated: true)
        })
        
        return true
    }
}

//MARK: SetupViews
extension NewTrackerViewController {
    private func setupViews() {
        view.backgroundColor = .ypWhite
        view.addSubview(newTrackerView.newHabitLabel)
        view.addSubview(newTrackerView.scrollView)
        newTrackerView.scrollView.addSubview(newTrackerView.habitNameTextField)
        newTrackerView.scrollView.addSubview(newTrackerView.categoryAndScheduleTableView)
        newTrackerView.scrollView.addSubview(newTrackerView.collectionView)
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
        
        newTrackerView.scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(newTrackerView.newHabitLabel.snp.bottom).offset(14)
            make.bottom.equalTo(newTrackerView.cancelButton.snp.top).offset(-16)
        }
        
        newTrackerView.habitNameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(75)
        }
        
        newTrackerView.categoryAndScheduleTableView.snp.makeConstraints { make in
            if tracker == .habit {
                make.height.equalTo(149)
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
            make.height.equalTo(460)
            make.bottom.equalToSuperview()
            make.width.equalTo(newTrackerView.scrollView)
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
