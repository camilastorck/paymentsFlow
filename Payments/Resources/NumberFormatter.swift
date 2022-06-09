//
//  NumberFormatter.swift
//  Payments
//
//  Created by Camila Storck on 08/06/2022.
//

import Foundation

public let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    let local = Locale.current
    formatter.decimalSeparator = local.decimalSeparator
    formatter.maximumFractionDigits = 2
    formatter.maximumIntegerDigits = 6
    return formatter
}()

