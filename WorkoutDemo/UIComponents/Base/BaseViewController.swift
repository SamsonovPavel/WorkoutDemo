//
//  BaseViewController.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    
    var safeAreaLayout: UILayoutGuide {
        view.safeAreaLayoutGuide
    }

    var bindings = Set<AnyCancellable>()

    /// Переопределяем инициализацию,
    /// чтобы не вызывать required init? в дочернем классе
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearanceViews()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let hasDifferentColorAppearance = traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
        
        if hasDifferentColorAppearance {
            setupAppearanceViews()
        }
    }

    // Переопределяем в наследниках
    func setupAppearanceViews() {}
}

extension BaseViewController {
    
    // MARK: - Navigation
    
    func setupNavigationBar() {
        navigationController.map {
            $0.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 18, weight: .medium)
            ]
        }
    }
    
    func setNavigationBarHidden(_ value: Bool) {
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = value
        }
    }
    
    func setHidesBackButton(_ hidesBackButton: Bool, animated: Bool = false) {
        navigationItem.setHidesBackButton(
            hidesBackButton,
            animated: animated
        )
    }
    
    func addLeftButtonItem() {
        let arrowBack = UIImage(systemName: "arrow.backward")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: arrowBack, style: .plain, target: self, action: #selector(leftBackButtonAction))
    }

    @objc func leftBackButtonAction(_ sender: UIBarButtonItem) {
        navigationController.map { _ = $0.popViewController(animated: true) }
    }
}
