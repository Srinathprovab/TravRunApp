//
//  FlightViewController.swift
//  Travrun
//
//  Created by MA1882 on 17/11/23.
//

import UIKit

class FlightViewController: BaseTableVC {
    
    
    @IBOutlet weak var holderVIew: UIView!
    @IBOutlet weak var gobackLabel: UILabel!
    @IBOutlet weak var roundTripLabel: UILabel!
    @IBOutlet weak var multicityLabel: UILabel!
    @IBOutlet weak var onewayBabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var ButttonBgView: UIView!
    @IBOutlet weak var multicityView: UIView!
    @IBOutlet weak var roundTripView: UIView!
    @IBOutlet weak var onewayView: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var flightView: UIView!
    
    var isAdvanceSearch = true
    var cellIndex = Int()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var viewModel : FlightListViewModel?
    var FlightListArray = [FlightSearchModel]()
    var tablerow = [TableRow]()
    var c1 = String()
    var c2 = String()
    var checkBoxArray = ["Return journey from another location"," Direct flights only"]
    var checkBool = true
    var selectArray = [String]()
    var selectArray1 = [String]()
    var moreoptionBool = true
    var calDepDate: String!
    var calRetDate: String!
    var fromdataArray = [[String:Any]]()
    var isfromVc = String()
    
