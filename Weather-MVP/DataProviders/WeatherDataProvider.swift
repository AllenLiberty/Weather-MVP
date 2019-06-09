//
//  WeatherDataProvider.swift
//  Weather-MVP
//
//  Created by allen_wu on 2019/6/8.
//  Copyright © 2019 Allen. All rights reserved.
//

import Foundation

class WeatherDataProvider {
    /// format date for WeatherTableView
    private(set) var dailyList:[WeatherDetailModel]?
    
    /// format date for WeatherListHeaderView
    private(set) var currentlyModel: WeatherModel?
    
    public var getDetailListData: (([WeatherDetailModel]) -> Void)?
    public var getCurrentlyData: ((WeatherModel) -> Void)?
    
    func requestData(_ latitude:String, longitude:String,failure:((Error) -> Void)?){
        let url = URLStore.fetchWeather.rawValue + latitude + "," + longitude
        
        WHServerApi.request(url, success: { [weak self] result in
            guard let currentlyModel = WeatherModel.deserialize(from: result, designatedPath: "currently")else {
                failure?(NetWorkError.responseError(description: result))
                return
            }
            
            guard let dailyList:[WeatherDetailModel] = [WeatherDetailModel].deserialize(from: result, designatedPath: "daily.data") as? [WeatherDetailModel]else {
                failure?(NetWorkError.responseError(description: result))
                return
            }
            self?.currentlyModel = currentlyModel
            self?.dailyList = dailyList
            self?.getCurrentlyData?(currentlyModel)
            self?.getDetailListData?(dailyList)
            }, failure: { error in
                failure?(NetWorkError.responseError(description: "\(error)"))
        })
    }
}
