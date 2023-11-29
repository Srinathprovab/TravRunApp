//
//  FlightDetailsViewController.swift
//  Travrun
//
//  Created by MA1882 on 23/11/23.
//

import UIKit

class FlightDetailsViewController: BaseTableVC {
    @IBOutlet weak var tvTraling: NSLayoutConstraint!
    
    @IBOutlet weak var middleConstraint: NSLayoutConstraint!
    @IBOutlet weak var tvLeading: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bagInfoLabel: UILabel!
    @IBOutlet weak var breakDownLabel: UILabel!
    @IBOutlet weak var farerulesLabel: UILabel!
    @IBOutlet weak var iternaryLabel: UILabel!
    @IBOutlet weak var fareRulesView: BorderedView!
    @IBOutlet weak var bagInfoView: BorderedView!
    @IBOutlet weak var breakdownView: BorderedView!
    @IBOutlet weak var iternaryView: BorderedView!
    
    static var newInstance: FlightDetailsViewController? {
        let storyboard = UIStoryboard(name: Storyboard.FlightStoryBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightDetailsViewController
        return vc
    }
    
    var tableRow = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       registerTv() 
       setUpView()
    }
    
    func registerTv() {
        self.commonTableView.registerTVCells(["FlightInfoTableViewCell", "FareBreakDownTableViewCell","totalDiscountTVCell", "FareRulesTableViewCell", "EmptyTVCell", "BaggageInfoTableViewCell", "ContactUsLabelTVCell", "HeaderTableViewCell"])
    }
    
    func setUpView() {
        topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topView.layer.cornerRadius = 30
        topView.clipsToBounds = true
        setUpTableView()
    }
    
    
    func setUpTableView() {
        tableRow.removeAll()
        tvLeading.constant = 0
        middleConstraint.constant = 0
        tvTraling.constant = 0
        tableRow.append(TableRow(key: "show", cellType: .FlightInfoTableViewCell))
        tableRow.append(TableRow(key: "hide", cellType: .FlightInfoTableViewCell))
        tableRow.append(TableRow(key: "all", cellType: .FlightInfoTableViewCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    func setUpBreakDown() {
        middleConstraint.constant = 13
        tvLeading.constant = 15
        tvTraling.constant = 15
        tableRow.removeAll()
        tableRow.append(TableRow(cellType: .FareBreakDownTableViewCell))
        tableRow.append(TableRow(cellType: .totalDiscountTVCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    func setUpFareRules() {
        middleConstraint.constant = 13
        tvLeading.constant = 15
        tvTraling.constant = 15
        tableRow.removeAll()
        tableRow.append(TableRow(key: "Cancellation Fee",cellType: .FareRulesTableViewCell))
        tableRow.append(TableRow(height: 20,bgColor: UIColor.clear, cellType: .EmptyTVCell))
        tableRow.append(TableRow(key: "Airline Date change",cellType: .FareRulesTableViewCell))
        tableRow.append(TableRow(height: 20,bgColor: UIColor.clear, cellType: .EmptyTVCell))
        tableRow.append(TableRow(key:"note",bgColor: UIColor.clear, cellType: .HeaderTableViewCell))
        tableRow.append(TableRow(height: 7,bgColor: UIColor.clear, cellType: .EmptyTVCell))
        tableRow.append(TableRow(key:"Lorem",height: 85, bgColor: UIColor.clear, cellType: .HeaderTableViewCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    func setUpBaggageInfo() {
        middleConstraint.constant = 13
        tvLeading.constant = 15
        tvTraling.constant = 15
        tableRow.removeAll()
        tableRow.append(TableRow(cellType: .BaggageInfoTableViewCell))
        tableRow.append(TableRow(height: 11, bgColor: .clear, cellType: .EmptyTVCell))
        tableRow.append(TableRow(key: "info",height: 40, bgColor: UIColor.clear, cellType: .ContactUsLabelTVCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    

    @IBAction func breakDownButtonAction(_ sender: Any) {
        breakdownView.layer.borderColor = UIColor.clear.cgColor
        fareRulesView.layer.borderColor = HexColor("#D4D4D4").cgColor
        bagInfoView.layer.borderColor = HexColor("#D4D4D4").cgColor
        iternaryView.layer.borderColor = HexColor("#D4D4D4").cgColor
        breakdownView.backgroundColor = HexColor("3C627A")
        breakDownLabel.textColor = HexColor("#FFFFFF")
        fareRulesView.backgroundColor = HexColor("#FFFFFF")
        farerulesLabel.textColor = HexColor("#000000")
        iternaryView.backgroundColor = HexColor("#FFFFFF")
        iternaryLabel.textColor = HexColor("#000000")
        bagInfoView.backgroundColor = HexColor("#FFFFFF")
        bagInfoLabel.textColor = HexColor("#000000")
        setUpBreakDown()
    }
    
    @IBAction func iterenaryButtonAction(_ sender: Any) {
        iternaryView.layer.borderColor = UIColor.clear.cgColor
        fareRulesView.layer.borderColor = HexColor("#D4D4D4").cgColor
        bagInfoView.layer.borderColor = HexColor("#D4D4D4").cgColor
        breakdownView.layer.borderColor = HexColor("#D4D4D4").cgColor
        iternaryView.backgroundColor = HexColor("3C627A")
        iternaryLabel.textColor = HexColor("#FFFFFF")
        fareRulesView.backgroundColor = HexColor("#FFFFFF")
        farerulesLabel.textColor = HexColor("#000000")
        breakdownView.backgroundColor = HexColor("#FFFFFF")
        breakDownLabel.textColor = HexColor("#000000")
        bagInfoView.backgroundColor = HexColor("#FFFFFF")
        bagInfoLabel.textColor = HexColor("#000000")
        setUpTableView()
    }
    
    @IBAction func fareRulesButtonAction(_ sender: Any) {
        fareRulesView.layer.borderColor = UIColor.clear.cgColor
        bagInfoView.layer.borderColor = HexColor("#D4D4D4").cgColor
        iternaryView.layer.borderColor = HexColor("#D4D4D4").cgColor
        breakdownView.layer.borderColor = HexColor("#D4D4D4").cgColor
        fareRulesView.backgroundColor = HexColor("3C627A")
        farerulesLabel.textColor = HexColor("#FFFFFF")
        iternaryView.backgroundColor = HexColor("#FFFFFF")
        iternaryLabel.textColor = HexColor("#000000")
        breakdownView.backgroundColor = HexColor("#FFFFFF")
        breakDownLabel.textColor = HexColor("#000000")
        bagInfoView.backgroundColor = HexColor("#FFFFFF")
        bagInfoLabel.textColor = HexColor("#000000")
        setUpFareRules()
    }
    
    @IBAction func bagInfoButtonAction(_ sender: Any) {
        bagInfoView.layer.borderColor = UIColor.clear.cgColor
        fareRulesView.layer.borderColor = HexColor("#D4D4D4").cgColor
        iternaryView.layer.borderColor = HexColor("#D4D4D4").cgColor
        breakdownView.layer.borderColor = HexColor("#D4D4D4").cgColor
        bagInfoView.backgroundColor = HexColor("3C627A")
        bagInfoLabel.textColor = HexColor("#FFFFFF")
        fareRulesView.backgroundColor = HexColor("#FFFFFF")
        farerulesLabel.textColor = HexColor("#000000")
        breakdownView.backgroundColor = HexColor("#FFFFFF")
        breakDownLabel.textColor = HexColor("#000000")
        iternaryView.backgroundColor = HexColor("#FFFFFF")
        iternaryLabel.textColor = HexColor("#000000")
        setUpBaggageInfo()
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
