//
//  ItineraryAddTVCell.swift
//  BabSafar
//
//  Created by FCI on 18/11/22.
//

import UIKit

class ItineraryAddTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var additneraryTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var tripstring = String()
    var depFind = Int()
    var fdetais = [FDFlightDetails]()
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
        tripstring = cellInfo?.title ?? ""
        fdetais = cellInfo?.moreData as! [FDFlightDetails]
        tvHeight.constant = CGFloat((fdetais.count * 222))
        additneraryTV.reloadData()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        //        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 5)
        setupTV()
    }
    
    
    func setupTV() {
        additneraryTV.register(UINib(nibName: "FlightInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        additneraryTV.delegate = self
        additneraryTV.dataSource = self
        additneraryTV.tableFooterView = UIView()
        additneraryTV.showsVerticalScrollIndicator = false
        additneraryTV.separatorStyle = .none
        additneraryTV.isScrollEnabled = false
    }
    
}




extension ItineraryAddTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fdetais.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FlightInfoTableViewCell {
            
            let data = fdetais[indexPath.row]
//            cell.separationLine.isHidden = true
//            if indexPath.row / 2 == 0 {
//                cell.separatorView.isHidden = true
//            } else {
//                cell.separatorView.isHidden = false
//            }
//            
            cell.timelbl.text = "Total time \(data.duration ?? "0")"
            cell.toCodeLabel.text = "(\(data.origin?.city ?? "") \(data.origin?.loc ?? ""))"
            cell.destinationCodeLabel.text = "(\(data.destination?.city ?? "") \(data.destination?.loc ?? ""))"
//            cell.cityTolbl.text = "\(data.origin?.city ?? "") to \(data.destination?.city ?? "")"
            cell.arivalTime.text = "\(data.origin?.time ?? "")"
            cell.airportlbl.text = "\(data.origin?.airport_name ?? "")"
            if data.origin?.terminal == "" {
                cell.terminal1lbl.text = "Terminal: "
            }else {
                cell.terminal1lbl.text = "Terminal: \(data.origin?.terminal ?? "0")"
            }
            
            cell.hourlbl1.text = data.duration
            cell.destTime.text = "\(data.destination?.time ?? "")"
            cell.destDate.text = "\(data.destination?.date ?? "")"
            cell.destlbl.text = "\(data.destination?.airport_name ?? "")"
            
            if data.destination?.terminal == "" {
                cell.destTerminal1lbl.text = "Terminal: "
            }else {
                cell.destTerminal1lbl.text = "Terminal: \(data.destination?.terminal ?? "0")"
            }
            
            cell.bottomLabel.text = "Layover Duration \(data.destination?.city ?? "") (\(data.destination?.loc ?? "")) \(data.layOverDuration ?? "")"
            
            if tableView.isLast(for: indexPath) {
//                cell.separationLine.isHidden = false
                cell.bottomLabel.textColor = HexColor("#000000")
                cell.bottomLabel.font = .InterRegular(size: 12)
                cell.bottomLabel.text = "Arrival flight in different day"
                cell.infoImage.isHidden = false
                cell.bottomLabel.textAlignment = .left
            }
            
            cell.AirwaysImg1.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            if tripstring == "0" {
                cell.departureReturnLabel.text = "Depart"
            }else {
                cell.departureReturnLabel.text = "Return"
            }
            
            c = cell
        }
        return c
    }
    
    
    
}
