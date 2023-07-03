//
//  NewTrackerViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 24.05.2023.
//

import UIKit
import SnapKit

final class CreateTrackerViewController: UIViewController, CreateTrackerViewControllerProtocol {
    
    private let newTrackerView = CreateTrackerView()
    var viewController: TrackerViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addTargets()
    }
    
    private func addTargets() {
        newTrackerView.habitButton.addTarget(self, action: #selector(switchToNewHabitViewController), for: .touchUpInside)
        newTrackerView.unregularEventButtton.addTarget(self, action: #selector(switchToNewUnregularEventViewController), for: .touchUpInside)
    }
    
    @objc private func switchToNewHabitViewController() {
        let newHabitVC = NewTrackerViewController()
        newHabitVC.createViewController = self
        newHabitVC.typeOfTracker = .habit
        present(newHabitVC, animated: true)
    }
    
    @objc private func switchToNewUnregularEventViewController() {
        let newHabitVC = NewTrackerViewController()
        newHabitVC.createViewController = self
        newHabitVC.typeOfTracker = .unregularEvent
        present(newHabitVC, animated: true)
    }
    
    func switchToTrackerVC() {
        dismiss(animated: true)
        viewController?.setupTrackersFromDatePicker()
    }
}

//MARK: SetupViews
extension CreateTrackerViewController {
    private func addViews() {
        view.backgroundColor = .ypWhite
        view.addSubview(newTrackerView.createTrackerLabel)
        view.addSubview(newTrackerView.habitButton)
        view.addSubview(newTrackerView.unregularEventButtton)
        addConstraints()
    }
    
    private func addConstraints() {
        newTrackerView.createTrackerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        newTrackerView.habitButton.snp.makeConstraints { make in
            make.top.equalTo(newTrackerView.createTrackerLabel.snp.bottom).offset(295)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        newTrackerView.unregularEventButtton.snp.makeConstraints { make in
            make.top.equalTo(newTrackerView.habitButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
}
