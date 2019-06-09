//
//  WeatherModel.swift
//  Weather-Redux
//
//  Created by allen_wu on 2019/6/8.
//  Copyright © 2019 Allen. All rights reserved.
//

import HandyJSON

struct WeatherModel: HandyJSON {
    var apparentTemperature: String?
    var cloudCover: Int = 0
    var dewPoint: String?
    var humidity: Double = 0
    var icon: String = ""
    var nearestStormBearing: Int = 0
    var nearestStormDistance: Int = 0
    var ozone: String?
    var precipIntensity: Double = 0
    var precipProbability: Double = 0
    var summary: String?
    var temperature: String?
    var time: TimeInterval = 0
    var windBearing: String?
    var windGust: String?
    var windSpeed: String?
}

extension WeatherModel{
    var weatherIcon: UIImage? {return UIImage.init(named: self.icon)}
    var weekday: String {return time.weekdayStringFromTimeStamp()}
}

struct WeatherDetailModel:HandyJSON {
    var apparentTemperatureHigh: String = ""
    var apparentTemperatureLow: String = ""
    var cloudCover: String?
    var humidity: Double = 0
    var icon: String = ""
    var moonPhase: String?
    var precipIntensity: String?
    var precipIntensityMax: String?
    var precipIntensityMaxTime: TimeInterval = 0
    var precipType: String?
    var pressure: String?
    var summary: String?
    var sunriseTime: TimeInterval = 0
    var sunsetTime: TimeInterval = 0
    var temperatureHigh: String?
    var temperatureHighTime: TimeInterval = 0
    var temperatureLow: String?
    var temperatureLowTime: TimeInterval = 0
    var time: TimeInterval = 0
    var visibility: String?
    var windBearing: String?
    var windGust: String?
    var windSpeed: String?
}

extension WeatherDetailModel{
    var weatherIcon: UIImage? {return UIImage.init(named: self.icon)}
    var weekday: String {return time.weekdayStringFromTimeStamp()}
    var dayTime: String {return time.dateStringFromTimeStamp()}
    var precipIntensityMaxDayTime: String {return precipIntensityMaxTime.dateStringFromTimeStamp()}
    var temperatureHighDayTime: String {return temperatureHighTime.dateStringFromTimeStamp()}
    var temperatureLowDayTime :String {return temperatureLowTime.dateStringFromTimeStamp()}
    var sunsetDayTime:String{return sunsetTime.dateStringFromTimeStamp()}
    var sunriseDayTime:String {return sunriseTime.dateStringFromTimeStamp()}
}
