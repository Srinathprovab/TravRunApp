//
//  QuickLinkTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 15/11/23.
//

import UIKit

protocol QuickLinkTableViewCellDelegate {
    func didTaponFlightBtn(cell: QuickLinkTableViewCell)
    func didTaponHotelBtn(cell: QuickLinkTableViewCell)
    func didTaponautoPayButton(cell: QuickLinkTableViewCell)
    func didTaponvisaButton(cell: QuickLinkTableViewCell)
}



class QuickLinkTableViewCell: TableViewCell {

    @IBOutlet weak var holderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var holderView: UIView!
    
    var delegate: QuickLinkTableViewCellDelegate?
    var links = ["Flight", "Hotel", "Visa", "Auto Payment"]
    var bookings = ["My Bookings", "Free Cancellation", "Customer Support"]
    var tabNamesImages = ["flightIcon","hotelIcon","visaIcon", "payIcon"]
    override func awakeFromNib() {
        super.awakeFromNib()
        holderView.layer.cornerRadius = 12
        holderView.layer.borderColor = HexColor("#DADCDB").cgColor
        holderView.layer.borderWidth = 1
    }
    
    override func updateUI() {}
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func visaButtonAction(_ sender: Any) {
        delegate?.didTaponvisaButton(cell: self)
    }
    @IBAction func FlightButtonAction(_ sender: Any) {
        delegate?.didTaponFlightBtn(cell: self)
    }
    
    @IBAction func autoPayButtonAction(_ sender: Any) {
        delegate?.didTaponautoPayButton(cell: self)
    }
    @IBAction func hotelButtonAction(_ sender: Any) {
        delegate?.didTaponHotelBtn(cell: self)
    }
}
