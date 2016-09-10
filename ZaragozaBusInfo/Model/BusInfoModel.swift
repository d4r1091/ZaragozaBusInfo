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
        didSet {
            if let line = line {
                self.line = line
            } else {
                self.line = "nd"
            }
        }
    }
    private(set) var direction: String? {
        didSet {
            if let direction = direction {
                self.direction = direction
            } else {
                self.direction = "nd"
            }
        }
    }
    private(set) var estimate: String? {
        didSet {
            if let estimate = estimate {
                self.estimate = "in \(estimate)'"
            } else {
                self.estimate = "nd"
            }
        }
    }
    
}