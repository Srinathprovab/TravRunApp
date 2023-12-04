//
//  GuestRegisterTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23.
//

import UIKit

class GuestRegisterTableViewCell: TableViewCell {

    @IBOutlet weak var countryCodeTxtFld: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var phoneNumberTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        emailTxtFld.layer.borderWidth = 0.7
        emailTxtFld.setLeftPaddingPoints(10)
        emailTxtFld.layer.borderColor = HexColor("#B8B8B8").cgColor
        emailTxtFld.layer.cornerRadius = 4
        continueButton.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
    }
}
