//
//  NewFlightSearchResultTVCell.swift
//  BabSafar
//
//  Created by FCI on 12/09/23.
//

import UIKit

protocol NewFlightSearchResultTVCellDelegate {
    func didTapOnFlightDetailsBtnAction(cell:NewFlightSearchResultTVCell)
    func didTapOnBookNowBtnAction(cell:NewFlightSearchResultTVCell)
    func didTapOnAddReturnFlightBtnAction(cell:NewFlightSearchResultTVCell)
    func didTapOnMoreSimilarBtnAction(cell:NewFlightSearchResultTVCell)
    func didTapOnflightDetailsButton
    (cell:NewFlightSearchResultTVCell)
    func didTapOnAddReturnFlightAction(cell:NewFlightSearchResultTVCell)
}


class NewFlightSearchResultTVCell: TableViewCell {
    
    @IBOutlet weak var addReturnView: BorderedView!
    @IBOutlet weak var markuppricelbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var faretypelbl: UILabel!
    @IBOutlet weak var flighTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var moreSimlarOptionlbl: UILabel!
    @IBOutlet weak var similarBtn: UIButton!
    @IBOutlet weak var similarimg: UIImageView!
    
    var key = ""
    var displayPrice = String()
    var bsource = String()
    var bsourcekey = String()
    var delegate: NewFlightSearchResultTVCellDelegate?
    var selectedResult = String()
    var newsimilarList = [[J_flight_list]]()
    var newsimilarListMulticity = [[MCJ_flight_list]]()
    var flightSummery = [Summary]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        hideSimilarlbl()
    }
    
    override func updateUI() {
        setAttributedString1(str1: "\(cellInfo?.buttonTitle ?? ""):", str2: String(format: "%.2f", Double(cellInfo?.title ?? "") ?? 0.0))
        setAttributedTextnew(str1: cellInfo?.buttonTitle ?? "",
                             str2: String(format: "%.2f", Double(cellInfo?.price ?? "") ?? 0.0),
                             lbl: pricelbl,
                             str1font: UIFont.InterRegular(size: 12),
                             str2font: UIFont.InterBold(size: 20),
                             str1Color: .AppLabelColor,
                             str2Color: HexColor("#EE1935"))
        
        faretypelbl.text = cellInfo?.subTitle
        flightSummery = cellInfo?.moreData as? [Summary] ?? []
        selectedResult = cellInfo?.text ?? ""
        displayPrice = cellInfo?.price ?? ""
        
        bsource = cellInfo?.bookingsource ?? ""
        bsourcekey = cellInfo?.bookingsourcekey ?? ""
        
        if faretypelbl.text == "Refundable" {
            faretypelbl.textColor = .white
        }else {
            faretypelbl.textColor = HexColor("#F96800")
        }
        
        
        if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedJourneyType != "oneway" {
                addReturnView.isHidden = true
                key = "circle"
            }
        }
        
        
        if cellInfo?.key == "similar" {
            hideSimilarlbl()
        }
        
        if let similarList1 = cellInfo?.data as? [[J_flight_list]] {
            newsimilarList = similarList1
            let similarListCount = similarList1.count
            
            // Debugging: Print the count of similarList1
            print("Similar List Count: \(similarListCount)")
            
            if similarListCount > 1 {
                setuplabels(lbl: moreSimlarOptionlbl, text: "More similar options(\(similarListCount))", textcolor: UIColor.WhiteColor, font: UIFont.latoRegular(size: 12), align: .right)
                showSimilarlbl()
            } else {
                hideSimilarlbl()
            }
        } else if let similarList1 = cellInfo?.data as? [[MCJ_flight_list]] {
            newsimilarListMulticity = similarList1
            let similarListCount = similarList1.count
            
            // Debugging: Print the count of similarList1
            print("Similar List Count: \(similarListCount)")
            
            if similarListCount > 1 {
                setuplabels(lbl: moreSimlarOptionlbl, text: "More similar options(\(similarListCount))", textcolor: .WhiteColor, font: UIFont.latoRegular(size: 14), align: .right)
                showSimilarlbl()
            } else {
                hideSimilarlbl()
            }
        } else {
            hideSimilarlbl() // Handle the case when cellInfo?.data is not a valid [[J_flight_list]]
        }
        
        
        updateHeight()
    }
    
    
    func updateHeight() {
        tvheight.constant = CGFloat(flightSummery.count * 141)
        flighTV.reloadData()
    }
    
    
    func setupUI() {
        addReturnView.isHidden = false
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] // Bottom left corner, Bottom right corner respectively
        bottomView.layer.cornerRadius = 10
        bottomView.clipsToBounds = true
        
        hideSimilarlbl()
        setupTV()
    }
    
    
    @IBAction func didTapOnFlightDetailsBtnAction(_ sender: Any) {
        delegate?.didTapOnFlightDetailsBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnAddReturnFlightBtnAction(_ sender: Any) {
        delegate?.didTapOnAddReturnFlightAction(cell: self)
    }
    
    
    @IBAction func didTapOnMoreSimilarBtnAction(_ sender: Any) {
        delegate?.didTapOnMoreSimilarBtnAction(cell: self)
    }
    
    @IBAction func didTapOnflightDetailsButton(_ sender: Any) {
        delegate?.didTapOnflightDetailsButton(cell: self)
    }
    
}




