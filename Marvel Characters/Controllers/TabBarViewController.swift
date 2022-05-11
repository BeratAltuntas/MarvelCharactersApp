//
//  TabBarViewController.swift
//  Marvel Characters
//
//  Created by BERAT ALTUNTAŞ on 26.04.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	private func setupViews() {
		guard let viewControllers = viewControllers else { return }
		for viewController in viewControllers {
			var childViewController: UIViewController?
			if let navigationController = viewController as? UINavigationController {
				childViewController = navigationController.viewControllers.first
			} else {
				childViewController = viewController
			}
			
			switch childViewController {
			case let viewController as HomeViewController:
				let viewModel = HomeViewModel()
				viewController.viewModel = viewModel
			default:
				break
			}
		}
	}
}
