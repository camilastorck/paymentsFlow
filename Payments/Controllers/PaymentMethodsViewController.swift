//
//  PaymentMethodsViewController.swift
//  Payments
//
//  Created by Camila Storck on 07/06/2022.
//

import UIKit

final class PaymentMethodsViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: MethodCell.name, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: MethodCell.identifier)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.collectionViewLayout = createLayout()
        }
    }

    // MARK: - Variables

    private let dataManager: DataManager
    private var methods: [Method] = []
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
        title = "Métodos de pago"
        fetchDataForPaymentInfo()
    }

    private func fetchDataForPaymentInfo() {
        methods = dataManager.getPaymentMethods()
        collectionView.reloadData()
    }

    private func navigateToInstallmentWithMethod(_ method: Method) {
        let operationBuilder = OperationBuilder()
        operationBuilder.amountToTransfer = operation.amountToTransfer
        operationBuilder.operationDescription = operation.operationDescription
        operationBuilder.paymentMethods = [method]
        operationBuilder.installments = []
        let operation = operationBuilder.buidOperation()
        let installmentsVC = InstallmentsViewController(calculationsViewModel: CalculationsViewModel(),
                                                        dataManager: DataManager(),
                                                        operation: operation)
        navigationController?.pushViewController(installmentsVC, animated: true)
    }
}

// MARK: - Collection View Implementation

extension PaymentMethodsViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return methods.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MethodCell.identifier,
                                                      for: indexPath) as! MethodCell
        cell.configureWith(image: dataManager.getPaymentMethodsImages(for: indexPath,
                                                                      methods: methods),
                                                                      text: methods[indexPath.row].name)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let method: Method = methods[indexPath.row]
        navigateToInstallmentWithMethod(method)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/8)), subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