extension NewFlightSearchResultTVCell: UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        let nib = UINib(nibName: "AddFlightInfoTVCell", bundle: nil)
        flighTV.register(nib, forCellReuseIdentifier: "cell")
        flighTV.delegate = self
        flighTV.dataSource = self
        flighTV.tableFooterView = UIView()
        flighTV.separatorStyle = .none
        flighTV.isScrollEnabled = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightSummery.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddFlightInfoTVCell {
            cell.selectionStyle = .none
            
            let data = flightSummery[indexPath.row]
            
            cell.economyLabel.text =  data.cabin_class
            cell.airlinelogo.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            cell.airlinelbl.text = "(\(data.operator_code ?? "")-\(data.flight_number ?? ""))"
            cell.durationlbl.text = data.duration ?? ""
            cell.noofStopslbl.text = "\(data.no_of_stops ?? 0) Stops"
            
            cell.fromTimelbl.text = data.origin?.time ?? ""
            cell.fromCitylbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
            cell.toTimelbl.text = data.destination?.time ?? ""
            cell.toCitylbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
            //            cell.deplogo.image = UIImage(named: "dep")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
            
            if data.weight_Allowance == "" || data.weight_Allowance == nil {
                cell.cabinlbl.text = "0Kg"
                cell.checkinBaggagelbl.text = "0Kg"
            } else {
                cell.checkinBaggagelbl.text = convertToDesiredFormat(data.weight_Allowance ?? "")
                cell.cabinlbl.text = convertToDesiredFormat(data.weight_Allowance ?? "")
            }
            
            cell.separatorLabel.isHidden = true
            if key == "circle" {
                cell.separatorLabel.isHidden = false
                if tableView.isLast(for: indexPath) == true {
                    cell.separatorLabel.isHidden = true
//                    cell.topView.isHidden = true
                }
            }
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}


extension NewFlightSearchResultTVCell {
    
    
    func hideSimilarlbl(){
        //        bottomView.backgroundColor = .clear
        //        similarimg.isHidden = true
        similarBtn.isHidden = true
        similarimg.isHidden = true
        moreSimlarOptionlbl.isHidden = true
    }
    
    func showSimilarlbl(){
        bottomView.backgroundColor = HexColor("3C627A")
        similarimg.isHidden = false
        similarBtn.isHidden = false
        moreSimlarOptionlbl.isHidden = false
    }
    
    
    
    func setAttributedString1(str1:String,str2:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.IttenarySelectedColor,NSAttributedString.Key.font:UIFont.latoBold(size: 10),NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.IttenarySelectedColor,NSAttributedString.Key.font:UIFont.latoBold(size: 14),NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        
        markuppricelbl.attributedText = combination
        
    }
    
}
