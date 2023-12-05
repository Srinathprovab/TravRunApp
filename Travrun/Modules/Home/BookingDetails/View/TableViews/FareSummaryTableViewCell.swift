//
//  FareSummaryTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 04/12/23.
//

import UIKit

class FareSummaryTableViewCell: TableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FareTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension FareSummaryTableViewCell {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FareTableViewCell
        if indexPath.row == 0 {
            cell.titleLabel.text = "Traveller x1 Adult"
            cell.subTitleLabel.text = "AED150.00"
            return cell
        } else  if indexPath.row == 1 {
            cell.titleLabel.text = "Fare"
            cell.subTitleLabel.text = "AED20.00"
            return cell
        } else  if indexPath.row == 2 {
            cell.titleLabel.text = "Taxes and Fees"
            cell.subTitleLabel.text = "AED15.00"
            return cell
        } else  if indexPath.row == 3 {
            cell.titleLabel.text = "Sub Total"
            cell.subTitleLabel.text = "AED180.00"
            return cell
        } else {
            cell.titleLabel.text = "Total Amount"
            cell.subTitleLabel.text = "AED180.00"
            cell.subTitleLabel.font = UIFont.InterSemiBold(size: 20)
            return cell
        }
    }
    
}
