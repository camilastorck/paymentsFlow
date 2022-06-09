//
//  ConfirmationViewController.swift
//  Payments
//
//  Created by Camila Storck on 06/06/2022.
//

import UIKit

final class ConfirmationViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var operationTotalLabel: UILabel!
    @IBOutlet private weak var operationDescriptionLabel: UILabel!
    @IBOutlet private weak var totalAmountWithFeesLabel: UILabel!
    @IBOutlet private weak var paymentMethodLabel: UILabel!
    @IBOutlet private weak var confirmPaymentButton: UIButton! {
        didSet {
            confirmPaymentButton.layer.cornerRadius = 10
        }
    }

    private var operation: Operation

    init(operation: Operation) {
        self.operation = operation
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Confirmación"
        setOperationInfo()
    }

    @IBAction private func confirmOperation(_ sender: UIButton) {
        showAlert()
    }

    private func setOperationInfo() {
        operationTotalLabel.text = "\(operation.amountToTransfer)"
        operationDescriptionLabel.text = operation.operationDescription
        totalAmountWithFeesLabel.text = operation.installments.first?.name
        if let paymentMethod = operation.paymentMethods.first {
            paymentMethodLabel.text = "\(paymentMethod.name)"
        }
    }

    private func showAlert() {
        let alert = UIAlertController(title: "¡Operación exitosa!",
                                      message: "Verás reflejado el resultado en los próximos minutos.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: { [weak self] _ in
            guard let self = self else { return }
            NotificationCenter.default.post(name: .updateOperationValues, object: nil)
            NotificationCenter.default.post(name: .dismissControllers, object: nil)
            self.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
}
