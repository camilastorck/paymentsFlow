//
//  InstallmentsViewController.swift
//  Payments
//
//  Created by Camila Storck on 07/06/2022.
//

import UIKit

final class InstallmentsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            let nib = UINib(nibName: InstallmentCell.name, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: InstallmentCell.identifier)
        }
    }

    // MARK: - Variables

    private let calculationsViewModel: CalculationsViewModel
    private let dataManager: DataManager
    private var installments: [Installment] = []
    private var operation: Operation

    init(calculationsViewModel: CalculationsViewModel, dataManager: DataManager, operation: Operation) {
        self.calculationsViewModel = calculationsViewModel
        self.dataManager = dataManager
        self.operation = operation
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Financiación"
        fetchDataForInstallmentsInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(dismissControllers),
                                               name: .dismissControllers,
                                               object: nil)
    }

    private func fetchDataForInstallmentsInfo() {
        installments = dataManager.getInstallmentMethods()
        tableView.reloadData()
    }

    private func navigateToConfirmationWithMethod(finalAmount: Double, installment: Installment) {
        let operationBuilder = OperationBuilder()
        operationBuilder.amountToTransfer = finalAmount
        operationBuilder.operationDescription = operation.operationDescription
        operationBuilder.paymentMethods = operation.paymentMethods
        operationBuilder.installments = [installment]
        let operation = operationBuilder.buidOperation()
        let confirmationVC = ConfirmationViewController(operation: operation)
        present(confirmationVC, animated: true)
    }

    @objc private func dismissControllers() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Table View Implementation

extension InstallmentsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return installments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InstallmentCell.identifier,
                                                 for: indexPath) as! InstallmentCell
        cell.feeLabel.text = "\(installments[indexPath.row].name) de $"
        cell.feeAmountLabel.text = calculationsViewModel.calculateValueForIndividualFee(operation, installments, indexPath)
        cell.totalAmountLabel.text = calculationsViewModel.calculateFinalValueForFee(operation, installments, indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let installment: Installment = installments[indexPath.row]
        let finalAmount: String = calculationsViewModel.calculateFinalValueForFee(operation, installments, indexPath)
        let finalAmountAsDouble: Double = finalAmount.formatAsDouble
        navigateToConfirmationWithMethod(finalAmount: finalAmountAsDouble, installment: installment)
    }
}
