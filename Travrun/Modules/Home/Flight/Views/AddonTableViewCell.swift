//
//  AddonTableViewCell.swift
//  Burhantrips
//
//  Created by MA1882 on 20/01/24.
//

import UIKit

protocol AddonTableViewCellDelegate {
    func didSelectAddon(index: Int)
    func didDeselectAddon(index: Int)
}


class AddonTableViewCell: TableViewCell, UITableViewDelegate, UITableViewDataSource {
   
    var services = ["WhatsApp services", "Flexible Booking", "Price Change", "Notification"]
    var icons = ["messageIcon","bookingIcon","priceChangeICon","NotificationIcon"]
    var delegate: AddonTableViewCellDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let nib = UINib(nibName: "AddonContentTVCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AddonTableViewCell {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addon_services.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddonContentTVCell {
            let data = addon_services[indexPath.row]
            whatsAppPrice =  addon_services[0].price ?? "0"
            flexiblePrie =  addon_services[1].price ?? "0"
            priceChange =  addon_services[2].price ?? "0"
            notificationPrice = addon_services[3].price ?? "0"
            cell.selectionStyle = .none
            cell.leftICon.sd_setImage(with: URL(string: data.image ?? ""))
            cell.titleLabel.text = data.title
            cell.subTitleLabel.text = data.details
            cell.priceImage.text = "\(defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD") \(data.price ?? "0")"
            
            ccell = cell
        }
        return ccell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AddonContentTVCell {
            isChecked.toggle()
            if isChecked {
                cell.checkIMAGE.image = UIImage(named: "redcheckBox")
                delegate?.didDeselectAddon(index: indexPath.row)
            } else {
                cell.checkIMAGE.image = UIImage(named: "uncheck")
                delegate?.didSelectAddon(index: indexPath.row)
            }
        }
    }
    
}
