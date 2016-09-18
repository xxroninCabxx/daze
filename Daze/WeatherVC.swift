//
//  ViewController.swift
//  Daze
//
//  Created by Cory Billeaud on 8/28/16.
//  Copyright © 2016 Cory. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var rainPercentageLabel: UILabel!
    @IBOutlet weak var humdityLabel: UILabel!
    @IBOutlet weak var tempHiLabel: UILabel!
    @IBOutlet weak var tempLoLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var cameraImage: UIImageView!
    
    @IBOutlet weak var changeBgView: UIView!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    @IBOutlet weak var forecastCollection: UICollectionView!
    
    
    
    let imagePicker = UIImagePickerController()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        changeBgView.isHidden = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        currentWeather = CurrentWeather()
        
        
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    
                    //Set UI to load download data
                    self.updateMainUI()
                    
                }
            }

            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //Downloading forecast weather data for TableView
        Alamofire.request(FORECAST_URL, method: .get).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.forecastCollection.reloadData()
                }
                
            }
            completed()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = forecastCollection.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            //forecasts.capacity.toIntMax(9)
            return cell
            
        } else {
            return WeatherCell()
            
        }
        
    
    }
    
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        dayLabel.text = currentWeather.day.uppercased()
        
        currentTempLabel.text = "\(currentWeather.currentTemp)°"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        countryLbl.text = currentWeather._country
        weatherDescription.text = currentWeather._longDescription
        currentWeatherImage.image = UIImage(named: currentWeather._icon)
        windSpeedLabel.text = currentWeather.windSpeed
        windDirectionLabel.text = "\(currentWeather.windDirection)"
        rainPercentageLabel.text = "\(currentWeather.rain)\""
        humdityLabel.text = "\(currentWeather.humidity)%"
        tempHiLabel.text = "\(currentWeather.tempMax)°"
        tempLoLabel.text = "\(currentWeather.tempMin)°"
        sunriseLabel.text = currentWeather.sunrise
        sunsetLabel.text = currentWeather.sunset
        
    }
    
    @IBAction func changeBgBtn(_ sender: AnyObject) {
        changeBgView.isHidden = false
    }
    
    @IBAction func bg001(_ sender: UIButton) {
        backGroundImage.image = UIImage(named: "bg001")
    }
    
    @IBAction func bg002(_ sender: UIButton) {
        backGroundImage.image = UIImage(named: "bg002")
    }
    
    @IBAction func bg003(_ sender: UIButton) {
        backGroundImage.image = UIImage(named: "bg003")
        
    }
    
    @IBAction func bg_004(_ sender: UIButton) {
        backGroundImage.image = UIImage(named: "bg004")
    }
    
    @IBAction func bg005(_ sender: UIButton) {
        backGroundImage.image = UIImage(named: "bg005")
    }
    
    @IBAction func loadImageTapped(_ sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            backGroundImage.contentMode = .scaleAspectFill
            cameraImage.image = pickedImage
            backGroundImage.image = pickedImage
        }
        forecasts.removeAll(keepingCapacity: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dontTappedBtn(_ sender: AnyObject) {
        changeBgView.isHidden = true
    }

        
}

