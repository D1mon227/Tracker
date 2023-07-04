//
//  AlertService.swift
//  Tracker
//
//  Created by Dmitry Medvedev on 04.07.2023.
//

import UIKit

final class AlertService {
    func showAlert(controller: UIViewController, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: LocalizableConstants.Alert.title,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: LocalizableConstants.Alert.cancel, style: .cancel)
        let deleteAction = UIAlertAction(title: LocalizableConstants.Alert.delete, style: .destructive) { _ in
            completion()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        controller.present(alert, animated: true)
    }
}
