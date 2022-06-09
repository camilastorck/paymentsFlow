//
//  DataManager.swift
//  Payments
//
//  Created by Camila Storck on 07/06/2022.
//

import UIKit

class DataManager {
    
    func readFileWith(name: String) -> Data? {
        do {
            guard let path = Bundle.main.path(forResource: name, ofType: "json"),
                  let jsonData = try String(contentsOfFile: path).data(using: .utf8) else { return nil }
            return jsonData
        } catch {
            return nil
        }
    }
    
    func getPaymentMethods() -> [Method] {
        guard let data = readFileWith(name: "payment_methods") else {
            return []
        }
        guard let decodedData = try? JSONDecoder().decode(Payment.self, from: data) else { return [] }
        return decodedData.methods
    }
    
    func getPaymentMethodsImages(for indexPath: IndexPath, methods: [Method]) -> UIImage? {
        guard let imageURL = URL(string: methods[indexPath.row].icon),
              let data = try? Data(contentsOf: imageURL) else { return nil }
        return UIImage(data: data)
    }
    
    func getInstallmentMethods() -> [Installment] {
        guard let data = readFileWith(name: "installments") else {
            return []
        }
        guard let decodedData = try? JSONDecoder().decode(Methods.self, from: data) else { return [] }
        return decodedData.installments
    }
    
}
