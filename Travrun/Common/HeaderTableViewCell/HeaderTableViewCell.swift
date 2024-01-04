//
//  HeaderTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 15/11/23.
//

import UIKit

class HeaderTableViewCell: TableViewCell {

    @IBOutlet weak var buttonView: BorderedView!
    @IBOutlet weak var leadingCopnst: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonView.isHidden = true
    }
    
    override func updateUI() {
        if cellInfo?.key == "note" {
            leadingCopnst.constant = 0
            titleLabel.text = "Please Note"
            titleLabel.textColor = .AppLabelColor
            titleLabel.font = .InterMedium(size: 12)
        } else if cellInfo?.key == "Lorem" {
            leadingCopnst.constant = 0
            titleLabel.text = cellInfo?.text
            titleLabel.textColor = HexColor("#434242")
            titleLabel.font = .InterRegular(size: 12)
        } else if cellInfo?.key == "Passenger(s) Details" {
            titleLabel.text = cellInfo?.key
            titleLabel.font = UIFont.latoSemiBold(size: 16)
            titleLabel.textColor = .AppLabelColor
            leadingCopnst.constant = 0
        }  else if cellInfo?.key == "Important Information" {
            titleLabel.text = cellInfo?.key
            titleLabel.font = UIFont.latoSemiBold(size: 16)
            titleLabel.textColor = .AppLabelColor
            leadingCopnst.constant = 0
        } else if cellInfo?.key == "checkin" {
            titleLabel.text = cellInfo?.title
            titleLabel.font = UIFont.InterRegular(size: 12)
            titleLabel.textColor = .AppLabelColor
            leadingCopnst.constant = 0
        }
        
        else {
            titleLabel.text = cellInfo?.key
            titleLabel.font = UIFont.InterMedium(size: 20)
            titleLabel.textColor = .AppLabelColor
        }
        
        if cellInfo?.title == "AddAdult" {
            buttonView.isHidden = false
            titleLabel.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
