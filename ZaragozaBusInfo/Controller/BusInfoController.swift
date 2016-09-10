//
//  BusInfoController.swift
//  ZaragozaBusInfo
//
//  Created by Dario Carlomagno on 10/09/16.
//  Copyright © 2016 Conichi. All rights reserved.
//

import Foundation

struct BusInfoController {
    
    static func busInfoList(id: String, completion: ([BusInfoModel]?) -> Void) {
        NetworkManager.busInfoList(id) { (busInfos: [MappableBusInfo]?) in
            guard busInfos?.count > 0 else {
                completion(nil)
                return
            }
            var busInfoObjects: [BusInfoModel] = []
            for aBusInfo in busInfos! {
                let aBusInfoObj = BusInfoModel(line: aBusInfo.line,
                                               direction: aBusInfo.direction,
                                               estimate: aBusInfo.estimate)
                busInfoObjects.append(aBusInfoObj)
            }
            completion(busInfoObjects)
        }
    }
    
    static func busStopInfoList(completion: ([BusStopInfoModel]?) -> Void) {
        NetworkManager.busStopInfoList { (stopInfos: [MappableBusStopInfo]?) in
            guard stopInfos?.count > 0 else {
                completion(nil)
                return
            }
            var busStopInfoObjects: [BusStopInfoModel] = []
            for aBusStopInfo in stopInfos! {
                let aBusStopInfoObj = BusStopInfoModel(id: aBusStopInfo.id,
                    title: aBusStopInfo.title,
                    lat: aBusStopInfo.lat,
                    lon: aBusStopInfo.lon,
                    lines: aBusStopInfo.lines,
                    subtitle: aBusStopInfo.subtitle,
                    stopImageURL:NetworkManager.busStopInfoImageUrl(lat: aBusStopInfo.lat, lon: aBusStopInfo.lon!)
                )
                
                busStopInfoObjects.append(aBusStopInfoObj)
            }
            completion(busStopInfoObjects)
        }
    }
}