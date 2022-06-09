//
//  Operation.swift
//  Payments
//
//  Created by Camila Storck on 06/06/2022.
//

import Foundation

class OperationBuilder {

    var amountToTransfer: Double = 0.0
    var operationDescription: String?
    var paymentMethods: [Method] = []
    var installments: [Installment] = []

    func buidOperation() -> Operation {
        return Operation(amountToTransfer: amountToTransfer,
                         operationDescription: operationDescription,
                         paymentMethods: paymentMethods,
                         installments: installments)
    }
}

class Operation {

    var amountToTransfer: Double
    let operationDescription: String?
    let paymentMethods: [Method]
    let installments: [Installment]

    init(amountToTransfer: Double,
         operationDescription: String?,
         paymentMethods: [Method],
         installments: [Installment]) {
        self.amountToTransfer = amountToTransfer
        self.operationDescription = operationDescription
        self.paymentMethods = paymentMethods
        self.installments = installments
    }
}
