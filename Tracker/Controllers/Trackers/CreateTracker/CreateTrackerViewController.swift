//
//  NewTrackerViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 24.05.2023.
//

import UIKit
import SnapKit

final class CreateTrackerViewController: UIViewController, CreateTrackerViewControllerProtocol {
    
    private(set) var createTrackerView = CreateTrackerView()
    var viewController: TrackerViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addTargets()
    }
    
    private func addTargets() {
        createTrackerView.habitButton.addTarget(self, action: #selector(switchToNewHabitViewController), for: .touchUpInside)
        createTrackerView.unregularEventButtton.addTarget(self, action: #selector(switchToNewUnregularEventViewController), for: .touchUpInside)
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
        view.addSubview(createTrackerView.createTrackerLabel)
        view.addSubview(createTrackerView.habitButton)
        view.addSubview(createTrackerView.unregularEventButtton)
        addConstraints()
    }
    
    private func addConstraints() {
        createTrackerView.createTrackerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        createTrackerView.habitButton.snp.makeConstraints { make in
            make.top.equalTo(createTrackerView.createTrackerLabel.snp.bottom).offset(295)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        createTrackerView.unregularEventButtton.snp.makeConstraints { make in
            make.top.equalTo(createTrackerView.habitButton.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
}
