//
//  CarListViewController.swift
//  SimpleMapExample
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import UIKit

final public class CarListViewController: UIViewController, Detailable {

    private var viewModel: CarsViewModel
    
    private (set) public lazy var tableView: UITableView = { [unowned self] in
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.bounces = true
        $0.backgroundColor = .white
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 80
        $0.register(CarListTableViewCell.self, forCellReuseIdentifier: CarListTableViewCell.className)
        return $0
    }(UITableView(frame: view.bounds, style: .plain))
    
    var refreshControl = UIRefreshControl()

    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: CarsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        addTableView()
        addRefresh()
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
        DispatchQueue.main.async {[weak self] in
            self?.shouldFinishRefresh()
            self?.tableView.reloadData() }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    @objc private func fetchUpdate() {
        viewModel.update()
    }
    
    private func addRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(fetchUpdate), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }

    func shouldFinishRefresh() {
        refreshControl.endRefreshing()
    }
}

extension CarListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cars.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CarListTableViewCell.className,
                                                 for: indexPath) as? CarListTableViewCell
        let car: Car = viewModel.cars[indexPath.row]
        cell?.textLabel?.text = car.title
        cell?.detailTextLabel?.text = car.subtitle
        return cell ?? UITableViewCell(style: .default, reuseIdentifier: nil)
    }
}

extension CarListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let car: Car = viewModel.cars[indexPath.row]
        showDetails(car,
                    completion: { })
    }
}
