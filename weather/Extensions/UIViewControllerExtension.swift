//
//  UIViewControllerExtension.swift
//  Weather
//
//  Created by Ta Huy Hung on 5/15/20.
//  Copyright © 2020 HungCorporation. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func addDoneButton(to control: UITextField ){
        
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: control, action: #selector(UITextField.resignFirstResponder))
        ]
        toolbar.sizeToFit()
        control.inputAccessoryView = toolbar
    }
}
