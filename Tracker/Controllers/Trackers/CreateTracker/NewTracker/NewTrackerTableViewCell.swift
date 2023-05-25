//
//  NewTrackerCell.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 24.05.2023.
//

import UIKit
import SnapKit

final class NewTrackerTableViewCell: UITableViewCell {
    
    private lazy var label: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17, weight: .regular)
        element.textColor = .ypBlack
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
        contentView.addSubview(label)
    }
    
    private func addConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
