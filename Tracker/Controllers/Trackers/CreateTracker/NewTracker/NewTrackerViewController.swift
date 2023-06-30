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
    
    var createViewController: CreateTrackerViewControllerProtocol?
    private let newTrackerView = NewTrackerView()
    private let newTrackerViewModel = NewTrackerViewModel()
    var typeOfTracker: TypeOfTracker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTrackerViewModel.view = self
        setupViews()
        setupTableView()
        setupCollectionView()
        setupTextField()
        setupTarget()
        bindViewModel()
    }
    
    func bindViewModel() {
        newTrackerViewModel.$checkTrackerForCreate.bind { [weak self] value in
            guard let self = self else { return }
            value == true ? self.enableCreateButton() : self.disableCreateButton()
        }
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
    
    func enableCreateButton() {
        newTrackerView.createButton.isEnabled = true
        newTrackerView.createButton.backgroundColor = .ypBlack
        newTrackerView.createButton.setTitleColor(.ypWhite, for: .normal)
    }
    
    func disableCreateButton() {
        newTrackerView.createButton.isEnabled = false
        newTrackerView.createButton.backgroundColor = .ypGray
    }
    
    private func setupTextField() {
        newTrackerView.habitNameTextField.delegate = self
    }
    
    private func setupTarget() {
        newTrackerView.cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        newTrackerView.createButton.addTarget(self, action: #selector(createTracker), for: .touchUpInside)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc private func createTracker() {
        newTrackerViewModel.createNewTracker()
        newTrackerViewModel.resetNewTrackerInfo()
        dismissVC()
        createViewController?.switchToTrackerVC()
    }
    
    @objc private func switchToCategoryViewController() {
        let categoryVC = CategoryViewController()
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
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        newTrackerViewModel.setTrackerName(name: textField.text ?? "")
        //checkCreateButton()
    }
}

//MARK: UITableViewDataSource
extension NewTrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch typeOfTracker {
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
        cell.label.text = newTrackerViewModel.tableViewTitle[indexPath.row]
        
        if indexPath.row + 1 == newTrackerViewModel.tableViewTitle.count {
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
        } else {
            cell.layer.cornerRadius = 0
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        
        switch indexPath.row {
        case 0:
            if let selectedCategory = newTrackerViewModel.getSelectedCategory() {
                cell.label.snp.removeConstraints()
                cell.configureCellWithCategory(selectedCategory)
            } else {
                cell.configureCellWithoutCategory()
            }
        case 1:
            if let selectedSchedule = newTrackerViewModel.getSelectedSchedule() {
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
        
        switch section {
        case 0:
            return newTrackerViewModel.emojies.count
        case 1:
            return newTrackerViewModel.colors.count
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? NewTrackerCollectionViewCell else { return UICollectionViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.configureEmojiCell(emoji: newTrackerViewModel.emojies[indexPath.row])
            return cell
        case 1:
            cell.configureColorCell(color: newTrackerViewModel.colors[indexPath.row])
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
            newTrackerViewModel.setTrackerEmoji(emoji: cell.emojiLabel.text ?? "")
        case 1:
            cell.layer.cornerRadius = 11
            cell.layer.borderColor = newTrackerViewModel.colors[indexPath.row].withAlphaComponent(0.3).cgColor
            cell.layer.borderWidth = 3
            newTrackerViewModel.setTrackerColor(color: cell.colorImage.backgroundColor ?? UIColor())
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
        newTrackerView.newHabitLabel.text = typeOfTracker == .habit ? "Новая привычка" : "Новое нерегулярное событие"
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
            if typeOfTracker == .habit {
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
