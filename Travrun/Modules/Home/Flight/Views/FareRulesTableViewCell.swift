//
//  FareRulesTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 24/11/23.
//

import UIKit

class FareRulesTableViewCell: TableViewCell {

    @IBOutlet weak var ServiceLabel: UILabel!
    @IBOutlet weak var rightDescription: UILabel!
    @IBOutlet weak var leftDescription: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
  
    
    var fareRules = [FareRulesData]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func updateUI() {
        
//        fareRules = cellInfo?.moreData as! [FareRulesData]
        
        if cellInfo?.key == "Cancellation Fee" {
//            subTitleLabel.text = fareRules[indexPath].rule_heading
            
            leftDescription.text = "cancellation Free (airline Cancellation Chages)Cancellation done Before the departure)1"
            rightDescription.text = "EGP 150.00 FOR cancellations done Before departure of the first Flight"
        } else {
            titleLabel.text = "Date Change Fee"
            leftDescription.text = "Airline Date change"
            rightDescription.text = "AED 150.00  + fare difference (if applicable)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
