//
//  NewAboutUsTVCell.swift
//  Burhantrips
//
//  Created by MA1882 on 06/02/24.
//

import UIKit

class NewAboutUsTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var arrowImg: UIImageView!
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
        titlelbl.text = cellInfo?.title
    }
    
    func setupUI() {
        holderView.addCornerRadiusWithShadow(color: HexColor("#CFECFF").withAlphaComponent(1), borderColor: .clear, cornerRadius: 6)
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: . InterRegular(size: 18))
    }
    
   
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
}
