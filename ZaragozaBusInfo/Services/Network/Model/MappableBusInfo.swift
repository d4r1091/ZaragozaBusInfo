//
//  MappableBusStopInfo.swift
//  ZaragozaBusInfo
//
//  Created by Dario Carlomagno on 08/09/16.
//  Copyright © 2016 Conichi. All rights reserved.
//

import Foundation
import ObjectMapper

final class MappableBusInfo: Mappable {
    
    /* row json data to parse
     {
     "estimates" : [
     {
     "line" : "C1",
     "direction" : "COMPLEJO FUNERARIO,",
     "estimate" : 1
     },
     ]
     }
     */
    
    var line: String?
    var direction: String?
    var estimate: Int?
    
    init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        line <- map["line"]
        direction <- map["direction"]
        estimate <- map["estimate"]
    }
}

final class MappableBusInfoResponse: Mappable {
    
    var estimates: [MappableBusInfo]?
    
    /*
     I assumed all of these fields as optional 'cause
     I don't have any kind of Model Specification's Document
     */
    
    init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        estimates <- map["estimates"]
    }
}

