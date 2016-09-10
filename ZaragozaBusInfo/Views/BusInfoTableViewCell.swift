//
//  BusInfoTableViewCell.swift
//  ZaragozaBusInfo
//
//  Created by Dario Carlomagno on 03/09/16.
//  Copyright © 2016 Conichi. All rights reserved.
//

import UIKit

class BusInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stopImageView: UIImageView!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var busInfo: UILabel!
    @IBOutlet weak var bussesTextView: UITextView!
    
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
                            name: String?) {
        self.number.text = number
        self.name.text = name
    }
    
    func updatedBussesInfo(list busses: [String]?) {
        guard busses?.count > 0 else {
            bussesTextView.text = "service temporarily unavailable"
            return
        }
        var completeString = busses![0]
        for (index, element) in (busses?.enumerate())! {
            if index == 0 {
                continue
            }
            completeString = completeString + "\n" + element
        }
        bussesTextView.text = completeString
    }
}
