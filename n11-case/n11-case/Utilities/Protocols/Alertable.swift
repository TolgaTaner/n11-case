//
//  Alertable.swift
//  n11-case
//
//  Created by Tolga Taner on 24.10.2025.
//

import UIKit.UIViewController

protocol Alertable { }
extension Alertable where Self: UIViewController {
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                let alertController = UIAlertController(title: title,
                                                        message: message,
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
        }
    }
}
