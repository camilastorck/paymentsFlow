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
    private let calculationsViewModel: CalculationsViewModel

    init(calculationsViewModel: CalculationsViewModel) {
        self.calculationsViewModel = calculationsViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var total = "0.00" {
        didSet {
            calculationsViewModel.cleanTotal = total.components(separatedBy: .decimalDigits.inverted).joined()
            totalLabel.text = total
            sendAmountButton.isEnabled = total.formatAsDouble > 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Operación"
        total = "$ 0.00"
        NotificationCenter.default.addObserver(self, selector: #selector(changeViewValues),
                                               name: .updateOperationValues,
                                               object: nil)
    }

    // MARK: - IBActions

    @IBAction private func getParcialValueToBuildTotalAmount(_ sender: UIButton) {
        total = calculationsViewModel.calculateFinalAmount(with: sender.tag)
    }

    @IBAction private func deleteValue(_ sender: UIButton) {
        total = calculationsViewModel.deleteValue()
    }

    @IBAction private func sendOperationToVC(_ sender: UIButton) {
        let total = total.formatAsDouble
        let description = descriptionLabel.text ?? "Sin descripción"
        let operationBuilder = OperationBuilder()
        operationBuilder.amountToTransfer = total
        operationBuilder.operationDescription = description
        operationBuilder.paymentMethods = []
        operationBuilder.installments = []
        let operation = operationBuilder.buidOperation()
        let paymentsVC = PaymentMethodsViewController(dataManager: DataManager(), operation: operation)
        navigationController?.pushViewController(paymentsVC, animated: true)
    }

    @objc private func changeViewValues() {
        total = "0.00"
        descriptionLabel.text = ""

    }
}
