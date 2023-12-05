//
//  FareTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 04/12/23.
//

import UIKit

class FareTableViewCell: UITableViewCell {

    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
