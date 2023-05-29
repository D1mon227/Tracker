//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 25.05.2023.
//

import UIKit
import SnapKit

final class ScheduleViewController: UIViewController, ScheduleViewControllerProtocol {
    
    var presenter: TrackerViewPresenterProtocol?
    var viewController: NewTrackerViewControllerProtocol?

    private let scheduleView = ScheduleView()
    private let scheduleService = ScheduleService()
    var daysInInt: [Int] = []
    var days: [String] = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setupTableView()
        addTarget()
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
        let scheduleDay = daysInInt.count == 7 ? "Каждый день" : scheduleService.arrayToString(array: daysInInt)
        viewController?.selectedSchedule = scheduleDay
        viewController?.reloadTableView()
        dismiss(animated: true)
    }
}

//MARK: UITableViewDataSource
extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as? ScheduleTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.configureCell(text: days[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

//MARK: UITableViewDelegate
extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ScheduleViewController: ScheduleViewControllerDelegate {
    func addDaysToSchedule(cell: ScheduleTableViewCell) {
        guard let fullNameofDay = cell.label.text else { return }
        
        let shortNameOfDay = scheduleService.addDayToSchedule(day: fullNameofDay)
        if cell.switcher.isOn {
            daysInInt.append(shortNameOfDay)
        } else {
            if let index = daysInInt.firstIndex(of: shortNameOfDay) {
                daysInInt.remove(at: index)
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
