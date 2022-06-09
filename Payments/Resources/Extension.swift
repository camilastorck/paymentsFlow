//
//  StringExtension.swift
//  Payments
//
//  Created by Camila Storck on 08/06/2022.
//

import Foundation

extension String {
    var format: Double {
        return (self as NSString).doubleValue
    }

    var formatAsDouble: Double {
        let cleanTotal = components(separatedBy: .decimalDigits.inverted).joined()
        return (cleanTotal as NSString).doubleValue / 100
    }
}

extension Notification.Name {
    static let updateOperationValues = Notification.Name("updateOperationValues")
    static let dismissControllers = Notification.Name("dismissControllers")
}
