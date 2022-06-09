//
//  InstallmentModel.swift
//  Payments
//
//  Created by Camila Storck on 07/06/2022.
//

import Foundation

struct Methods: Codable {
    let request: String
    let installments: [Installment]
}

struct Installment: Codable {
    let id: Int
    let name: String
}
