//
//  AddAdultTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 04/12/23.
//

import UIKit

class AddAdultTableViewCell: TableViewCell{

    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var FnameTF: UITextField!
    @IBOutlet weak var NameTitleSelectBtn: UIButton!
    @IBOutlet weak var FlyerNoTF: UITextField!
    @IBOutlet weak var TitleTF: UITextField!
    @IBOutlet weak var FlyerProgramTF: UITextField!
    @IBOutlet weak var FlyerPgmBtn: UIButton!
    @IBOutlet weak var PassportExpireDateTF: UITextField!
    @IBOutlet weak var passportIssueingCountrySelectBtn: UIButton!
    @IBOutlet weak var passportIssuingCountryTF: UITextField!
    @IBOutlet weak var PassportnoTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var MobileTF: UITextField!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var CountrycodeTF: UITextField!
    @IBOutlet weak var passangerView: UIView!
    @IBOutlet weak var passangerSelectionButton: UIButton!
    @IBOutlet weak var passengerSelectionTextfield: UITextField!
    @IBOutlet weak var countryCodeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 0.7
        contentView.layer.borderColor = HexColor("#B8B8B8").cgColor
        setUI()
        // Initialization code
    }
    
   func setUI() {
       setupTextField(txtField: TitleTF, tag1: 11, label: "Title*", placeholder: "MR")
       setupTextField(txtField: FnameTF, tag1: 1, label: "First Name*", placeholder: "First Name")
       setupTextField(txtField: lnameTF, tag1: 2, label: "Last Name*", placeholder: "Last Name")
       setupTextField(txtField: dobTF, tag1: 3, label: "Date of Birth*", placeholder: "DOB")
       setupTextField(txtField: PassportnoTF, tag1: 5, label: "Passport NO*", placeholder: "Passport NO")
       setupTextField(txtField: passportIssuingCountryTF, tag1: 6, label: "Passport Issuing Country*", placeholder: "Issuing Country")
       setupTextField(txtField: PassportExpireDateTF, tag1: 7, label: "Passport Expiry Date*", placeholder: "Expiry Date")
       setupTextField(txtField: FlyerProgramTF, tag1: 8, label: "Flyer Program ", placeholder: "Flyer Program")
       setupTextField(txtField: FlyerNoTF, tag1: 9, label: "Flyer Number ", placeholder: "Flyer Number")
       
       setupTextField(txtField: EmailTF, tag1: 0, label: "Email Address", placeholder: "Email Address")
       
       setupTextField(txtField: MobileTF, tag1: 0, label: "Enter Mobile Number", placeholder: "Mobile Address")
       passengerSelectionTextfield.setLeftPaddingPoints(12)
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupTextField(txtField:UITextField,tag1:Int,label:String,placeholder:String) {
        txtField.setLeftPaddingPoints(15)
        txtField.delegate = self
        txtField.tag = tag1
        txtField.placeholder = placeholder
        txtField.textColor = .AppLabelColor
        txtField.backgroundColor = .clear
        txtField.font = UIFont.InterRegular(size: 16)
//        txtField.addTarget(self, action: #selector(editingTextField1(textField:)), for: .editingChanged)
        
    }
    
}
