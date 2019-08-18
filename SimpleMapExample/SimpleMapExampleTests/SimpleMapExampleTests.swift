//
//  SimpleMapExampleTests.swift
//  SimpleMapExampleTests
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import XCTest
@testable import SimpleMapExample


/// here aren't full complect of tests, just couple of examples
class SimpleMapExampleTests: XCTestCase {

    var viewModel: CarsViewModel?
    var tabVC: TabBarViewController?
    
    override func setUp() {

    }

    override func tearDown() {
        viewModel = nil
        tabVC = nil
    }

    func testViewModel() {
        viewModel = CarsViewModel(reader: MockNetworkService())
        viewModel?.update()
        let exp = expectation(description: "Test CarsViewModel update function after 2 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 2.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel?.cars.count, 28)
        } else {
            XCTFail("CarsViewModel update function test failed")
        }
    }
    
    func testCarListTableView() {
        viewModel = CarsViewModel(reader: MockNetworkService())
        tabVC = TabBarViewController(viewModel: viewModel!)
        let exp = expectation(description: "Test CarListTableView shows cars after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(tabVC!.list!.tableView.visibleCells.isEmpty, false)
        } else {
            XCTFail("CarListTableView show cars test failed")
        }
    }
    
    func testCarsMapView() {
        viewModel = CarsViewModel(reader: MockNetworkService())
        tabVC = TabBarViewController(viewModel: viewModel!)
        let exp = expectation(description: "Test CarsMapView shows cars after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(tabVC!.maps!.mapView.annotations.count > 1)
        } else {
            XCTFail("CarsMapView show cars test failed")
        }
    }

}
