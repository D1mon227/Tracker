//
//  ScheduleTableViewCell.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 25.05.2023.
//

import UIKit
import SnapKit

final class ScheduleTableViewCell: UITableViewCell {
    
    private lazy var label: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17, weight: .regular)
        element.textColor = .ypBlack
        return element
    }()
    
    private lazy var switcher: UISwitch = {
        let element = UISwitch()
        element.onTintColor = .ypBlue
        return element
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        addConstraints()
    }
    
    func configureCell(text: String) {
        label.text = text
    }
    
    private func setupView() {
        addSubview(label)
        addSubview(switcher)
    }
    
    private func addConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        switcher.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
}
