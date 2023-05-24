//
//  ViewController.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 18.05.2023.
//

import UIKit
import SnapKit

final class TrackerViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupViews()
        setupNavigationController()
    }

    private func setupViews() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
    }
    
    private func setupNavigationController() {
        if let navBar = navigationController?.navigationBar {
            let leftButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTrack))
            navBar.topItem?.setLeftBarButton(leftButton, animated: false)
        }
    }

    @objc private func addNewTrack() {

    }

}

extension TrackerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .red
        return cell
    }
    
    
}

extension TrackerViewController {
    private func addViews() {
        view.addSubview(collectionView)
        addConstraints()
    }
    
    private func addConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
