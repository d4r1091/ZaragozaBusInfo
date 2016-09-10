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
    private(set) var stopImageURL: String?
    
    func busArrivalsAsString(list: [BusInfoModel]?) -> [String]? {
        guard list != nil && list?.count > 0 else {
            return []
        }
        var listAsString: [String] = []
        for aBusInfo in list! {
            let aBusInfoArrivalString = aBusInfo.line! + " - " + aBusInfo.direction! + " - " + aBusInfo.estimate!
            listAsString.append(aBusInfoArrivalString)
        }
        return []
    }
}