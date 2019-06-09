//
//  WeatherTableView.swift
//  Weather-MVP
//
//  Created by allen_wu on 2019/6/8.
//  Copyright © 2019 Allen. All rights reserved.
//

import UIKit

class WeatherTableView: UITableView {
    var data: Array<WeatherDetailModel> = [] {
        didSet {
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self
    }
}

extension WeatherTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        let model = data[indexPath.row]
        cell.textLabel?.text = model.weekday + "  High:" + model.apparentTemperatureHigh + "℉  Low:" +  model.apparentTemperatureLow + "℉"
        cell.imageView?.image = model.weatherIcon
        return cell
    }
}


