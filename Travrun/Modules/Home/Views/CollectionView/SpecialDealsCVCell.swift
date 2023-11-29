//
//  SpecialDealsCVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SpecialDealsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var bookinglbl: UILabel!
    @IBOutlet weak var promoCodelbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        holderView.layer.borderWidth = 0.6
        holderView.layer.borderColor = UIColor.lightGray.cgColor
        holderView.layer.cornerRadius = 6
        offerImage.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        offerImage.clipsToBounds = true
        bookinglbl.textColor = .AppLabelColor
        bookinglbl.font = UIFont.InterMedium(size: 16)
        bookinglbl.textAlignment = .center
        promoCodelbl.textColor = .AppLabelColor
        promoCodelbl.textAlignment = .center
        promoCodelbl.font = UIFont.InterRegular(size: 12)
    }
    
}

extension CALayer {
    func applyShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
