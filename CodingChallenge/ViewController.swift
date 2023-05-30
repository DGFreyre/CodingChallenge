//
//  ViewController.swift
//  CodingChallenge
//
//  Created by DGF on 5/30/23.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel: WeatherViewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.fetchWeather(cityName: "Georgia")
    }

    
}

