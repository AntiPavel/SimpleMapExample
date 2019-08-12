//
//  CarListViewController.swift
//  SimpleMapExample
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import UIKit

final public class CarListViewController: UIViewController {
    
    private var viewModel: CarsViewModel

    override public func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
    }
    
    init(viewModel: CarsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private func addTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        DispatchQueue.main.async {[weak self] in self?.tableView.reloadData() }
    }

    private lazy var tableView: UITableView = { [unowned self] in
        $0.dataSource = self
        $0.delegate = self
//        $0.register(UITableViewCell.self,
//                    forCellReuseIdentifier: UITableViewCell.className)
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.bounces = true
        $0.backgroundColor = .white
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 80
        return $0
        }(UITableView(frame: view.bounds, style: .plain))
}

extension CarListViewController: UITableViewDelegate {
}

extension CarListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cars.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let car: Car = viewModel.cars[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = car.modelName
        cell.detailTextLabel?.text = car.licensePlate
        return cell
    }
    
}
