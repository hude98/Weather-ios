//
//  ViewController.swift
//  weather
//
//  Created by Ta Huy Hung on 3/27/20.
//  Copyright © 2020 HungCorporation. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,WeatherDelegate {
    @IBOutlet weak var txtWeatherLocation: UITextField!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var tblListCountry: UITableView!
    var countries = [String]()
    var originnalContriesList = [String]()
    var weatherForecastManager = WeatherForecastManager()
    
    
    @IBAction func onScreenIsTapped(_ sender: Any) {
        tblListCountry.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
        let data = countries[indexPath.row]
        cell.bindData(data: data)
        getTransparentTableViewCell(tableView: tableView, tableViewCell: cell)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        txtWeatherLocation.text = cell.lblNameCountry.text
        tblListCountry.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonSearchToTheRight(textField: txtWeatherLocation)
        setLeftPaddingPoints(textField: txtWeatherLocation, amount: 20)
        txtWeatherLocation.delegate = self
        weatherForecastManager.delegate = self
        addDoneButton(to: txtWeatherLocation)
        tblListCountry.delegate = self
        tblListCountry.dataSource = self
        getNameCountries()
        addCountriesToOriginal()
        txtWeatherLocation.addTarget(self, action: #selector(searchNameOfCountries(_ :)), for: .editingChanged)
        tblListCountry.isHidden = true
    }
    

//    @IBAction func onEdittingChanged(_ sender: Any) {
//
//
//    }
    
    
    private func getTransparentTableViewCell(tableView : UITableView, tableViewCell : UITableViewCell){
        tableView.backgroundColor = .clear
        tableViewCell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    
    func onDataReceived(_ weatherForecast : WeatherForecast) {
        lblTemp.text = formatTempToCelsius(temp: weatherForecast.temp!)
        lblLocation.text = weatherForecast.name
        imgWeather.image = UIImage(named: weatherForecast.imgName!)
    }
    
    
    @objc func searchNameOfCountries(_ textField : UITextField){
        self.countries.removeAll()
        if(textField.text?.count != 0){
            tblListCountry.isHidden = false
            for country in originnalContriesList{
                if let countryIsSearched = textField.text{
                    let range = country.lowercased().range(of: countryIsSearched, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.countries.append(country)
                    }
                }
            }
        }
        else{
            for country in originnalContriesList {
                countries.append(country)
            }
            tblListCountry.isHidden = true
        }
        tblListCountry.reloadData()
        
    }
    
    
    
    func addButtonSearchToTheRight(textField: UITextField){
        let widthTextField = textField.frame.size.width
        let heightTextField = textField.frame.size.height
        let textFieldX = textField.frame.origin.x
        let textFieldY = textField.frame.origin.y
        
        let widthBtn = widthTextField - widthTextField/7
        let heightBtn = heightTextField
        let btnX = textFieldX + (widthTextField - widthBtn)
        let btnY = textFieldY
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: btnX, y: btnY, width: widthBtn, height: heightBtn)
        button.addTarget(self, action: #selector(onSearchLocation), for: .touchUpInside)
        
        textField.rightView = button
        textField.rightViewMode = .always
    }
    
    
    func setLeftPaddingPoints(textField: UITextField, amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: textField.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    
    @objc func onSearchLocation(){
        weatherForecastManager.fetchData(delegate: self, text: txtWeatherLocation.text!)
    }
    
    
    func formatTempToCelsius(temp : Double) -> String{
        let formatter = String(format: "%.f", temp) + "º c"
        return formatter
    }
    
    
    func getNameCountries(){
        countries.append("Afghanistan")
        countries.append("Algeria")
        countries.append("Bangladesh")
        countries.append("Belgium")
        countries.append("Cambodia")
        countries.append("Cameroon")
        countries.append("China")
        countries.append("Denmark")
        countries.append("Dominica")
        countries.append("Ecuador")
        countries.append("Finland")
        countries.append("France")
        countries.append("Germany")
        countries.append("Iceland")
        countries.append("Iran")
        countries.append("Kazakhstan")
        countries.append("Libya")
        countries.append("Malaysia")
        countries.append("Nigeria")
        countries.append("Panama")
        countries.append("Qatar")
        countries.append("Sri Lanka")
        countries.append("Taiwan")
        countries.append("United States")
        countries.append("Vietnam")
    }
    
    func addCountriesToOriginal() {
        for country in countries{
            originnalContriesList.append(country)
        }
    }
}

