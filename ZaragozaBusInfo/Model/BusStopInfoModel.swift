//
//  BusInfoModel.swift
//  ZaragozaBusInfo
//
//  Created by Dario Carlomagno on 03/09/16.
//  Copyright © 2016 Conichi. All rights reserved.
//

import Foundation

struct BusStopInfoModel {
    
    private(set) var id: String?
    private(set) var title: String?
    private(set) var lat: Double?
    private(set) var lon: Double?
    private(set) var lines: [String]?
    private(set) var subtitle: String?
    private(set) var stopImageURL: String?
    
}