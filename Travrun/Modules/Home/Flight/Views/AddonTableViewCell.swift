//
//  AddonTableViewCell.swift
//  Burhantrips
//
//  Created by MA1882 on 20/01/24.
//

import UIKit

class AddonTableViewCell: TableViewCell, UITableViewDelegate, UITableViewDataSource {
   
    var services = ["WhatsApp services", "Flexible Booking", "Price Change", "Notification"]
    var icons = ["messageIcon","bookingIcon","priceChangeICon","NotificationIcon"]

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
        services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddonContentTVCell {
            cell.selectionStyle = .none
            cell.titleLabel.text = services[indexPath.row]
            cell.leftICon.image = UIImage(named: icons[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#3C627A"))
            
            ccell = cell
        }
        return ccell
    }
    
}
