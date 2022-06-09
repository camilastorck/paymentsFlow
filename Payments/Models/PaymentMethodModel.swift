//
//  paymentMethodModel.swift
//  Payments
//
//  Created by Camila Storck on 07/06/2022.
//

import Foundation

struct Payment: Codable {
    let request: String
    var methods: [Method]
}

struct Method: Codable {
    let id: Int
    let name: String
    let icon: String
}
