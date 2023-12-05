//
//  AcceptTermsAndConditionTVCell.swift
//  BabSafar
//
//  Created by FCI on 16/02/23.
//

import UIKit


protocol AcceptTermsAndConditionTVCellDelegate {
    func didTapOnTAndCAction(cell:AcceptTermsAndConditionTVCell)
    func didTapOnPrivacyPolicyAction(cell:AcceptTermsAndConditionTVCell)
}

class AcceptTermsAndConditionTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    var checkBool = true
    var delegate: AcceptTermsAndConditionTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    override func updateUI() {
        titlelbl.text = "Lorem ipsum dolor sit amet consectetur. Arcu imperdiet nulla molestie luctus eget. Sit et nunc dignissim nunc. Sapien vitae malesuada urna ut non. Sed id tristique sollicitudin elit lectus viverra sapien nulla. Dolor ut commodo augue malesuada nullam."
//        setAttributedString(str1: "I Accept ", str2: "T&C ",str3: "and ", str4: "Privacy Policy")
    }
    
    func setupUI() {
        checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
    }
    
    
//    func setAttributedString(str1:String,str2:String,str3:String,str4:String) {
//        
//        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.InterRegular(size: 14)] as [NSAttributedString.Key : Any]
//        let atter2 = [NSAttributedString.Key.foregroundColor:HexColor("#00A898"),NSAttributedString.Key.font:UIFont.InterRegular(size: 14)] as [NSAttributedString.Key : Any]
//        
//        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
//        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
//        let atterStr3 = NSMutableAttributedString(string: str3, attributes: atter1)
//        let atterStr4 = NSMutableAttributedString(string: str4, attributes: atter2)
//        
//        let combination = NSMutableAttributedString()
//        combination.append(atterStr1)
//        combination.append(atterStr2)
//        combination.append(atterStr3)
//        combination.append(atterStr4)
//        titlelbl.attributedText = combination
//        
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
//        titlelbl.addGestureRecognizer(tapGesture)
//        titlelbl.isUserInteractionEnabled = true
//    }
//    
//    @objc func labelTapped(gesture:UITapGestureRecognizer) {
//        if gesture.didTapAttributedString("T&C", in: titlelbl) {
//            checkBool = false
//            checkTermsAndCondationStatus = true
//            checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
//            delegate?.didTapOnTAndCAction(cell: self)
//        }else if gesture.didTapAttributedString("Privacy Policy", in: titlelbl){
//            checkBool = false
//            checkTermsAndCondationStatus = true
//            checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
//            delegate?.didTapOnPrivacyPolicyAction(cell: self)
//        }
//    }
//    
    
    @IBAction func didTapOnCheckTCBtnAction(_ sender: Any) {
        if checkBool == true {
            checkTermsAndCondationStatus = true
            checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
            checkBool = false
        }else {
            checkTermsAndCondationStatus = false
            checkImg.image = UIImage(named: "checkBox")?.withRenderingMode(.alwaysOriginal)
            checkBool = true
        }
    }
}
