//
//  InstallmentCell.swift
//  Payments
//
//  Created by Camila Storck on 07/06/2022.
//

import UIKit

class InstallmentCell: UITableViewCell {
    
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var feeAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    static let identifier = "installmentCell"
    static let name = "InstallmentCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
