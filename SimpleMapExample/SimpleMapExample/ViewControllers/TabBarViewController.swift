//
//  TabBarViewController.swift
//  SimpleMapExample
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import UIKit

final public class TabBarViewController: UITabBarController {
    
    private var list: CarListViewController!
    private var maps: CarsMapViewController!
    
    private var viewModel: CarsViewModel
    
    init(viewModel: CarsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        list = CarListViewController(viewModel: viewModel)
        list.title = "CarsList"
        list.tabBarItem = UITabBarItem.init(title: "List", image: UIImage(named: "ListTab"), tag: 0)
        
        maps = CarsMapViewController(viewModel: viewModel)
        maps.title = "CarsMap"
        maps.tabBarItem = UITabBarItem.init(title: "Location", image: UIImage(named: "Location"), tag: 1)
        
        let controllerArray: [UIViewController] = [list, maps]
        viewControllers = controllerArray.map { UINavigationController.init(rootViewController: $0 )}
    }
    
    func update() {
        list?.update()
        maps?.update()
    }

}

extension TabBarViewController: UITabBarControllerDelegate {
    
}
