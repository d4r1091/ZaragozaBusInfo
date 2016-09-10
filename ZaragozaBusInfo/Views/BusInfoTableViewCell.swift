//
//  BusInfoTableViewCell.swift
//  ZaragozaBusInfo
//
//  Created by Dario Carlomagno on 03/09/16.
//  Copyright © 2016 Conichi. All rights reserved.
//

import UIKit

class BusInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var busInfo: UILabel!
    @IBOutlet weak var bussesStackView: UIStackView! {
        didSet {
            bussesStackView.axis = .Vertical;
            bussesStackView.distribution = .EqualSpacing;
            bussesStackView.alignment = .Center;
            bussesStackView.spacing = 5;
            bussesStackView.translatesAutoresizingMaskIntoConstraints = false
            bussesStackView.setContentCompressionResistancePriority(UILayoutPriorityRequired,
                                                                    forAxis: .Vertical)
            
        }
    }
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: Fill Outlets
    
    func configureCellViews(number: String?,
                            name: String?,
                            busses:[String]?) {
        self.number.text = number
        self.name.text = name
        guard busses?.count > 0 else {
            self.stackViewHeight.constant = 0
            return
        }
        
        for aString in busses! {
            
            
        }
    }
}
