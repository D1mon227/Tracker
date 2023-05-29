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
    var completedTrackers: [TrackerRecord]?
    var currentDate: Date?
    
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
        checkCellsCount()
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
                                         action: #selector(addNewTrack))
        leftButton.tintColor = .ypBlack
        navBar.topItem?.setLeftBarButton(leftButton, animated: false)
    }
    
    private func checkCellsCount() {
        if presenter?.categories?.count == 0 {
            view.addSubview(trackerView.emptyImage)
            view.addSubview(trackerView.emptyLabel)
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

    @objc private func addNewTrack() {
        let newtrackerVC = CreateTrackerViewController()
        newtrackerVC.presenter = presenter
        newtrackerVC.viewController = self
        present(newtrackerVC, animated: true)
    }
    
    private func addTarget() {
        trackerView.filterButton.addTarget(self, action: #selector(switchToFilterViewController), for: .touchUpInside)
    }
    
    @objc private func switchToFilterViewController() {
        let filterVC = FilterViewController()
        present(filterVC, animated: true)
    }

}

//MARK: UICollectionViewDataSource
extension TrackerViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter?.categories?[section] else { return 0 }
        
        return presenter.trackerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackerCollectionViewCell", for: indexPath) as? TrackerCollectionViewCell,
              let category = presenter?.categories?[indexPath.section] else { return UICollectionViewCell() }
        
        let tracker = category.trackerArray[indexPath.row]
        
        cell.configureCell(cellColor: tracker.color,
                           trackerName: tracker.name,
                           doneColor: tracker.color,
                           emoji: tracker.emoji)
        
        return cell
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
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
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

//MARK: UITextFieldDelegate
extension TrackerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        trackerView.searchTextField.endEditing(true)
        return true
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
        view.addSubview(trackerView.filterButton)
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
        
//        trackerView.filterButton.snp.makeConstraints { make in
//            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-17)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(50)
//            make.width.equalTo(114)
//        }
    }
}
