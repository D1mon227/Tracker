//
//  ViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 18.05.2023.
//

import UIKit
import SnapKit

final class TrackerViewController: UIViewController, TrackerViewControllerProtocol {
    
    private let trackerView = TrackerView()
    var presenter: TrackerViewPresenterProtocol?
    var viewController: NewTrackerViewControllerProtocol?
    
    var colors: [UIColor] = [
        .colorSelection1, .colorSelection2, .colorSelection3, .colorSelection4, .colorSelection5, .colorSelection6,
        .colorSelection7, .colorSelection8, .colorSelection9, .colorSelection10, .colorSelection11, .colorSelection12,
        .colorSelection13, .colorSelection14, .colorSelection15, .colorSelection16, .colorSelection17, .colorSelection18,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupViews()
        setupNavigationController()
        addTarget()
        checkCellsCount(image: Resourses.Images.trackerEmptyImage!, text: "Что будем отслеживать?")
        setupTrackersFromDatePicker()
    }

    private func setupViews() {
        trackerView.trackersCollectionView.register(TrackerCollectionViewCell.self, forCellWithReuseIdentifier: "TrackerCollectionViewCell")
        trackerView.trackersCollectionView.register(TrackerSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        trackerView.trackersCollectionView.dataSource = self
        trackerView.trackersCollectionView.delegate = self
        
        trackerView.searchTextField.delegate = self
    }
    
    private func setupNavigationController() {
        guard let navBar = navigationController?.navigationBar else { return }
        let leftButton = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(addNewTracker))
        leftButton.tintColor = .ypBlack
        navBar.topItem?.setLeftBarButton(leftButton, animated: false)
    }
    
    func reloadCollectionView() {
        trackerView.trackersCollectionView.reloadData()
    }
    
    func checkCellsCount(image: UIImage, text: String) {
        if presenter?.visibleCategories?.count == 0 {
            view.addSubview(trackerView.emptyImage)
            view.addSubview(trackerView.emptyLabel)
            trackerView.emptyImage.image = image
            trackerView.emptyLabel.text = text
            trackerView.filterButton.removeFromSuperview()
            
            trackerView.emptyImage.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            trackerView.emptyLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(16)
                make.top.equalTo(trackerView.emptyImage.snp.bottom).offset(8)
            }
        } else {
            trackerView.emptyImage.removeFromSuperview()
            trackerView.emptyLabel.removeFromSuperview()
            view.addSubview(trackerView.filterButton)
            
            trackerView.filterButton.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-17)
                make.centerX.equalToSuperview()
                make.height.equalTo(50)
                make.width.equalTo(114)
            }
        }
    }

    @objc private func addNewTracker() {
        let newtrackerVC = CreateTrackerViewController()
        newtrackerVC.presenter = presenter
        newtrackerVC.viewController = self
        present(newtrackerVC, animated: true)
    }
    
    private func addTarget() {
        trackerView.filterButton.addTarget(self, action: #selector(switchToFilterViewController), for: .touchUpInside)
        trackerView.searchTextField.addTarget(self, action: #selector(addCancelButton), for: .editingDidBegin)
        trackerView.searchTextField.addTarget(self, action: #selector(setupTrackersFromTextField), for: [.editingChanged, .editingDidEnd])
        trackerView.cancelButton.addTarget(self, action: #selector(removeCancelButton), for: .touchUpInside)
        trackerView.datePicker.addTarget(self, action: #selector(setupTrackersFromDatePicker), for: .valueChanged)
    }
    
    @objc private func switchToFilterViewController() {
        let filterVC = FilterViewController()
        present(filterVC, animated: true)
    }
    
    @objc private func addCancelButton() {
        view.addSubview(trackerView.cancelButton)
        trackerView.searchTextField.snp.removeConstraints()
        
        trackerView.cancelButton.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(trackerView.searchTextField)
            make.width.equalTo(83)
        }
        
        trackerView.searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(trackerView.cancelButton.snp.leading).offset(-5)
        }
    }

    @objc private func removeCancelButton() {
        trackerView.searchTextField.text = .none
        trackerView.searchTextField.endEditing(true)
        trackerView.cancelButton.removeFromSuperview()
        trackerView.searchTextField.snp.removeConstraints()
        
        trackerView.searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    @objc private func setupTrackersFromDatePicker() {
        guard let image = Resourses.Images.trackerEmptyImage else { return }
        presenter?.currentDate = trackerView.datePicker.date
        
        presenter?.filterTrackers(text: "")
        trackerView.trackersCollectionView.reloadData()
        checkCellsCount(image: image, text: "Что будем отслеживать?")
    }
    
    @objc private func setupTrackersFromTextField() {
        guard let text = trackerView.searchTextField.text,
              let image = Resourses.Images.trackerEmptyImage else { return }
        
        presenter?.filterTrackers(text: text)
        trackerView.trackersCollectionView.reloadData()
        checkCellsCount(image: image, text: "Ничего не найдено")
    }
}

//MARK: UICollectionViewDataSource
extension TrackerViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.visibleCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter?.visibleCategories?[section] else { return 0 }
        
        return presenter.trackerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackerCollectionViewCell", for: indexPath) as? TrackerCollectionViewCell,
              let category = presenter?.visibleCategories?[indexPath.section],
              let days = presenter?.completedTrackers else { return UICollectionViewCell() }
        
        let tracker = category.trackerArray[indexPath.row]
        
        cell.delegate = self
        
        let isCompletedToday = isTrackerCompletedToday(id: tracker.id)
        let completedDays = days.filter { $0.id == tracker.id }.count

        cell.configureCell(tracker: tracker,
                           isCompleted: isCompletedToday,
                           completedDays: completedDays,
                           indexPath: indexPath)
        
        return cell
    }
    
    private func isTrackerCompletedToday(id: UUID) -> Bool {
        guard let completedTrackers = presenter?.completedTrackers else { return false }
        
        return completedTrackers.contains { trackerRecord in
            let isSameDay = Calendar.current.isDate(trackerRecord.date, inSameDayAs: trackerView.datePicker.date)
            return trackerRecord.id == id && isSameDay
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
                                                                         for: indexPath) as? TrackerSupplementaryView else { return UICollectionReusableView() }
        view.headerLabel.text = presenter?.categories?[indexPath.section].name
    
        return view
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension TrackerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 41) / 2, height: 148)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: collectionView.frame.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}

