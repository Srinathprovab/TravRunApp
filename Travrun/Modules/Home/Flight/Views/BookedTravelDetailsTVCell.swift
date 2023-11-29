//
//  BookedTravelDetailsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookedTravelDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var labelsView: UIView!
    @IBOutlet weak var travellerNamelbl: UILabel!
    @IBOutlet weak var typelbl: UILabel!
    @IBOutlet weak var seatlbl: UILabel!
    @IBOutlet weak var ulView: UIView!
    @IBOutlet weak var adultDetailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var Customerdetails = [Customer_details]()
    var hCustomerdetails = [HCustomer_details]()
    var iCustomerdetails = [ICustomer_details]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override func updateUI() {
        
        
        
         let selectedTap = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String
            
            
            if selectedTap == "Flights" {
                Customerdetails = cellInfo?.moreData as? [Customer_details] ?? []
                
                if Customerdetails.count > 0 {
                    tvHeight.constant = CGFloat(Customerdetails.count * 48)
                }
            }else if selectedTap == "Hotels" {
                hCustomerdetails = cellInfo?.moreData as? [HCustomer_details] ?? []
                if hCustomerdetails.count > 0 {
                    tvHeight.constant = CGFloat(hCustomerdetails.count * 35)
                }
            }else {
                
                iCustomerdetails = cellInfo?.moreData as? [ICustomer_details] ?? []
                if iCustomerdetails.count > 0 {
                    tvHeight.constant = CGFloat(iCustomerdetails.count * 35)
                }
            }
            
        
        adultDetailsTV.reloadData()
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        holderView.layer.borderWidth = 1
        setupViews(v: labelsView, radius: 0, color: .WhiteColor)
        labelsView.layer.borderColor = UIColor.WhiteColor.cgColor
        // labelsView.addBottomBorderWithColor(color: .SubTitleColor, width: 1)
        ulView.backgroundColor = HexColor("#E6E8E7")
        setuplabels(lbl: travellerNamelbl, text: "Traveller Name", textcolor: HexColor("#5B5B5B"), font: .latoRegular(size: 13), align: .center)
        setuplabels(lbl: typelbl, text: "Ticket No", textcolor: HexColor("#5B5B5B"), font: .latoRegular(size: 13), align: .center)
        setuplabels(lbl: seatlbl, text: "Status", textcolor: HexColor("#5B5B5B"), font: .latoRegular(size: 13), align: .center)
        travellerNamelbl.text = "Passenger Name"
        typelbl.text = "Passport No"
        seatlbl.text = "    Country"
    }
    
    func setupTV() {
        adultDetailsTV.register(UINib(nibName: "BookedAdultDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        adultDetailsTV.register(UINib(nibName: "BookedAdultDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        adultDetailsTV.register(UINib(nibName: "BookedAdultDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        
        adultDetailsTV.delegate = self
        adultDetailsTV.dataSource = self
        adultDetailsTV.tableFooterView = UIView()
        adultDetailsTV.showsHorizontalScrollIndicator = false
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
}


extension BookedTravelDetailsTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let selectedTap = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String {
            
            
            if selectedTap == "Flights" {
                return Customerdetails.count
            }else if selectedTap == "Hotels"{
                return hCustomerdetails.count
            }else {
                return iCustomerdetails.count
            }
            
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        
        if let selectedTap = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String {
            
            
            
            if selectedTap == "Flights" {
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BookedAdultDetailsTVCell {
                    cell.selectionStyle = .none
                    
                    let data = Customerdetails[indexPath.row]
                    cell.travellerNamelbl.text = "\(data.first_name ?? "") \(data.last_name ?? "")"
                    cell.typelbl.text = data.passport_number ?? ""
                    cell.seatlbl.text = data.passenger_nationality_name ?? ""
                    if indexPath.row == 0{
                        cell.setAttributedText(str1: "\(data.first_name ?? "") \(data.last_name ?? "")", str2: "\n\(cellInfo?.title ?? "")")
                    }
                    
                    
                    c = cell
                }
                
            }else if selectedTap == "Hotels" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? BookedAdultDetailsTVCell {
                    cell.selectionStyle = .none
                    
                    let data = hCustomerdetails[indexPath.row]
                    cell.travellerNamelbl.text = "\(data.first_name ?? "") \(data.last_name ?? "")"
                    cell.typelbl.text = data.pax_type ?? ""
                    cell.seatlbl.text = data.pax_type ?? ""
                    if indexPath.row == 0{
                        cell.setAttributedText(str1: "\(data.first_name ?? "") \(data.last_name ?? "")", str2: "\n\(cellInfo?.title ?? "")")
                    }
                    
                    c = cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? BookedAdultDetailsTVCell {
                    cell.selectionStyle = .none
                    
                    let data = iCustomerdetails[indexPath.row]
                    cell.travellerNamelbl.text = "\(data.first_name ?? "") \(data.last_name ?? "")"
                    cell.typelbl.text = data.passport_number ?? ""
                    cell.seatlbl.text = data.passport_nationality ?? ""
                    if indexPath.row == 0{
                        cell.setAttributedText(str1: "\(data.first_name ?? "") \(data.last_name ?? "")", str2: "\n\(cellInfo?.title ?? "")")
                    }
                    
                    c = cell
                }
            }
            
            
            
        }else {
            
        }
        return c
    }
    
    
    
}
