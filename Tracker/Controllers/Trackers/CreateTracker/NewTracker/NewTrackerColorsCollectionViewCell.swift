//
//  NewTrackerColorsCollectionViewCell.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 25.05.2023.
//

import UIKit
import SnapKit

final class NewTrackerColorsCollectionViewCell: UICollectionViewCell {
    
    private lazy var colorImage: UIImageView = {
        let element = UIImageView()
        element.layer.cornerRadius = 8
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
    
    func configureCell(color: UIColor) {
        colorImage.backgroundColor = color
    }
    
    private func setupView() {
        addSubview(colorImage)
    }
    
    private func addConstraints() {
        colorImage.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
