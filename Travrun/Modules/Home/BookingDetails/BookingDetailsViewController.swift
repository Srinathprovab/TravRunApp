//
//  BookingDetailsViewController.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23.
//

import UIKit

class BookingDetailsViewController: BaseTableVC {
   
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var backButtonView: UIView!
    var tablerow = [TableRow]()
    
    static var newInstance: BookingDetailsViewController? {
        let storyboard = UIStoryboard(name: Storyboard.BookingDetails.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingDetailsViewController
        return vc
    }
    
    var countryCode = String()
    var nationalityCode = String()
    
    var showMoreBool = true
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var checkBool = false
    var accesskeytp = String()
    var accesskey = String()
    var bookingsource = String()
    var tmpFlightPreBookingId = String()
    var activepaymentoptions = String()
    var totalPrice = Double()
    var appreference = String()
    var totalPrice1 = String()
    let seconds = 0.1
    
    
//    var moreDeatilsViewModel:AboutusViewModel?
//    var mbviewmodel:MBViewModel?
//    var viewmodel1:MobileSecureBookingViewModel?
//    var viewmodel:AllCountryCodeListViewModel?
//    var travellerViewModel:TravellerViewModel?
//    var profileDetilsVM:ProfileDetailsViewModel?
//    var deleteTreavelerVM : TravellerDeleteViewModel?
//    
    var billingCountryName = String()
    
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    var mbRefundable = String()
    var timer: Timer?
    var totalTime = 1
    
    var positionsCount = 0
    var passengertypeArray = [String]()
    var searchTextArray = [String]()
    var totalAmountforBooking = String()
    var grand_total_Price = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        commonTableView.registerTVCells(["BookingDetailsCardTVCellTableViewCell",
                                         "EmptyTVCell", "RegisterSelectionLoginTableViewCell", "GuestRegisterTableViewCell", "RegisterNowTableViewCell", "LoginDetailsTableViewCell", "AddAdultTableViewCell", "FareSummaryTableViewCell", "AcceptTermsAndConditionTVCell"])
        setupFilterTVCells()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        addObserver()
        
//        travelerArray.removeAll()
//        searchTextArray.removeAll()
        
        
        
//        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
//            if journeyType == "oneway" {
//                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
//                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
//                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
//                
//            }else if journeyType == "circle"{
//                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
//                childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
//                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
//            }else {
//                
////                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
////                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
////                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
//            }
//            
//            tablerow.removeAll()
//            checkOptionCountArray.removeAll()
//            
//            
//            if callapibool == true {
//                holderView.isHidden = true
//                callAllAPIS()
//            }
//        }
        
//    }
    
    
//    func callAllAPIS() {
//        MBfd?.removeAll()
////        TimerManager.shared.sessionStop()
//        
//        DispatchQueue.main.async {
//            self.callMobilePreProcessingBookingAPI()
//        }
//    }
//    
    //MARK: -call Mobile Pre Processing Booking API
//    func callMobilePreProcessingBookingAPI() {
//        
//        payload.removeAll()
//        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
//        payload["selectedResult"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
//        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsourcekey)
//        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? 0
//        // payload["traceId"] = defaults.string(forKey: UserDefaultsKeys.traceId) ?? 0
//        mbviewmodel?.CALLPREPROCESSINGBOOKINGAPI(dictParam: payload)
//    }
    
    
    func setupFilterTVCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .BookingDetailsCardTVCellTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            tablerow.append(TableRow(cellType: .GuestRegisterTableViewCell))
        } else {
            tablerow.append(TableRow(height: 0, cellType:.EmptyTVCell))
        }
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .AddAdultTableViewCell))
        tablerow.append(TableRow(cellType: .FareSummaryTableViewCell))
        tablerow.append(TableRow(height: 100, bgColor: .white, cellType: .AcceptTermsAndConditionTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupRegisterNowTvCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        tablerow.append(TableRow(cellType: .BookingDetailsCardTVCellTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            tablerow.append(TableRow(key: "register",cellType: .RegisterNowTableViewCell))
        } else {
            tablerow.append(TableRow(height: 0, cellType:.EmptyTVCell))
        }
        tablerow.append(TableRow(height: 0, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .AddAdultTableViewCell))
        tablerow.append(TableRow(cellType: .FareSummaryTableViewCell))
        tablerow.append(TableRow(height: 100, bgColor: .white, cellType: .AcceptTermsAndConditionTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupLoginTvCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        tablerow.append(TableRow(cellType: .BookingDetailsCardTVCellTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            tablerow.append(TableRow(cellType: .LoginDetailsTableViewCell))
        } else {
            tablerow.append(TableRow(height: 0, cellType:.EmptyTVCell))
        }
        tablerow.append(TableRow(height: 0, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .AddAdultTableViewCell))
        tablerow.append(TableRow(cellType: .FareSummaryTableViewCell))
        tablerow.append(TableRow(height: 100, bgColor: .white, cellType: .AcceptTermsAndConditionTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    override func didTapOnguestButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radioUnselect")
        cell.loginRadioImage.image = UIImage(named: "radioUnselect")
        cell.guestRadioImage.image = UIImage(named: "radioSelect")
        setupFilterTVCells()
    }
    override func registerButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radioSelect")
        cell.loginRadioImage.image = UIImage(named: "radioUnselect")
        cell.guestRadioImage.image = UIImage(named: "radioUnselect")
        setupRegisterNowTvCells()
    }
    override func loginButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radioUnselect")
        cell.loginRadioImage.image = UIImage(named: "radioSelect")
        cell.guestRadioImage.image = UIImage(named: "radioUnselect")
        setupLoginTvCells()
    }
}



extension BookingDetailsViewController {
    
//    func addObserver() {
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
////        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
////        NotificationCenter.default.addObserver(self, selector: #selector(reloadAfterLogin), name: NSNotification.Name("reloadAfterLogin"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(passportexpiry), name: NSNotification.Name("passportexpiry"), object: nil)
//        
//    }
//    
    
//    @objc func passportexpiry(notify:NSNotification) {
//        passportExpireDateBool = false
//        showToast(message: (notify.object as? String) ?? "")
//    }
//    
//    
//    @objc func reloadTV() {
//        DispatchQueue.main.async {[self] in
//            commonTableView.reloadData()
//        }
//    }
//    
//    
    
//    @objc func reload() {
//        DispatchQueue.main.async {[self] in
//            callAllAPIS()
//        }
//    }
    
    //MARK: - resultnil
//    @objc func resultnil() {
//        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.key = "noresult"
//        self.present(vc, animated: true)
//    }
//    
//    
//    //MARK: - nointernet
//    @objc func nointernet() {
//        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.key = "nointernet"
//        self.present(vc, animated: true)
//    }
//    
    //MARK: - reloadAfterLogin
//    @objc func reloadAfterLogin() {
//        callProfileDetailsAPI()
//    }
//    
    
    //MARK: - updateTimer
//    func updateTimer() {
//        let totalTime = TimerManager.shared.totalTime
//        let minutes =  totalTime / 60
//        let seconds = totalTime % 60
//        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
//        
//        setuplabels(lbl: sessonlbl, text: "Your Session Expires In : \(formattedTime)", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
//    }

}

