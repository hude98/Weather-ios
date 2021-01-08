//
//  weatherForcastManager.swift
//  Weather
//
//  Created by Ta Huy Hung on 3/28/20.
//  Copyright © 2020 HungCorporation. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherDelegate {
    func onDataReceived(_ weatherForecast : WeatherForecast)
}

class WeatherForecastManager{
    private var weatherForecast = WeatherForecast()
    private var textSearch : String = ""
    var delegate : WeatherDelegate?
    
    
    public func fetchData(delegate : WeatherDelegate, text : String){
        textSearch = text
        DispatchQueue.global().async {
            let request = URLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\( self.textSearch)&units=metric&appid=d7e833c8105f1c1cb33eb8dfe19615ac")!)
            print(request)
            let task = URLSession.shared.dataTask(with: request, completionHandler:
            { (data, response, error) in
                let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                let cod = json?.safeValueFor(key: "cod", defaultValue: " ") as Any
                let message = json?.safeValueFor(key: "message", defaultValue: " ") as! String
                if self.checkError(cod, message) == true{
                    DispatchQueue.main.sync {
                        delegate.onDataReceived(self.weatherForecast)
                    }
                    return
                }
                let name = json?.safeValueFor(key: "name", defaultValue: " ")
                let main = json?.safeValueFor(key: "main", defaultValue: " ") as! NSDictionary
                let temp = main.safeValueFor(key: "temp", defaultValue: " ")
                let weather = json?.safeValueFor(key: "weather", defaultValue: " ") as! [NSObject]
                let elementWeather = weather[0] as! NSDictionary
                let description = elementWeather.safeValueFor(key: "main", defaultValue: " ")
                
                self.weatherForecast.name = (name as! String)
                self.weatherForecast.temp = (temp as! Double)
                self.weatherForecast.imgName = self.getSuitableNameIconOfWeather(description as! String)
                
                DispatchQueue.main.sync {
                    delegate.onDataReceived(self.weatherForecast)
                }
            })
            task.resume()
        }
    }
    
    
    private func getSuitableNameIconOfWeather(_ description: String)->String{
        if(description == "Clouds"){
            return "ic_cloud"
        }
        else if(description == "Clear"){
            return "ic_partly_cloudy_day"
        }
        else if(description == "Rain"){
            return "ic_rain"
        }
        else if(description == "Haze"){
            return "ic_haze"
        }
        else if(description == "Snow"){
            return "ic_snow"
        }
        return "ic_tornado"
    }
    
    private func checkError(_ cod : Any, _ message :String) -> Bool{
        if (cod is NSNumber) // cod == 200 : Int (dl đúng), cod != 200 : String(dl sái)
        {
            return false
        }
        else{
            NotifyError(message)
            self.weatherForecast.name = "--"
            self.weatherForecast.temp = 0.0
            return true
        }
    }
    
    private func NotifyError(_ error : String){
        print("error :\(error)")
    }
    
}














