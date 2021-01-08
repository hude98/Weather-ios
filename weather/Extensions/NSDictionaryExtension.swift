//
//  NSDictionaryExtension.swift
//  Weather
//
//  Created by Ta Huy Hung on 4/2/20.
//  Copyright © 2020 HungCorporation. All rights reserved.
//

import Foundation

extension NSDictionary{
    public func safeValueFor(key : String, defaultValue : Any) -> Any{
        if let value = self.value(forKey: key){
            return value
        }
        return defaultValue
    }
}
