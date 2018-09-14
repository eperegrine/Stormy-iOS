//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 5/8/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let client = DarkSkyAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeather()
    }
    
    
    @IBAction func getCurrentWeather() {
        self.toggleRefreshAnimation(on: true)
        client.getCurrentWeather(at: Coordinate.alcatraz) { [unowned self]
            currentWeather, error in
//            refreshButton
            DispatchQueue.main.async {
                if let currentWeather = currentWeather {
                    let viewModel = CurrentWeatherViewModel(model: currentWeather)
                    self.displayWeather(using: viewModel)
                    self.toggleRefreshAnimation(on: false)
                } else {
                    print ("UI", error)
                    guard let error = error else {
                        fatalError("Could not parse weather but no error was provided")
                    }
                    
                    let alert = UIAlertController(title: "Failed to Fetch Weather", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.toggleRefreshAnimation(on: false)
                    self.invalidWeather()
                }
            }
        }
    }
    
    func displayWeather(using viewModel: CurrentWeatherViewModel) {
        currentTemperatureLabel.text = viewModel.temperature
        currentHumidityLabel.text = viewModel.humidity
        currentPrecipitationLabel.text = viewModel.precipitationProbability
        currentSummaryLabel.text = viewModel.summary
        currentWeatherIcon.image = viewModel.icon
    }
    
    func invalidWeather() {
        currentTemperatureLabel.text = "--"
        currentHumidityLabel.text = "--"
        currentPrecipitationLabel.text = "--"
        currentSummaryLabel.text = "--"
        currentWeatherIcon.image = #imageLiteral(resourceName: "default")
    }
    
    func toggleRefreshAnimation(on: Bool) {
        refreshButton.isHidden = on
//        activityIndicator.isHidden = !on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}


















