//
//  NewTrackerSupplementaryView.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 25.05.2023.
//

import UIKit
import SnapKit

final class NewTrackerSupplementaryView: UICollectionReusableView {
    
    lazy var headerLabel: UILabel = {
        let element = UILabel()
        element.font = .boldSystemFont(ofSize: 19)
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(headerLabel)
    }
    
    private func addConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading).offset(28)
            make.bottom.equalTo(snp.bottom).offset(-31)
        }
    }
}
