//
//  MainViewController.swift
//  Payments
//
//  Created by Camila Storck on 06/06/2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var descriptionLabel: UITextField!
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var sendAmountButton: UIButton! {
        didSet {
            sendAmountButton.layer.cornerRadius = 10
        }
    }
    
    // MARK: - Variables
    
    private var total = "0.00" {
        didSet {
            totalLabel.text = total
            sendAmountButton.isEnabled = total.formatAsDouble > 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Operación"
        total = "$ 0.00"
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewValues), name: .updateOperationValues, object: nil)
    }

    // MARK: - IBActions
    
    @IBAction private func getParcialValueToBuildTotalAmount(_ sender: UIButton) {
        let value = sender.tag
        let cleanTotal = total.components(separatedBy: .decimalDigits.inverted).joined()
        var previousTotalAmount: Double = cleanTotal.format * 10.0
        previousTotalAmount = previousTotalAmount + (Double(value))
        let formattedValue = formatter.string(from: NSNumber(value: (previousTotalAmount / 100.0)))
        total = "$ \(formattedValue ?? "0.00")"
    }
    
    @IBAction private func deleteValue(_ sender: UIButton) {
        let cleanTotal = total.components(separatedBy: .decimalDigits.inverted).joined().dropLast()
        let previousTotalAmount = (String(cleanTotal).format) / 100
        total = "$ \(previousTotalAmount)"
    }
    
    @IBAction private func sendOperationToVC(_ sender: UIButton) {
        let total = total.formatAsDouble
        let description = descriptionLabel.text ?? "Sin descripción"
        let operationBuilder = OperationBuilder()
        operationBuilder.amountToTransfer = total
        operationBuilder.operationDescription = description
        operationBuilder.paymentMethods = []
        operationBuilder.installments = []
        guard let operation = operationBuilder.buidOperation() else { return }
        let paymentsVC = PaymentMethodsViewController(dataManager: DataManager(), operation: operation)
        navigationController?.pushViewController(paymentsVC, animated: true)
    }
    
    @objc private func changeViewValues() {
        total = "0.00"
        descriptionLabel.text = ""
    }
}
