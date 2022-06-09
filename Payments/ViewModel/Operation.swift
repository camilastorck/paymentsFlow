//
//  Operation.swift
//  Payments
//
//  Created by Camila Storck on 06/06/2022.
//

import Foundation

class OperationBuilder {
    
    var amountToTransfer: Double?
    var operationDescription: String?
    var paymentMethods: [Method]?
    var installments: [Installment]?
    
    func buidOperation() -> Operation? {
        if let amountToTransfer = amountToTransfer, let operationDescription = operationDescription, let paymentMethods = paymentMethods, let installments = installments {
            return Operation(amountToTransfer: amountToTransfer, operationDescription: operationDescription, paymentMethods: paymentMethods, installments: installments)
        }
        return nil
    }
}

class Operation {
    
    var amountToTransfer: Double = 0.0
    let operationDescription: String?
    let paymentMethods: [Method]
    let installments: [Installment]

    init(amountToTransfer: Double, operationDescription: String?, paymentMethods: [Method], installments: [Installment]) {
        self.amountToTransfer = amountToTransfer
        self.operationDescription = operationDescription
        self.paymentMethods = paymentMethods
        self.installments = installments
    }

    
}
