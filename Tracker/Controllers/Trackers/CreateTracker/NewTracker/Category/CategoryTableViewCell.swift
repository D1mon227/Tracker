//
//  CategoryTableViewCell.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 26.05.2023.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17, weight: .regular)
        element.textColor = .ypBlack
        return element
    }()
    
    var viewModel: String? {
        didSet {
            label.text = viewModel
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .ypBackground
        setupView()
        addConstraints()
    }
    
    private func setupView() {
        addSubview(label)
    }
    
    private func addConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(286)
        }
    }
}
