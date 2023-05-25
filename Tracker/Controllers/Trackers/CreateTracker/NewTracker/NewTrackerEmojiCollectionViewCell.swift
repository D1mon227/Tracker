//
//  NewTrackerCollectionCell.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 24.05.2023.
//

import UIKit
import SnapKit

final class NewTrackerEmojiCollectionViewCell: UICollectionViewCell {
    
    private lazy var emojiLabel: UILabel = {
        let element = UILabel()
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(emoji: String) {
        emojiLabel.text = emoji
    }
    
    private func setupViews() {
        addSubview(emojiLabel)
    }
    
    private func addConstraints() {
        emojiLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