//MARK: TrackerCollectionViewCellDelegate
extension TrackerViewController: TrackerCollectionViewCellDelegate {
    func completeTracker(id: UUID, at indexPath: IndexPath) {
        let trackerRecord = TrackerRecord(id: id, date: trackerView.datePicker.date)
        presenter?.completedTrackers?.append(trackerRecord)
        
        trackerView.trackersCollectionView.reloadItems(at: [indexPath])
    }
    
    func uncompleteTracker(id: UUID, at indexPath: IndexPath) {
        presenter?.completedTrackers?.removeAll { trackerRecord in
            let isSameDay = Calendar.current.isDate(trackerRecord.date, inSameDayAs: trackerView.datePicker.date)
            return trackerRecord.id == id && isSameDay
        }
        
        trackerView.trackersCollectionView.reloadItems(at: [indexPath])
    }
}

//MARK: UITextFieldDelegate
extension TrackerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return true
        }
    }
}

//MARK: SetupViews
extension TrackerViewController {
    private func addViews() {
        guard let navBar = navigationController?.navigationBar else { return }
        view.backgroundColor = .ypWhite
        view.addSubview(trackerView.searchTextField)
        view.addSubview(trackerView.trackersCollectionView)
        view.addSubview(trackerView.datePicker)
        navBar.addSubview(trackerView.datePicker)
        addConstraints()
    }
    
    private func addConstraints() {
        guard let navBar = navigationController?.navigationBar else { return }
        
        trackerView.datePicker.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.trailing.equalTo(navBar.snp.trailing).offset(-16)
            make.bottom.equalTo(navBar.snp.bottom).offset(-11)
        }
        
        trackerView.searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        trackerView.trackersCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(trackerView.searchTextField.snp.bottom).offset(10)
        }
    }
}
