//
//  NetworkManager.swift
//  TicTracExample
//
//  Created by Dario Carlomagno on 06/08/16.
//  Copyright © 2016 Dario Carlomagno. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import AlamofireImage

struct NetworkManager {
    
    private struct HTTPEndPoints {
        /* 
         I use to write a "base url" if there are some endpoints
         for the same gateway but in this case I didn't 'cause we have only two main URLs
         different from eachother
         */
        static let busInfoListURL = "http://api.dndzgz.com/services/bus"
        
        private struct HTTPGoogleMaps {
            static let googleMapsBaseURL = "http://maps.googleapis.com/"
            static let googleMapsEndPoint = "maps/api/staticmap?center="
            static let googleMapsParameters = "&zoom=15&size=200x120&sensor=true"
            static func googleMapsImage(lat lat: Double, lon: Double) -> String {
                return HTTPGoogleMaps.googleMapsBaseURL+googleMapsEndPoint+String(lat)+","+String(lon)+googleMapsParameters
            }
        }
    }
    
    /* in general I decided to use the "Swift 3.0 method's sign's convetion
     as described in this post: https://swift.org/documentation/api-design-guidelines/
     */
    static func busStopInfoList(callback: ([MappableBusStopInfo]?) -> Void) {
        Alamofire.request(.GET, HTTPEndPoints.busInfoListURL).responseObject { (response: Response<MappableBusInfoStopLocationsResponse, NSError> ) -> Void in
            let busStopInfoLocationsResponse = response.result.value
            guard busStopInfoLocationsResponse?.locations?.count > 0 else {
                callback(nil)
                return
            }
            callback(busStopInfoLocationsResponse?.locations)
        }
    }
    
    static func busInfoList(id id: String?, callback: ([MappableBusInfo]?) -> Void) {
        guard id?.characters.count > 0 else {
            callback(nil)
            return
        }
        Alamofire.request(.GET, HTTPEndPoints.busInfoListURL).responseObject { (response: Response<MappableBusInfoResponse, NSError> ) -> Void in
            let busInfoEstimatesResponse = response.result.value
            guard busInfoEstimatesResponse?.estimates?.count > 0 else {
                callback(nil)
                return
            }
            callback(busInfoEstimatesResponse?.estimates)
        }
    }
    
    static func busStopInfoImageUrl(lat lat: Double?, lon: Double?) -> String {
        guard lat != nil && lon != nil else {
            return ""
        }
        return HTTPEndPoints.HTTPGoogleMaps.googleMapsImage(lat: lat!, lon: lon!)
    }
}