    static var newInstance: FlightViewController? {
        let storyboard = UIStoryboard(name: Storyboard.FlightStoryBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightViewController
        return vc
    }
    
    var tableRow = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTv()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        //  frontView.isHidden = true
       
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("calreloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(fromSelectCityVC), name: NSNotification.Name("fromSelectCityVC"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(topcity(notification:)), name: Notification.Name("topcity"), object: nil)
        
        setupIntialUI()
        
    }
    
    func setupIntialUI(){
        
        if keyStr == "select"  {
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    setupOneWay()
                }else if journeyType == "circle"{
                    setupRoundTrip()
                }else {
//                    setupMulticity()
                }
            }
        } else {
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    setupOneWay()
                }else if journeyType == "circle"{
                    setupRoundTrip()
                }else {
//                    setupMulticity()
                }
            }
        }
    }
    
    
    func registerTv() {
        self.commonTableView.registerTVCells(["OneWayTableViewCell","FlightSearchButtonTableViewCell","EmptyTVCell"])
    }
    
    func setUpView() {
        holderVIew.layer.cornerRadius = 12
        gobackLabel.textColor = HexColor("#000000")
        onewayBabel.textColor = HexColor("#FFFFFF")
        bannerImage.image = UIImage(named: "onewayBanner")
        ButttonBgView.layer.cornerRadius = 6
        flightView.layer.cornerRadius = flightView.layer.frame.width / 2
        roundTripView.layer.cornerRadius = 4
        multicityView.layer.cornerRadius = 4
        onewayView.layer.cornerRadius = 4
        setUpTableView()
    }
    
    func setUpTableView() {
        tableRow.removeAll()
        tableRow.append(TableRow(key: "oneWay",cellType: .OneWayTableViewCell))
        tableRow.append(TableRow(cellType: .FlightSearchButtonTableViewCell))
        tableRow.append(TableRow(height: 26, bgColor: HexColor("#FFEBED"), cellType: .EmptyTVCell))
        
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    func setUpRoundTripTableView() {
        tableRow.removeAll()
        tableRow.append(TableRow(key: "roundTrip",cellType: .OneWayTableViewCell))
        tableRow.append(TableRow(cellType: .FlightSearchButtonTableViewCell))
        tableRow.append(TableRow(height: 26, bgColor: HexColor("#FFEBED"), cellType: .EmptyTVCell))
        
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    func setupRoundTrip(){
        defaults.set("circle", forKey:  UserDefaultsKeys.journeyType)
        roundTripView.backgroundColor = HexColor("3C627A")
        multicityView.backgroundColor = UIColor.clear
        onewayView.backgroundColor = UIColor.clear
        bannerImage.image = UIImage(named: "roundBanner")
        multicityLabel.textColor = HexColor("#000000")
        roundTripLabel.textColor = HexColor("#FFFFFF")
        onewayBabel.textColor = HexColor("#000000")
        setUpRoundTripTableView()
    }
    
    func setupOneWay() {
        defaults.set("oneway", forKey:  UserDefaultsKeys.journeyType)
        roundTripView.backgroundColor = UIColor.clear
        multicityView.backgroundColor = UIColor.clear
        onewayView.backgroundColor = HexColor("3C627A")
        bannerImage.image = UIImage(named: "onewayBanner")
        multicityLabel.textColor = HexColor("#000000")
        roundTripLabel.textColor = HexColor("#000000")
        onewayBabel.textColor = HexColor("#FFFFFF")
        setUpTableView()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func oneWayButtonAction(_ sender: Any) {
        setupOneWay()
    }
    
    @IBAction func roundTripButtonAction(_ sender: Any) {
        setupRoundTrip()
    }
    
    @IBAction func multiCityButtonAction(_ sender: Any) {
        multicityLabel.textColor = HexColor("FFFFFF")
        roundTripLabel.textColor = HexColor("#000000")
        onewayBabel.textColor = HexColor("#000000")
        roundTripView.backgroundColor = UIColor.clear
        multicityView.backgroundColor = HexColor("3C627A")
        onewayView.backgroundColor = UIColor.clear
        bannerImage.image = UIImage(named: "multiBanner")
    }
    
    
    override func didTapOnReturnToOnewayBtnAction(cell: OneWayTableViewCell) {
        print("didTapOnReturnToOnewayBtnAction")
        setupOneWay()
    }
    
    override func didTapOnAddReturnFlight(cell: OneWayTableViewCell) {
        setupRoundTrip()
        gotoCalenderVC(key: "ret", titleStr: "Ruturn Date")
    }
    
    override func didTapOnDepartureBtnAction(cell: OneWayTableViewCell) {
        gotoCalenderVC(key: "dep", titleStr: "Departure Date")
    }
    
    override func didTapOnReturnBtnAction(cell: OneWayTableViewCell) {
        gotoCalenderVC(key: "ret", titleStr: "Ruturn Date")
    }
    
    override func didTapOnAdvanedSearchOptions(cell: OneWayTableViewCell) {
        self.isAdvanceSearch.toggle()
        if isAdvanceSearch {
            cell.advancedSearchLabel.text = "Advanced search options"
            cell.advancedSearchLabel.textColor = HexColor("#191919")
            cell.advancedUnderlineLabel.backgroundColor = HexColor("#191919")
            cell.bottomView.isHidden = true
            commonTableView.reloadData()
        } else {
            cell.bottomView.isHidden = false
            cell.advancedSearchLabel.textColor = HexColor("#EE1935")
            cell.advancedSearchLabel.text = "-Advanced search options"
            cell.advancedUnderlineLabel.backgroundColor = HexColor("#EE1935")
            cell.isAdvanceSearh = false
            commonTableView.reloadData()
        }
    }
    
    override func didTapOnflightSearchBtnAction(cell: FlightSearchButtonTableViewCell) {
        print("didTapOnflightSearchBtnAction")
        payload.removeAll()
        loderBool = true
    
        let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        
            if journeyType == "oneway" {
                payload["trip_type"] = "oneway"
                payload["adult"] = "1"
                payload["child"] = "0"
                payload["infant"] = "0"
                payload["v_class"] = "Economy"
                payload["sector_type"] = "international"
                payload["from"] = "Bangalore,India,Bengaluru International Airport(BLR)"
                payload["from_loc_id"] = "801"
                payload["to"] = "Delhi,India,Indira Gandhi International Airport(DEL)"
                payload["to_loc_id"] = "1709"
                payload["depature"] = "31-01-2023"
                payload["return"] = "1709"
                payload["out_jrn"] = "All Times"
                payload["ret_jrn"] = "All Times"
                payload["carrier"] = ""
                payload["psscarrier"] = "ALL"
                payload["search_flight"] = "Search"
                payload["user_id"] = "2738"
                payload["currency"] = "KWD"
                
                if directFlightBool == false {
                    payload["direct_flight"] = "on"
                }
                gotoSearchFlightResultVC(payload33: payload)
//                
//                if defaults.string(forKey:UserDefaultsKeys.fromCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.fromCity) == nil{
//                    showToast(message: "Please Select From City")
//                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.toCity) == nil{
//                    showToast(message: "Please Select To City")
//                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
//                    showToast(message: "Please Select Different Citys")
//                }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.calDepDate) == nil{
//                    showToast(message: "Please Select Departure Date")
//                }
//                else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
//                    showToast(message: "Add Traveller")
//                }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
//                    showToast(message: "Add Class")
//                }else if checkDepartureAndReturnDates1(payload, p1: "depature") == false {
//                    showToast(message: "Invalid Date")
//                }else{
//                    gotoSearchFlightResultVC(payload33: payload)
//                }
                
            } else {
                
                payload["trip_type"] = "circle"
                payload["adult"] = "1"
                payload["child"] = "0"
                payload["infant"] = "0"
                payload["v_class"] = "Economy"
                payload["sector_type"] = "international"
                
                payload["from"] = "Bangalore,India,Bengaluru International Airport(BLR)"
                payload["from_loc_id"] = "801"
                payload["to"] = "Delhi,India,Indira Gandhi International Airport(DEL)"
                payload["to_loc_id"] = "1709"
                
                payload["depature"] = "31-01-2024"
                payload["return"] = "2-02-2024"
                payload["out_jrn"] = "All Times"
                payload["ret_jrn"] = "All Times"
                payload["carrier"] = ""
                payload["psscarrier"] = "ALL"
                payload["search_flight"] = "Search"
                payload["user_id"] = "2738"
                payload["currency"] = "KWD"
                
                if directFlightBool == false {
                    payload["direct_flight"] = "on"
                }
                
                gotoSearchFlightResultVC(payload33: payload)
                
//                if defaults.string(forKey:UserDefaultsKeys.fromCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.fromCity) == nil{
//                    showToast(message: "Please Select From City")
//                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.toCity) == nil{
//                    showToast(message: "Please Select To City")
//                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
//                    showToast(message: "Please Select Different Citys")
//                }else if defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == nil{
//                    showToast(message: "Please Select Departure Date")
//                }else if defaults.string(forKey:UserDefaultsKeys.rcalRetDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.rcalRetDate) == nil{
//                    showToast(message: "Please Select Return Date")
//                }else if defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == defaults.string(forKey:UserDefaultsKeys.rcalRetDate) {
//                    showToast(message: "Please Select Different Dates")
//                }
//                else if defaults.string(forKey:UserDefaultsKeys.rtravellerDetails) == nil {
//                    showToast(message: "Add Traveller")
//                }else if defaults.string(forKey:UserDefaultsKeys.rselectClass) == nil {
//                    showToast(message: "Add Class")
//                }else if defaults.string(forKey:UserDefaultsKeys.fromCity) == defaults.string(forKey:UserDefaultsKeys.toCity) {
//                    showToast(message: "Please Select Different Citys")
//                }else if checkDepartureAndReturnDates(payload, p1: "depature", p2: "return") == false {
//                    showToast(message: "Invalid Date")
//                }else{
//                    gotoSearchFlightResultVC(payload33: payload)
//                }
            }
        }
        
    }

extension FlightViewController {
    func gotoSearchFlightResultVC(payload33:[String:Any]) {
        guard let vc = SearchResultPageViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        defaults.set(false, forKey: "flightfilteronce")
        vc.isFromVc = "searchvc"
        callapibool = true
        vc.payload = payload33
        self.present(vc, animated: true)
    }
    
    func gotoCalenderVC(key:String,titleStr:String) {
        dateSelectKey = key
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = titleStr
        callapibool = true
        self.present(vc, animated: false)
    }
}


extension FlightViewController {
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func reloadTV() {
        commonTableView.reloadData()
    }
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    @objc func fromSelectCityVC() {
        keyStr = "select"
    }
    
    
}

extension FlightViewController {
    
    
    //MARK: - topcity Search
    @objc func topcity(notification: Notification) {
        payload.removeAll()
        self.tabBarController?.tabBar.isHidden = true
        loderBool = true
        defaults.set("Flights", forKey: UserDefaultsKeys.dashboardTapSelected)
        if let userinfo = notification.userInfo {
            
            payload["trip_type"] = "circle"
            payload["adult"] = "1"
            payload["child"] = "0"
            payload["infant"] = "0"
            payload["v_class"] = "Economy"
            payload["sector_type"] = "international"
            
            payload["from"] = "Bangalore,India,Bengaluru International Airport(BLR)"
            payload["from_loc_id"] = "801"
            payload["to"] = "Delhi,India,Indira Gandhi International Airport(DEL)"
            payload["to_loc_id"] = "1709"
            
            payload["depature"] = "29-12-2023"
            payload["return"] = "30-12-2023"
            payload["out_jrn"] = "All Times"
            payload["ret_jrn"] = "All Times"
            payload["carrier"] = ""
            payload["psscarrier"] = "ALL"
            payload["search_flight"] = "Search"
            payload["user_id"] = "2738"
            payload["currency"] = "KWD"
            
            
//            defaults.set((userinfo["trip_type"] as? String) ?? "", forKey: UserDefaultsKeys.journeyType)
//            
//            defaults.set((userinfo["from_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.fromcityname)
//            defaults.set((userinfo["to_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.tocityname)
//            defaults.set((userinfo["from_city_loc"] as? String) ?? "" , forKey: UserDefaultsKeys.fromairport)
//            defaults.set((userinfo["to_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.toairport)
//            defaults.set((userinfo["fromFlight"] as? String) ?? "" , forKey: UserDefaultsKeys.fromCity)
//            defaults.set((userinfo["toFlight"] as? String) ?? "" , forKey: UserDefaultsKeys.toCity)
//            
//            
//            if (userinfo["trip_type"] as? String) == "oneway" {
//                defaults.set((userinfo["travel_date"] as? String) ?? "" , forKey: UserDefaultsKeys.calDepDate)
//                defaults.set((userinfo["return_date"] as? String) ?? "" , forKey: UserDefaultsKeys.calRetDate)
//            }else {
//                defaults.set((userinfo["travel_date"] as? String) ?? "" , forKey: UserDefaultsKeys.rcalDepDate)
//                defaults.set((userinfo["return_date"] as? String) ?? "" , forKey: UserDefaultsKeys.rcalRetDate)
//            }
//            
//            
//            
            gotoSearchFlightResultVC(payload33: payload)
        }
        
    }
}

