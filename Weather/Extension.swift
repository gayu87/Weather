//
//  Extension.swift
//  Weather
//
//  Created by gayatri patel on 8/29/21.
//

import Foundation
import UIKit

extension UITextField{
    func setBorder(textField: UITextField){
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 4.0
        textField.layer.borderColor = UIColor.blue.cgColor
    }
}
