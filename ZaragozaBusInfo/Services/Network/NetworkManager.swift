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
            static let googleMapsParameters = "&zoom=15&size=200x 120&sensor=true"
            static func googleMapsImage(lat: Double, lon: Double) -> String {
                return HTTPGoogleMaps.googleMapsBaseURL+googleMapsEndPoint+String(lat)+","+String(lon)+googleMapsParameters
            }
        }
    }
    
    /* in general I decided to use the "Swift 3.0 method's sign's convetion
     as described in this post: https://swift.org/documentation/api-design-guidelines/
     */
    static func getBusInfoList(callback: ([MappableBusInfo]?) -> Void) {
        Alamofire.request(.GET, HTTPEndPoints.busInfoListURL).responseObject { (response: Response<BusInfoLocationsResponse, NSError> ) -> Void in
            let busInfoLocationsResponse = response.result.value
            guard busInfoLocationsResponse?.locations?.count > 0 else {
                callback(nil)
                return
            }
            callback(busInfoLocationsResponse?.locations)
        }
    }
    
    static func getBusStopInfo(id: String, callback: ([MappableBusStopEstimate]?) -> Void) {
        Alamofire.request(.GET, HTTPEndPoints.busInfoListURL).responseObject { (response: Response<MappableBusStopInfoResponse, NSError> ) -> Void in
            let busStopInfoEstimatesResponse = response.result.value
            guard busStopInfoEstimatesResponse?.estimates?.count > 0 else {
                callback(nil)
                return
            }
            callback(busStopInfoEstimatesResponse?.estimates)
        }
    }
    
    static func getBusStopImage(lat: Double, lon: Double ,callback: (UIImage?)) -> Void {
        Alamofire.request(.GET, HTTPEndPoints.HTTPGoogleMaps.googleMapsImage(lat, lon: lon))
            .responseImage { response in
                debugPrint(response)
                debugPrint(response.request)
                debugPrint(response.response)
                debugPrint(response.result)
                if let image = response.result.value {
                    debugPrint("image downloaded: \(image)")
                }
        }
    }
}