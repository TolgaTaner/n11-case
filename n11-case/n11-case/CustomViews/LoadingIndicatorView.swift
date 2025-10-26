//
//  LoadingIndicatorView.swift
//  n11-case
//
//  Created by Tolga Taner on 26.10.2025.
//

import UIKit

final class LoadingIndicatorView {
    
    static let shared = LoadingIndicatorView()
    
    private var backgroundView: UIView?
    private var activityIndicator: UIActivityIndicatorView?
    
    private init() {}
    
    func show(inView: UIView? = nil) {
        DispatchQueue.main.async {
            guard self.backgroundView == nil else { return }
            
            let parentView: UIView? = {
                if let inView = inView {
                    return inView
                }
                
                if let window = UIApplication.shared.connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .flatMap({ $0.windows })
                    .first(where: { $0.isKeyWindow }) {
                    return window
                }
                return nil
            }()
            
            guard let parentView = parentView else { return }
            let backgroundView = UIView(frame: parentView.bounds)
            backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            let activity = UIActivityIndicatorView(style: .large)
            activity.color = .black
            activity.translatesAutoresizingMaskIntoConstraints = false
            activity.startAnimating()
            
            backgroundView.addSubview(activity)
            parentView.addSubview(backgroundView)
            
            NSLayoutConstraint.activate([
                activity.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
                activity.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
            ])
            
            self.backgroundView = backgroundView
            self.activityIndicator = activity
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.backgroundView?.removeFromSuperview()
            self.activityIndicator = nil
            self.backgroundView = nil
        }
    }
}
