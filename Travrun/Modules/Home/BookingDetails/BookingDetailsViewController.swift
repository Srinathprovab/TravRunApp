//
//  BookingDetailsViewController.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23.
//

import UIKit

class BookingDetailsViewController: BaseTableVC, RegisterViewModelProtocal, ProfileDetailsViewModelDelegate, FDViewModelDelegate {
 
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var backButtonView: UIView!
    var tablerow = [TableRow]()
    var viewmodel1:ProfileDetailsViewModel?
    var viewmodel2 : FDViewModel?
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
    var isVcFrom = String()
    let seconds = 0.1
    var isOpen = true
    
    
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
    var regViewModel: RegisterViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewmodel1 = ProfileDetailsViewModel(self)
        regViewModel = RegisterViewModel(self)
        viewmodel2 = FDViewModel(self)
        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        commonTableView.registerTVCells(["BookingDetailsCardTVCellTableViewCell",
                                         "EmptyTVCell", "RegisterSelectionLoginTableViewCell", "GuestRegisterTableViewCell", "RegisterNowTableViewCell", "LoginDetailsTableViewCell", "AddAdultTableViewCell", "FareSummaryTableViewCell", "AcceptTermsAndConditionTVCell", "HeaderTableViewCell", "AddressTableViewCell"])
        setupFilterTVCells()
        callProfileDetailsAPI()
        callGetFlightDetailsAPI()
    }
    
    func setupFilterTVCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .BookingDetailsCardTVCellTableViewCell))
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
            tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            tablerow.append(TableRow(cellType: .GuestRegisterTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
        } else {
            tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        }
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .AddAdultTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(title: "AddAdult", cellType: .HeaderTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .AddressTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .FareSummaryTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(height: 100, bgColor: .white, cellType: .AcceptTermsAndConditionTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupLoginTvCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        tablerow.append(TableRow(cellType: .BookingDetailsCardTVCellTableViewCell))
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
            tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            tablerow.append(TableRow(key: "register",cellType: .RegisterNowTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
        } else {
            tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        }
        tablerow.append(TableRow(height: 0, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .AddAdultTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(title: "AddAdult", cellType: .HeaderTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .AddressTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .FareSummaryTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(height: 100, bgColor: .white, cellType: .AcceptTermsAndConditionTVCell))
       
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupRegisterNowTvCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        tablerow.append(TableRow(cellType: .BookingDetailsCardTVCellTableViewCell))
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
            tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            tablerow.append(TableRow(cellType: .LoginDetailsTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
        } else {
            tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        }
        tablerow.append(TableRow(height: 0, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .AddAdultTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(title: "AddAdult", cellType: .HeaderTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .AddressTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .FareSummaryTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
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
    
    override func loginNowButtonAction(cell: RegisterNowTableViewCell, email: String, pass: String) {
        print("loginNowButtonAction")
        callLoginAPI(email: email, pass: pass)
    }
    
    override func RegisterNowButtonAction(cell: LoginDetailsTableViewCell, email: String, pass: String, phone: String) {
        callRegisterAPI(email: email, pass: pass, mobile: phone)
    }
    
    override func didTaponSwitchButton(cell: AddAdultTableViewCell) {
        cell.frequentView.isHidden = false
    }
    
    override func travListButtonAction() {}
}
// ligin Api Calls
extension BookingDetailsViewController {
    func callLoginAPI(email: String, pass: String) {
        payload["username"] = email
        payload["password"] = pass
        regViewModel?.CallLoginAPI(dictParam: payload)
        callProfileDetailsAPI()
    }
    
    func callRegisterAPI(email: String, pass: String, mobile: String) {
        payload["email"] = email
        payload["password"] = pass
        payload["phone"] = mobile
        regViewModel?.CallRegisterAPI(dictParam: payload)
        callProfileDetailsAPI()
    }
}

extension BookingDetailsViewController {
    func RegisterDetails(response: RegisterModel) {
        print(response)
        if response.status == false {
            showToast(message: response.msg ?? "")
        } else {
            showToast(message: "Register Sucess")
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set(response.data?.user_id, forKey: UserDefaultsKeys.userid)
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                if isVcFrom == "BookingDetailsViewController" {
                    NotificationCenter.default.post(name: NSNotification.Name("reloadAfterLogin"), object: nil)
                    self.dismiss(animated: true)
                }else {
//                    commonTableView.reloadData()
                    setupRegisterNowTvCells()
                }
            }
        }
    }
    
        
        func loginDetails(response: LoginModel) {
            print(response)
            if response.status == false {
                showToast(message: response.data ?? "")
            }else {
                
                defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
                defaults.set(response.user_id, forKey: UserDefaultsKeys.userid)
            
                showToast(message: response.data ?? "")
                let seconds = 2.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                    
                    if isVcFrom == "BookingDetailsViewController" || isVcFrom == "SideMenuViewController"{
                        NotificationCenter.default.post(name: NSNotification.Name("reloadAfterLogin"), object: nil)
                        self.dismiss(animated: true)
                    }else {
//                        tablerow.removeAll()
                        setupLoginTvCells()
                    }
                }
            }
        }
}

extension BookingDetailsViewController {
    //MARK: - call Profile Details API
    func callProfileDetailsAPI() {
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        viewmodel1?.CallGetProileDetails_API(dictParam: payload)
    }


    func getProfileDetails(response: ProfileDetailsModel) {
        print(" =====   getProfileDetails ====== \(response)")
        pdetails = response.data
        
        defaults.set(response.data?.email, forKey: UserDefaultsKeys.useremail)
        defaults.set(response.data?.phone, forKey: UserDefaultsKeys.usermobile)
        
//        DispatchQueue.main.async {[self] in
//            setupMenuTVCells()
//        }
    }
    
    func updateProfileDetails(response: ProfileDetailsModel) {}
    
    
 // call preprossenign API
    
    
    
}
extension BookingDetailsViewController {
    func callGetFlightDetailsAPI() {
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResultindex"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsourcekey) ?? "0"
        viewmodel2?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
    }
    
    func flightDetails(response: FDModel) {
        holderView.isHidden = false
        fd = response.flightDetails ?? []
        
        jd = response.journeySummary ?? []
        fareRulehtml = response.fareRulehtml ?? []
        totalprice = "\(response.priceDetails?.api_currency ?? "") : \(response.priceDetails?.grand_total ?? "")"
        grandTotal = totalprice
        farerulerefkey = response.fare_rule_ref_key ?? ""
        farerulesrefcontent = response.farerulesref_content ?? ""
//        jSummary = response.journeySummary ?? []
        
        fareCurrencyType = String(response.priceDetails?.api_currency ?? "")
        Adults_Base_Price = String(response.priceDetails?.adultsBasePrice ?? "0")
        Adults_Tax_Price = String(response.priceDetails?.adultsTaxPrice ?? "0")
        Childs_Base_Price = String(response.priceDetails?.childBasePrice ?? "0")
        Childs_Tax_Price = String(response.priceDetails?.childTaxPrice ?? "0")
        Infants_Base_Price = String(response.priceDetails?.infantBasePrice ?? "0")
        Infants_Tax_Price = String(response.priceDetails?.infantTaxPrice ?? "0")
        AdultsTotalPrice = String(response.priceDetails?.adultsTotalPrice ?? "0")
        ChildTotalPrice = String(response.priceDetails?.childTotalPrice ?? "0")
        InfantTotalPrice = String(response.priceDetails?.infantTotalPrice ?? "0")
        sub_total_adult = String(response.priceDetails?.sub_total_adult ?? "0")
        sub_total_child = String(response.priceDetails?.sub_total_child ?? "0")
        sub_total_infant = String(response.priceDetails?.sub_total_infant ?? "0")
        
        DispatchQueue.main.async {[self] in
            // callFareRulesAPI()
        }
        
        
        DispatchQueue.main.async {[self] in
            //            setupTVCells()
        }
        
        //        self.view.backgroundColor = .black.withAlphaComponent(0.5)
//        DispatchQueue.main.async {[self] in
//            setupItineraryOneWayTVCell()
//        }
    }
    
}
