//
//  CountryCell.swift
//  Weather
//
//  Created by Ta Huy Hung on 5/20/20.
//  Copyright © 2020 HungCorporation. All rights reserved.
//

import Foundation
import UIKit


class CountryCell: UITableViewCell {
    @IBOutlet weak var lblNameCountry: UILabel!
    
    func bindData(data : String){
        lblNameCountry.text = data
    }
}
