//
//  MethodCell.swift
//  Payments
//
//  Created by Camila Storck on 07/06/2022.
//

import UIKit

final class MethodCell: UICollectionViewCell {

    @IBOutlet private weak var methodImageView: UIImageView!
    @IBOutlet private weak var methodLabel: UILabel!

    static let name = "MethodCell"
    static let identifier = "methodCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureWith(image: UIImage?, text: String) {
        methodImageView.image = image
        methodLabel.text = text
    }
}
