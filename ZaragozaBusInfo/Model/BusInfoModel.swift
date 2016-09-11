//
//  BusStopInfoModel.swift
//  ZaragozaBusInfo
//
//  Created by Dario Carlomagno on 10/09/16.
//  Copyright © 2016 Conichi. All rights reserved.
//

import Foundation
import UIKit

struct BusInfoModel {
    
    private(set) var line: String? {
        willSet {
            if let line = line {
                self.line = line
            } else {
                self.line = "nd"
            }
        }
    }
    private(set) var direction: String? {
        willSet {
            if let direction = direction {
                self.direction = direction
            } else {
                self.direction = "nd"
            }
        }
    }
    private(set) var estimate: Int?
    
    func estimateAsString() -> String {
        if let estimateInt = self.estimate {
            return "in " + "\(estimateInt)" + " '"
        } else {
            return "nd"
        }
    }
}