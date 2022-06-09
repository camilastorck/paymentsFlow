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

    private let dataManager: DataManager
    private var installments: [Installment] = []
    private var operation: Operation
    
    init(dataManager: DataManager, operation: Operation) {
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
    }
    
    private func fetchDataForInstallmentsInfo() {
        installments = dataManager.getInstallmentMethods()
        tableView.reloadData()
    }
    
    private func getValueForFee(indexPath: IndexPath) -> String {
        
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
    
    private func getFinalAmountWithInterestForFee(indexPath: IndexPath) -> String {
        
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

// MARK: - Table View Implementation

extension InstallmentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return installments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InstallmentCell.identifier, for: indexPath) as! InstallmentCell
        cell.feeLabel.text = "\(installments[indexPath.row].name) de $"
        cell.feeAmountLabel.text = getValueForFee(indexPath: indexPath)
        cell.totalAmountLabel.text = getFinalAmountWithInterestForFee(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let installment: Installment = installments[indexPath.row]
        let finalAmount: Double = getFinalAmountWithInterestForFee(indexPath: indexPath).formatAsDouble
        navigateToConfirmationWithMethod(finalAmount: finalAmount, installment: installment)
    }
    
    private func navigateToConfirmationWithMethod(finalAmount: Double, installment: Installment) {
        let operationBuilder = OperationBuilder()
        operationBuilder.amountToTransfer = finalAmount
        operationBuilder.operationDescription = operation.operationDescription
        operationBuilder.paymentMethods = operation.paymentMethods
        operationBuilder.installments = [installment]
        guard let operation = operationBuilder.buidOperation() else { return }
        let confirmationVC = ConfirmationViewController(operation: operation)
        navigationController?.pushViewController(confirmationVC, animated: true)
    }
}
