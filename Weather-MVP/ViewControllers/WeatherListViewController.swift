//
//  WeatherListViewController.swift
//  Weather-MVP
//
//  Created by allen_wu on 2019/6/8.
//  Copyright © 2019 Allen. All rights reserved.
//

import UIKit
import SwiftLocation

class WeatherListViewController: UIViewController {

    let dataProvider = WeatherDataProvider()
    
    @IBOutlet weak var currentlyWeatherView: WeatherListHeaderView!
    @IBOutlet weak var tableView: WeatherTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveData()
        
        dataProvider.requestData("37.8267", longitude: "-122.4233") { (error) in
            print("Network Error: \(error)")
        }
    }
    
    func receiveData(){
        dataProvider.getCurrentlyData = {[weak self] data in
            guard let strongSelf = self else { return }
            strongSelf.currentlyWeatherView.updateUI(data)
        }
        
        dataProvider.getDetailListData = { [weak self] data in
            guard let strongSelf = self else { return }
            strongSelf.tableView.data = data
        }
    }
    
    @IBAction func onLocation(_ sender: Any) {
        LocationManager.shared.locateFromGPS(.oneShot, accuracy: .city, result: {[weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case .failure(let error):
                debugPrint("Received error: \(error) the location was changed to Culver")
                strongSelf.dataProvider.requestData("34.0273", longitude: "-118.3864", failure: nil)
            case .success(let location):
                strongSelf.dataProvider.requestData(String(location.coordinate.latitude), longitude: String(location.coordinate.longitude), failure: nil)
            }
        })
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeatherDetail", let controller = segue.destination as? WeatherDetailViewController {
            controller.dailyModel = sender as? WeatherDetailModel
        }
    }
}

extension WeatherListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = dataProvider.dailyList?[indexPath.row] else { return }
        performSegue(withIdentifier: "toWeatherDetail", sender: model)
    }
}
