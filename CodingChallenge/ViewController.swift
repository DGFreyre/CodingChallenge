//
//  ViewController.swift
//  CodingChallenge
//
//  Created by DGF on 5/30/23.
//

import UIKit
import Combine


class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UITextField!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    

    private var cancellables = Set<AnyCancellable>()
    private var viewModel: WeatherViewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        viewModel.fetchWeather(cityName: "Georgia")
    }
}


extension WeatherViewController: UITextFieldDelegate {
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            viewModel.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}



