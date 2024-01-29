//
//  AddonContentTVCell.swift
//  Burhantrips
//
//  Created by MA1882 on 20/01/24.
//

import UIKit

class AddonContentTVCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var priceImage: UILabel!
    @IBOutlet weak var checkBoxImage: UIImageView!
    @IBOutlet weak var leftICon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        holderView.addCornerRadiusWithShadow(color: HexColor("#000000").withAlphaComponent(0.2), borderColor: .clear, cornerRadius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}