//
//  CalculationsViewModel.swift
//  Payments
//
//  Created by Camila Storck on 09/06/2022.
//

import Foundation

final class CalculationsViewModel {

    var cleanTotal: String = ""

    func calculateFinalAmount(with value: Int) -> String {
        var previousTotalAmount: Double = cleanTotal.format * 10.0
        previousTotalAmount = previousTotalAmount + (Double(value))
        let formattedValue = formatter.string(from: NSNumber(value: (previousTotalAmount / 100.0)))
        return "$ \(formattedValue ?? "0.00")"
    }

    func deleteValue() -> String {
        let cleanTotalWithDeletedValue = cleanTotal.dropLast()
        let previousTotalAmount = (String(cleanTotalWithDeletedValue).format) / 100
        return "$ \(previousTotalAmount)"
    }

    func calculateValueForIndividualFee(_ operation: Operation,
                                        _ installments: [Installment],
                                        _ indexPath: IndexPath) -> String {
        let amountForOneFee = operation.amountToTransfer
        let amountFotThreeFees = (operation.amountToTransfer / 3) * 1.15
        let amountForSixFees = (operation.amountToTransfer / 6) * 1.3
        if installments[indexPath.row].id == 0 {
            return formatter.string(from: NSNumber(value: amountForOneFee)) ?? ""
        } else if installments[indexPath.row].id == 1 {
            return formatter.string(from: NSNumber(value: amountFotThreeFees)) ?? ""
        } else if installments[indexPath.row].id == 2 {
            return formatter.string(from: NSNumber(value: amountForSixFees)) ?? ""
        }
        return "0.00"
    }

    func calculateFinalValueForFee(_ operation: Operation,
                                   _ installments: [Installment],
                                   _ indexPath: IndexPath) -> String {
        let amountForOneFee = operation.amountToTransfer
        let finalAmountWithInterestForThreeFees = amountForOneFee * 1.15
        let finalAmountWithInterestForSixFees = amountForOneFee * 1.3
        if installments[indexPath.row].id == 0 {
            return "$ \(formatter.string(from: NSNumber(value: amountForOneFee)) ?? "")"
        } else if installments[indexPath.row].id == 1 {
            return "$ \(formatter.string(from: NSNumber(value: finalAmountWithInterestForThreeFees)) ?? "")"
        } else if installments[indexPath.row].id == 2 {
            return "$ \(formatter.string(from: NSNumber(value: finalAmountWithInterestForSixFees)) ?? "")"
        }
        return "0.00"
    }
}

