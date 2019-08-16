//
//  CarListTableViewCell.swift
//  SimpleMapExample
//
//  Created by paul on 16/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import UIKit

class CarListTableViewCell: UITableViewCell {
    
    class var className: String {
        return String(describing: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryType = .detailButton
    }
    
}
