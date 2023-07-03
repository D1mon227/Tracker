//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 25.05.2023.
//

import UIKit
import SnapKit

final class ScheduleViewController: UIViewController, ScheduleViewControllerProtocol {
    
    var viewController: NewTrackerViewControllerProtocol?

    private let scheduleView = ScheduleView()
    private let scheduleViewModel = ScheduleViewModel()
    private let scheduleService = ScheduleService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setupTableView()
        addTarget()
        bindViewModel()
    }
    
    func bindViewModel() {
        scheduleViewModel.$schedule.bind { [weak self] _ in
            guard let self = self else { return }
            viewController?.reloadTableView()
        }
    }
    
    private func setupTableView() {
        scheduleView.scheduleTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        scheduleView.scheduleTableView.dataSource = self
        scheduleView.scheduleTableView.delegate = self
    }
    
    private func addTarget() {
        scheduleView.doneButton.addTarget(self, action: #selector(returnToNewTrackerVC), for: .touchUpInside)
    }
    
    @objc private func returnToNewTrackerVC() {
        scheduleViewModel.setSchedule()
        dismiss(animated: true)
    }
}

//MARK: UITableViewDataSource
extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Resourses.WeekDay.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.configureCell(text: Resourses.WeekDay.allCases[indexPath.row].rawValue)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return cell
    }
}

//MARK: UITableViewDelegate
extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}

extension ScheduleViewController: ScheduleViewControllerDelegate {
    func addDaysToSchedule(cell: ScheduleTableViewCell) {
        guard let fullNameofDay = cell.label.text else { return }
        
        let shortNameOfDay = scheduleService.addDayToSchedule(day: fullNameofDay)
        if cell.switcher.isOn {
            scheduleViewModel.addDaysToSchedule(day: shortNameOfDay)
        } else {
            if let index = scheduleViewModel.schedule.firstIndex(of: shortNameOfDay) {
                scheduleViewModel.removeDayFromSchedule(index: index)
            }
        }
    }
}

//MARK: SetupViews
extension ScheduleViewController {
    private func addView() {
        view.backgroundColor = .ypWhite
        view.addSubview(scheduleView.scheduleLabel)
        view.addSubview(scheduleView.scheduleTableView)
        view.addSubview(scheduleView.doneButton)
        addConstraints()
    }
    
    private func addConstraints() {
        scheduleView.scheduleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        scheduleView.scheduleTableView.snp.makeConstraints { make in
            make.height.equalTo(524)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(scheduleView.scheduleLabel.snp.bottom).offset(30)
        }
        
        scheduleView.doneButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
}
