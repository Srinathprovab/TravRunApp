//
//  RegisterNowTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23.
//

import UIKit

class RegisterNowTableViewCell: TableViewCell {

    @IBOutlet weak var registerNowButton: UIButton!
    @IBOutlet weak var emailTextFld: UITextField!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var passwordTxtfld: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        emailTextFld.layer.borderWidth = 0.7
        emailTextFld.setLeftPaddingPoints(10)
        emailTextFld.layer.borderColor = HexColor("#B8B8B8").cgColor
        emailTextFld.layer.cornerRadius = 4
        
        passwordTxtfld.layer.borderWidth = 0.7
        passwordTxtfld.setLeftPaddingPoints(10)
        passwordTxtfld.layer.borderColor = HexColor("#B8B8B8").cgColor
        passwordTxtfld.layer.cornerRadius = 4
        registerNowButton.layer.cornerRadius = 4
    }
    
    override func updateUI() {
        if cellInfo?.key == "register" {
            middleView.isHidden = true
            registerNowButton.setTitle("Register Now", for: .normal)
        } else {
            middleView.isHidden = false
            registerNowButton.setTitle("login", for: .normal)
           
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
