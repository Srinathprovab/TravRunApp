//
//  TravellerDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
import CoreData
import FreshchatSDK
import MFSDK



class BookingDetailsVC: BaseTableVC, AllCountryCodeListViewModelDelegate, MBViewModelDelegate, MobileSecureBookingViewModelDelegate, AboutusViewModelDelegate, ProfileDetailsViewModelDelegate, TravellerDeleteViewModelDelegate, TimerManagerDelegate, RegisterViewModelProtocal {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var BookNowBtnView: UIView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var sessionTimerView: UIView!
    @IBOutlet weak var sessonlbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var chatBtnView: UIView!
    @IBOutlet weak var dropupimg: UIImageView!
    
    var lastContentOffset: CGFloat = 0
    static var newInstance: BookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.BookingDetails.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingDetailsVC
        return vc
    }
    var tablerow = [TableRow]()
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
    
    
    var moreDeatilsViewModel:AboutusViewModel?
    var mbviewmodel:MBViewModel?
    var viewmodel1: MobileSecureBookingViewModel?
    var viewmodel:AllCountryCodeListViewModel?
    var travellerViewModel:TravellerViewModel?
    var profileDetilsVM:ProfileDetailsViewModel?
    var deleteTreavelerVM : TravellerDeleteViewModel?
    var regViewModel: RegisterViewModel?
    
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
    
    
    //MARK: -  LOADING FUNCTIONS
    
    
    override func viewWillDisappear(_ animated: Bool) {
        BASE_URL = BASE_URL1
        loderBool = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        addObserver()
        chatBtnView.isHidden = true
        hiddenView.isHidden = true
        travelerArray.removeAll()
        searchTextArray.removeAll()
        
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
            }
        }
        
        
        tablerow.removeAll()
        checkOptionCountArray.removeAll()
        
        
        if callapibool == true {
            holderView.isHidden = true
            callAllAPIS()
        }
        
        
    }
    
    
    func timerDidFinish() {
        gotoPopupScreen()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        // setupTV()
        self.view.backgroundColor = .WhiteColor
        TimerManager.shared.delegate = self
        regViewModel = RegisterViewModel(self)
        viewmodel = AllCountryCodeListViewModel(self)
        mbviewmodel = MBViewModel(self)
        viewmodel1 = MobileSecureBookingViewModel(self)
        moreDeatilsViewModel = AboutusViewModel(self)
        profileDetilsVM = ProfileDetailsViewModel(self)
        deleteTreavelerVM = TravellerDeleteViewModel(self)
        
        
    }
    
    
    func setupUI() {
        
        BookNowBtnView.backgroundColor = .AppBtnColor
        BookNowBtnView.layer.cornerRadius = 6
        setuplabels(lbl: bookNowlbl, text: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):", textcolor: .WhiteColor, font: .InterBold(size: 18), align: .left)
        setuplabels(lbl: kwdlbl, text: "Continue to Payment", textcolor: .WhiteColor, font: .InterBold(size: 18), align: .right)
        bookNowBtn.setTitle("", for: .normal)
        sessionTimerView.isHidden = true
        sessionTimerView.backgroundColor = .WhiteColor
        sessionTimerView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 5)
        setuplabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .InterRegular(size: 16), align: .left)
        dropupimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        commonTableView.registerTVCells(["TDetailsLoginTVCell",
                                         "EmptyTVCell",
                                         "ContactInformationTVCell",
                                         "TravelInsuranceTVCell",
                                         "PriceSummaryTVCell",
                                         "SearchFlightResultTVCell",
                                         "ViewFlightDetailsBtnTVCell",
                                         "UsePromoCodesTVCell",
                                         "SpecialRequestTVCell",
                                         "AddDeatilsOfTravellerTVCell",
                                         "AcceptTermsAndConditionTVCell",
                                         "TotalNoofTravellerTVCell",
                                         "BookFlightDetailsTVCell", "RegisterNowTableViewCell", "EmptyTVCell", "LoginDetailsTableViewCell", "GuestRegisterTableViewCell", "RegisterSelectionLoginTableViewCell"])
    }
    
    
    
    func setupTV() {
        sessionTimerView.isHidden = false
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:self.mbRefundable,
                                 subTitle: "",
                                 moreData: mbSummery,
                                 cellType:.BookFlightDetailsTVCell))
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
            tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            if mbviewmodel?.section == .guestLogin {
                tablerow.append(TableRow(cellType: .GuestRegisterTableViewCell))
                tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            } else if mbviewmodel?.section == .register {
                tablerow.append(TableRow(cellType: .LoginDetailsTableViewCell))
                tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            } else if mbviewmodel?.section == .login {
                tablerow.append(TableRow(key: "register",cellType: .RegisterNowTableViewCell))
                tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            }
        }
        
        passengertypeArray.removeAll()
        tablerow.append(TableRow(height:20, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Passanger Details",
                                 subTitle: defaults.string(forKey: UserDefaultsKeys.totalTravellerCount),
                                 cellType:.TotalNoofTravellerTVCell))
        
        for i in 1...adultsCount {
            positionsCount += 1
            passengertypeArray.append("Adult")
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult", characterLimit: positionsCount, cellType: .AddDeatilsOfTravellerTVCell)
            searchTextArray.append("Adult \(i)")
            tablerow.append(travellerCell)
            
        }
        
        
        if childCount != 0 {
            for i in 1...childCount {
                positionsCount += 1
                passengertypeArray.append("Child")
                tablerow.append(TableRow(title:"Child \(i)",key:"child",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
                searchTextArray.append("Child \(i)")
            }
        }
        
        if infantsCount != 0 {
            for i in 1...infantsCount {
                positionsCount += 1
                passengertypeArray.append("Infant")
                tablerow.append(TableRow(title:"Infant \(i)",key:"infant",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
                searchTextArray.append("Infant \(i)")
            }
        }
        
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        tablerow.append(TableRow(cellType:.UsePromoCodesTVCell))
        tablerow.append(TableRow(price:grand_total_Price,cellType:.PriceSummaryTVCell))
        tablerow.append(TableRow(key:"flight",
                                 cellType:.SpecialRequestTVCell))
        tablerow.append(TableRow(height:50, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    
    
    func gotoPopupScreen() {
//        guard let vc = PopupVC.newInstance.self else {return}
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnLoginBtn
    
    override func didTapOnLoginBtn(cell:TDetailsLoginTVCell){
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.isVcFrom = "BookingDetailsVC"
        self.present(vc, animated: true)
        
    }
    
    //MARK: - didTapOnCountryCodeBtn
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        self.nationalityCode = cell.isoCountryCode
        paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    //MARK: - editingTextField
    override func editingTextField(tf:UITextField){
        
        if tf.tag == 1 {
            payemail = tf.text ?? ""
        }else {
            paymobile = tf.text ?? ""
        }
    }
    
    
    
    
    
    //MARK: - didTapOnInsureSkipButton TravelInsuranceTVCell
    override func didTapOnInsureSkipButton(cell: TravelInsuranceTVCell) {
    }
    
    
    
    //MARK: - didTapOnPABtn TravelInsuranceTVCell
    override func didTapOnPABtn(cell: TravelInsuranceTVCell) {
    }
    
    
    
    //MARK: - didTapOnTCBtn TravelInsuranceTVCell
    override func didTapOnTCBtn(cell: TravelInsuranceTVCell) {
        print("didTapOnTCBtn")
    }
    
    //MARK: - didTapOnTCBtn TravelInsuranceTVCell =====
    override func didTapOnviewFlifgtDetailsBtn(cell: BookFlightDetailsTVCell) {
        guard let vc = FlightDetailsViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    //MARK: - didTapOnTDBtn TravelInsuranceTVCell
    override func didTapOnTDBtn(cell: TravelInsuranceTVCell) {
        print("didTapOnTDBtn")
    }
    
    
    
    //MARK: - didTapOnTC1Btn TravelInsuranceTVCell
    override func didTapOnTC1Btn(cell: TravelInsuranceTVCell) {
        print("didTapOnTC1Btn")
    }
    
    
    //MARK: - didTapOnTD1Btn TravelInsuranceTVCell
    override func didTapOnTD1Btn(cell: TravelInsuranceTVCell) {
        print("didTapOnTD1Btn")
    }
    
    //MARK: - didTapOnShowMoreBtn TravelInsuranceTVCell
    override func didTapOnShowMoreBtn(cell: TravelInsuranceTVCell) {
        if showMoreBool == true {
            cell.showMorelbl.text = "- Show Less"
            cell.optionView.isHidden = false
            cell.optionViewHeight.constant = 100
            showMoreBool = false
        }else {
            cell.showMorelbl.text = "+ Show More"
            cell.optionView.isHidden = true
            cell.optionViewHeight.constant = 0
            showMoreBool = true
        }
        
    }
    
    
    //MARK: - didTapOnYesInsureBtn TravelInsuranceTVCell
    override func didTapOnYesInsureBtn(cell: TravelInsuranceTVCell) {
        cell.radioImg1.image = UIImage(named: "radioSelected")
        cell.radioImg2.image = UIImage(named: "radioUnselected")
    }
    
    
    //MARK: - didTapOnNoInsureBtn TravelInsuranceTVCell
    override func didTapOnNoInsureBtn(cell: TravelInsuranceTVCell) {
        cell.radioImg1.image = UIImage(named: "radioUnselected")
        cell.radioImg2.image = UIImage(named: "radioSelected")
    }
    
    
    //MARK: - didTapOnRemoveTravelInsuranceBtn
    override func didTapOnRemoveTravelInsuranceBtn(cell: PriceSummaryTVCell) {
        print("didTapOnRemoveTravelInsuranceBtn")
    }
    
    
    override func didTapOnguestButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radioUnselect")
        cell.loginRadioImage.image = UIImage(named: "radioUnselect")
        cell.guestRadioImage.image = UIImage(named: "radioSelect")
        mbviewmodel?.section = .guestLogin
        setupTV()
//        commonTableView.reloadData()
        
    }
    override func registerButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radioSelect")
        cell.loginRadioImage.image = UIImage(named: "radioUnselect")
        cell.guestRadioImage.image = UIImage(named: "radioUnselect")
        mbviewmodel?.section = .register
        setupTV()
//        commonTableView.reloadData()
    }
    override func loginButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radioUnselect")
        cell.loginRadioImage.image = UIImage(named: "radioSelect")
        cell.guestRadioImage.image = UIImage(named: "radioUnselect")
        mbviewmodel?.section = .login
        setupTV()
//        commonTableView.reloadData()
    }
    
    override func loginNowButtonAction(cell: RegisterNowTableViewCell, email: String, pass: String) {
        print("loginNowButtonAction")
        callLoginAPI(email: email, pass: pass)
    }
    
    override func RegisterNowButtonAction(cell: LoginDetailsTableViewCell, email: String, pass: String, phone: String) {
        callRegisterAPI(email: email, pass: pass, mobile: phone)
    }
    
    
    
    
    //MARK: - gotoAddTravellerOrGuestVC
    func gotoAddTravellerOrGuestVC(str:String,key1:String,passType:String,id1:String) {
//        defaults.set(str, forKey: UserDefaultsKeys.travellerTitle)
//        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
//        vc.modalPresentationStyle = .fullScreen
//        vc.key = key1
//        vc.passengerType = passType
//        vc.id = id1
//        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnEditTraveller
//    override func didTapOnEditTraveller(cell: AddAdultsOrGuestTVCell){
//        gotoAddTravellerOrGuestVC(str: "", key1: "edit", passType: "", id1: cell.travellerId)
//    }
    
    
    //MARK: - did Tap On delete Traveller BtnAction
    override func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell){
        commonTableView.reloadData()
    }
    
    func callDeleteOriginAPI(origin1:String) {
        payload.removeAll()
        payload["origin"] = origin1
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        deleteTreavelerVM?.CALL_DELETE_TRAVELLER_DETAILS(dictParam: payload)
    }
    
    
    
    
    //MARK: - didTapOnViewFlightsDetailsBtn
    override func didTapOnViewFlightDetailsButton(cell: ViewFlightDetailsBtnTVCell) {
        guard let vc = FlightDetailsViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnFlightsDetails
//    override func didTapOnFlightsDetails(cell: SearchFlightResultTVCell){
//        guard let vc = FlightDetailsViewController.newInstance.self else {return}
//        vc.isVCFrom = "BookingDetailsVC"
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true)
//    }
    
    
    //MARK: - didTapOnDropDownBtn
    override func didTapOnDropDownBtn(cell: ContactInformationTVCell) {
        self.nationalityCode = cell.isoCountryCode
        paymobilecountrycode = cell.countrycodeTF.text ?? ""
    }
    
    
    
    
    //MARK: - did Tap On T&C Action
    
    //    override func didTapOnTAndCAction(cell: AcceptTermsAndConditionTVCell) {
    //        payload.removeAll()
    //        BASE_URL = ""
    //        payload["id"] = "3"
    //        moreDeatilsViewModel?.CALL_GET_TERMSANDCONDITION_API(dictParam: payload, url: "https://provabdevelopment.com/pro_new/mobile/index.php/general/cms")
    //    }
    //
    //    func termsandcobditionDetails(response: AboutUsModel) {
    //        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    //    }
    //
    //    func contactDetals(response: ContactUsModel) {
    //
    //    }
    //
    //    func aboutusDetails(response: AboutUsModel) {
    //
    //    }
    //
    //
    //
    //    //MARK: - did Tap On Privacy Policy Action
    //    override func didTapOnPrivacyPolicyAction(cell: AcceptTermsAndConditionTVCell) {
    //        payload.removeAll()
    //        BASE_URL = ""
    //        payload["id"] = "4"
    //        moreDeatilsViewModel?.CALL_GET_PRIVICYPOLICY_API(dictParam: payload, url: "https://provabdevelopment.com/pro_new/mobile/index.php/general/cms")
    //    }
    //
    //
    //    func privacyPolicyDetails(response: AboutUsModel) {
    //        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    //    }
    //
    //
    //    //MARK: - Load URLS of T&C And Privacy Policy
    //
    //    func gotoAboutUsVC(title:String,desc:String) {
    //        guard let vc = AboutUsVC.newInstance.self else {return}
    //        vc.titleString = title
    //        vc.key1 = "webviewhide"
    //        vc.desc = desc
    //        vc.modalPresentationStyle = .fullScreen
    //        self.present(vc, animated: true)
    //
    //    }
    
    
    
    //MARK: - didTapOnBookNowBtn
    @IBAction func didTapOnBookNowBtn(_ sender: Any) {
        loderBool = true
        payload.removeAll()
        payload1.removeAll()
        
        
        
        var callpaymentbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        
        
        for traveler in travelerArray {
            
            if traveler.firstName == nil  || traveler.firstName?.isEmpty == true{
                callpaymentbool = false
                
            }
            
            if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }
            
            if traveler.lastName == nil || traveler.firstName?.isEmpty == true{
                callpaymentbool = false
            }
            
            if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
            
            if traveler.dob == nil || traveler.dob?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportno == nil || traveler.passportno?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportIssuingCountry == nil || traveler.passportIssuingCountry?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportExpireDate == nil || traveler.passportExpireDate?.isEmpty == true{
                callpaymentbool = false
            }
            
            
            // Continue checking other fields
        }
        
        
        
        let positionsCount = commonTableView.numberOfRows(inSection: 0)
        for position in 0..<positionsCount {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfTravellerTVCell {
                
                if cell.titleTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    
                } else {
                    // Textfield is not empty
                }
                
                if cell.fnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    fnameCharBool = false
                }else {
                    fnameCharBool = true
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    lnameCharBool = false
                } else {
                    // Textfield is not empty
                    lnameCharBool = true
                }
                
                
                if cell.dobTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.dobView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
                
                if cell.passportnoTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportnoView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
                
                if cell.passportIssuingCountryTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.issuecountryView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
                
                if cell.passportExpireDateTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportexpireView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
            }
        }
        
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let genderArray = travelerArray.compactMap({$0.gender})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let middlenameArray = travelerArray.compactMap({$0.middlename})
        let dobArray = travelerArray.compactMap({$0.dob})
        let passportnoArray = travelerArray.compactMap({$0.passportno})
        //   let nationalityArray = travelerArray.compactMap({$0.nationality})
        let passportIssuingCountryArray = travelerArray.compactMap({$0.passportIssuingCountry})
        let passportExpireDateArray = travelerArray.compactMap({$0.passportExpireDate})
        // let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        
        
        // Convert arrays to string representations
        let laedpassengerString = "[\"" + laedpassengerArray.joined(separator: "\",\"") + "\"]"
        let genderString = "[\"" + genderArray.joined(separator: "\",\"") + "\"]"
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let middlenameString = "[\"" + middlenameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let dobString = "[\"" + dobArray.joined(separator: "\",\"") + "\"]"
        let passportnoString = "[\"" + passportnoArray.joined(separator: "\",\"") + "\"]"
        let passportIssuingCountryString = "[\"" + passportIssuingCountryArray.joined(separator: "\",\"") + "\"]"
        let passportExpireDateString = "[\"" + passportExpireDateArray.joined(separator: "\",\"") + "\"]"
        let passengertypeArrayString = "[\"" + passengertypeArray.joined(separator: "\",\"") + "\"]"
        
        
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["tmp_flight_pre_booking_id"] = tmpFlightPreBookingId
        //   payload["access_key"] = accesskey
        payload["access_key_tp"] =  accesskeytp
        payload["insurance_policy_type"] = "0"
        payload["insurance_policy_option"] = "0"
        payload["insurance_policy_cover_type"] = "0"
        payload["insurance_policy_duration"] = "0"
        payload["isInsurance"] = "0"
        payload["selectedResult"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["redeem_points_post"] = "1"
        payload["booking_source"] = bookingsource
        payload["promocode_val"] = ""
        payload["promocode_code"] = ""
        payload["mealsAmount"] = "0"
        payload["baggageAmount"] = "0"
        
        
        // Assign string representations to payload dictionary
        payload["lead_passenger"] = laedpassengerString
        payload["gender"] = genderString
        payload["passenger_nationality"] = passportIssuingCountryString
        payload["name_title"] = mrtitleString
        payload["first_name"] = firstnameString
        payload["middle_name"] = middlenameString
        payload["last_name"] = lastNameString
        payload["date_of_birth"] = dobString
        payload["passenger_passport_number"] = passportnoString
        payload["passenger_passport_issuing_country"] = passportIssuingCountryString
        payload["passenger_passport_expiry"] = passportExpireDateString
        payload["passenger_type"] = passengertypeArrayString
        
        
        payload["Frequent"] = "\([["Select"]])"
        payload["ff_no"] = "\([[""]])"
        
        payload["address2"] = "ecity"
        payload["billing_address_1"] = "DA"
        payload["billing_state"] = "ASDAS"
        payload["billing_city"] = "sdfsd"
        payload["billing_zipcode"] = "sdf"
        
        payload["billing_email"] = payemail
        payload["passenger_contact"] = paymobile
        payload["billing_country"] = nationalityCode
        payload["country_mobile_code"] = paymobilecountrycode
        payload["insurance"] = "1"
        payload["tc"] = "on"
        payload["booking_step"] = "book"
        payload["payment_method"] = activepaymentoptions
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        payload["insurance_name"] = ""
        payload["insurance_code"] = ""
        payload["insurance_totalprice"] = ""
        payload["insurance_baseprice"] = ""
        payload["hidseatprice"] = ""
        payload["device_source"] = "MOBILE(A)"
        
        
        // Check additional conditions
        if callpaymentbool == false {
            showToast(message: "Add Details")
        }else if passportExpireDateBool == false {
            showToast(message: "Invalid expiry. Passport expires within the next 3 months.")
        }else if !fnameCharBool {
            showToast(message: "First name should have more than 3 characters")
        }else if !lnameCharBool {
            showToast(message: "Last name should have more than 3 characters")
        }else if payemail == "" {
            showToast(message: "Enter Email Address")
        }else if payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if paymobile == "" {
            showToast(message: "Enter Mobile No")
        }else if paymobilecountrycode == "" {
            showToast(message: "Enter Country Code")
        }else if mobilenoMaxLengthBool == false {
            showToast(message: "Enter Valid Mobile No")
        }else if checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            mbviewmodel?.CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API(dictParam: payload)
        }
    }
    
    
    
    //MARK: mobile process passenger Details
    func mobileprocesspassengerDetails(response: MBPModel) {
        
        DispatchQueue.main.async {
            BASE_URL = ""
            self.viewmodel1?.Call_mobile_secure_booking_API(dictParam: [:], url: "https://travrun.com/pro_new/mobile/index.php/flight/mobile_secure_booking/\(self.tmpFlightPreBookingId)/\(defaults.string(forKey: UserDefaultsKeys.searchid) ?? "")")
        }
        
        
    }
    
    
    
    func mobilesecurebookingDetails(response: MobilePrePaymentModel) {
        loderBool = false
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            TimerManager.shared.stopTimer()
            guard let vc = PaymentGatewayVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.payload = payload
            vc.grandTotalamount = self.totalPrice1
            vc.grand_total_Price = self.grand_total_Price
            vc.tmpFlightPreBookingId = self.tmpFlightPreBookingId
            present(vc, animated: true)
        }
    }
    
    
    func mobilePreBookingModelDetails(response: MobilePreBookingModel) {
        
        BASE_URL = ""
        payload["search_id"] = response.data?.search_id
        payload["app_reference"] = response.data?.app_reference
        payload["promocode_val"] = response.data?.promocode_val
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        

        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            mbviewmodel?.Call_mobile_pre_payment_confirmation_API(dictParam: payload, url: "https://travrun.com/pro_new/mobile/index.php/flight/mobile_pre_payment_confirmation")
        }
    }
    
    func mobileprepaymentconfirmationDetails(response: MobilePrePaymentModel) {
        
        
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            BASE_URL = ""
            mbviewmodel?.Call_mobile_send_to_payment_API(dictParam: [:], url: response.url ?? "")
        }
        
    }
    
    func mobilesendtopaymentDetails(response: MobilePrePaymentModel) {
        
        
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            DispatchQueue.main.async {
                BASE_URL = ""
                self.viewmodel1?.Call_mobile_secure_booking_API(dictParam: [:], url: response.url ?? "")
            }
        }
        
    }
    
    
    func mobolePaymentDetails(response: MobilePaymentModel) {
        
    }
    
    
    @IBAction func didTapOnMoveToTopTapBtn(_ sender: Any) {
        //        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        //        self.hiddenView.isHidden = true
    }
    
    
    @IBAction func didTapOnShowChatWindowBtn(_ sender: Any) {
        Freshchat.sharedInstance().showConversations(self)
    }
    
    
    
    //MARK: - AddDeatilsOfTravellerTVCell Delegate Methods
    
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfTravellerTVCell) {
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    override func tfeditingChanged(tf:UITextField) {
        print(tf.tag)
    }
    
    
    
    override func donedatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    
    func travellerDeletedSucess(response: AddTravellerModel) {
        
    }
    
    
    func updateProfileDetails(response: ProfileDetailsModel) {
        
    }
    
    override func didTapOnFlyerProgramBtnAction(cell:AddDeatilsOfTravellerTVCell){
        print(cell.flyerProgramTF.text)
    }
    
    
    
    
    //MARK: - did Tap On T&C Action
    
    override func didTapOnTAndCAction(cell: SpecialRequestTVCell) {
        payload.removeAll()
        BASE_URL = ""
        payload["id"] = "3"
        moreDeatilsViewModel?.CALL_GET_TERMSANDCONDITION_API(dictParam: payload, url: "https://travrun.com/pro_new/mobile/index.php/general/cms")
    }
    
    func termsandcobditionDetails(response: AboutUsModel) {
        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    }
    
    func contactDetals(response: ContactUsModel) {
        
    }
    
    func aboutusDetails(response: AboutUsModel) {
        
    }
    
    
    
    //MARK: - did Tap On Privacy Policy Action
    override func didTapOnPrivacyPolicyAction(cell: SpecialRequestTVCell) {
        payload.removeAll()
        BASE_URL = ""
        payload["id"] = "4"
        moreDeatilsViewModel?.CALL_GET_PRIVICYPOLICY_API(dictParam: payload, url: "https://travrun.com/pro_new/mobile/index.php/general/cms")
    }
    
    
    func privacyPolicyDetails(response: AboutUsModel) {
        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    }
    
    
    //MARK: - Load URLS of T&C And Privacy Policy
    
    func gotoAboutUsVC(title:String,desc:String) {
//        guard let vc = AboutUsVC.newInstance.self else {return}
//        vc.titleString = title
//        vc.key1 = "webviewhide"
//        vc.desc = desc
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
        
    }
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        searchWithsameInputs()
    }
    
    
    
}


extension BookingDetailsVC {
    
    //MARK: - Call Get Cointry List API
    func callGetCointryListAPI() {
        viewmodel?.CALLGETCOUNTRYLIST_API(dictParam: [:])
    }
    
    //MARK:  GetCountryList Response
    func getCountryList(response: AllCountryCodeListModel) {
        countrylist = response.all_country_code_list ?? []
    }
    
    //MARK: - call Profile Details API
    func callProfileDetailsAPI() {
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        profileDetilsVM?.CallGetProileDetails_API(dictParam: payload)
    }
    
    
    func getProfileDetails(response: ProfileDetailsModel) {
        pdetails = response.data
        
        defaults.set(response.data?.email, forKey: UserDefaultsKeys.useremail)
        defaults.set(response.data?.phone, forKey: UserDefaultsKeys.usermobile)
        
        
        DispatchQueue.main.async {[self] in
            callAllAPIS()
        }
    }
    
    
    func callAllAPIS() {
        MBfd?.removeAll()
        TimerManager.shared.sessionStop()
        
        DispatchQueue.main.async {
            self.callMobilePreProcessingBookingAPI()
        }
        
        
    }
    
    
    //MARK: -call Mobile Pre Processing Booking API
    func callMobilePreProcessingBookingAPI() {
        
        payload.removeAll()
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResult"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsourcekey)
        payload["user_id"] = 0
        payload["traceId"] = defaults.string(forKey: UserDefaultsKeys.traceId) ?? 0
        mbviewmodel?.CALLPREPROCESSINGBOOKINGAPI(dictParam: payload)
    }
    
    
    func mobilepreprocessbookingDetails(response: MBModel) {
        
        
        
        holderView.isHidden = false
        
        accesskey = response.pre_booking_params?.access_key ?? ""
        accesskeytp = response.access_key_tp ?? ""
        bookingsource = response.booking_source ?? ""
        tmpFlightPreBookingId = response.pre_booking_params?.transaction_id ?? ""
        activepaymentoptions = response.active_payment_options?[0] ?? ""
        totalPrice = Double(String(format: "%.2f", response.total_price ?? "")) ?? 0.0
        appreference = response.pre_booking_params?.transaction_id ?? ""
        frequent_flyersArray = response.frequent_flyers ?? []
        
        DispatchQueue.main.async {
            mbSummery = response.flight_data?[0].flightDetails?.summery ?? []
        }
        
        
        mbRefundable = defaults.string(forKey: UserDefaultsKeys.selectedFareType) ?? "Non Refundable"
        
        
        let i = response.pre_booking_params?.priceDetails
        Adults_Base_Price = String(i?.adultsBasePrice ?? "0.0")
        Adults_Tax_Price = String(i?.adultsTaxPrice ?? "0.0")
        Childs_Base_Price = String(i?.childBasePrice ?? "0.0")
        Childs_Tax_Price = String(i?.childTaxPrice ?? "0.0")
        Infants_Base_Price = String(i?.infantBasePrice ?? "0.0")
        Infants_Tax_Price = String(i?.infantTaxPrice ?? "0.0")
        AdultsTotalPrice = i?.adultsTotalPrice ?? "0"
        ChildTotalPrice = i?.childTotalPrice ?? "0"
        InfantTotalPrice = i?.infantTotalPrice ?? "0"
        sub_total_adult = i?.sub_total_adult ?? "0"
        sub_total_child = i?.sub_total_child ?? "0"
        sub_total_infant = i?.sub_total_infant ?? "0"
        
        grand_total_Price = i?.grand_total ?? ""
        totalAmountforBooking = i?.grand_total ?? ""
        
        setAttributedTextnew(str1: "\(i?.api_currency ?? "")",
                             str2: "\(i?.grand_total ?? "")",
                             lbl: bookNowlbl,
                             str1font: .InterBold(size: 12),
                             str2font: .InterBold(size: 18),
                             str1Color: .WhiteColor,
                             str2Color: .WhiteColor)
        
        
        TimerManager.shared.stopTimer()
        TimerManager.shared.startTimer(time: 900)
        
        
        DispatchQueue.main.async {
            self.setupTV()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.seconds) {
            self.callGetCointryListAPI()
        }
        
    }
    
    
}




extension BookingDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAfterLogin), name: NSNotification.Name("reloadAfterLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(passportexpiry), name: NSNotification.Name("passportexpiry"), object: nil)
        
    }
    
    
    @objc func passportexpiry(notify:NSNotification) {
        passportExpireDateBool = false
        showToast(message: (notify.object as? String) ?? "")
    }
    
    
    @objc func reloadTV() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            callAllAPIS()
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    //MARK: - reloadAfterLogin
    @objc func reloadAfterLogin() {
        callProfileDetailsAPI()
    }
    
    
    //MARK: - updateTimer
    func updateTimer() {
        let totalTime = TimerManager.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        setuplabels(lbl: sessonlbl, text: "Your Session Expires In : \(formattedTime)", textcolor: .AppLabelColor, font: .InterRegular(size: 16), align: .left)
    }
    
    
    
    
}


extension BookingDetailsVC {
    
    func searchWithsameInputs() {
        payload.removeAll()
        loderBool = true
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                
                payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
                payload["adult"] = defaults.string(forKey:UserDefaultsKeys.adultCount)
                payload["child"] = defaults.string(forKey:UserDefaultsKeys.childCount)
                payload["infant"] = defaults.string(forKey:UserDefaultsKeys.infantsCount)
                payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.selectClass)
                payload["sector_type"] = "international"
                payload["from"] = defaults.string(forKey:UserDefaultsKeys.fromCity)
                payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.fromlocid)
                payload["to"] = defaults.string(forKey:UserDefaultsKeys.toCity)
                payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.tolocid)
                payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                payload["return"] = ""
                payload["out_jrn"] = "All Times"
                payload["ret_jrn"] = "All Times"
                payload["carrier"] = ""
                payload["psscarrier"] = "ALL"
                payload["search_flight"] = "Search"
                payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
                payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
                
                if directFlightBool == false {
                    payload["direct_flight"] = "on"
                }
                
                
                if defaults.string(forKey:UserDefaultsKeys.fromCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.fromCity) == nil{
                    showToast(message: "Please Select From City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.toCity) == nil{
                    showToast(message: "Please Select To City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
                    showToast(message: "Please Select Different Citys")
                }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.calDepDate) == nil{
                    showToast(message: "Please Select Departure Date")
                }
                else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                    showToast(message: "Add Traveller")
                }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                    showToast(message: "Add Class")
                }else if checkDepartureAndReturnDates1(payload, p1: "depature") == false {
                    showToast(message: "Invalid Date")
                }else{
                    gotoSearchFlightResultVC(payload33: payload)
                }
                
            }else {
                
                
                payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
                payload["adult"] = defaults.string(forKey:UserDefaultsKeys.adultCount)
                payload["child"] = defaults.string(forKey:UserDefaultsKeys.childCount)
                payload["infant"] = defaults.string(forKey:UserDefaultsKeys.infantsCount)
                payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.selectClass)
                payload["sector_type"] = "international"
                
                payload["from"] = defaults.string(forKey:UserDefaultsKeys.fromCity)
                payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.fromlocid)
                payload["to"] = defaults.string(forKey:UserDefaultsKeys.toCity)
                payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.tolocid)
                
                payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                payload["return"] = defaults.string(forKey:UserDefaultsKeys.calRetDate)
                payload["out_jrn"] = "All Times"
                payload["ret_jrn"] = "All Times"
                payload["carrier"] = ""
                payload["psscarrier"] = "ALL"
                payload["search_flight"] = "Search"
                payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
                payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
                
                if directFlightBool == false {
                    payload["direct_flight"] = "on"
                }
                
                if defaults.string(forKey:UserDefaultsKeys.fromCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.fromCity) == nil{
                    showToast(message: "Please Select From City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.toCity) == nil{
                    showToast(message: "Please Select To City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
                    showToast(message: "Please Select Different Citys")
                }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.calDepDate) == nil{
                    showToast(message: "Please Select Departure Date")
                }else if defaults.string(forKey:UserDefaultsKeys.calRetDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.calRetDate) == nil{
                    showToast(message: "Please Select Return Date")
                }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == defaults.string(forKey:UserDefaultsKeys.calRetDate) {
                    showToast(message: "Please Select Different Dates")
                }
                else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == nil {
                    showToast(message: "Add Traveller")
                }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == nil {
                    showToast(message: "Add Class")
                }else if defaults.string(forKey:UserDefaultsKeys.fromCity) == defaults.string(forKey:UserDefaultsKeys.toCity) {
                    showToast(message: "Please Select Different Citys")
                }else if checkDepartureAndReturnDates(payload, p1: "depature", p2: "return") == false {
                    showToast(message: "Invalid Date")
                }else{
                    gotoSearchFlightResultVC(payload33: payload)
                }
                
            }
        }
        
        
    }
    
    
    
    func gotoSearchFlightResultVC(payload33:[String:Any]) {
        guard let vc = SearchResultPageViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        defaults.set(false, forKey: "flightfilteronce")
        vc.isFromVc = "searchvc"
        vc.isfromVc = "BookingDetailsVC"
        callapibool = true
        vc.payload = payload33
        self.present(vc, animated: true)
    }
}

extension BookingDetailsVC {
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


extension BookingDetailsVC {
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
                setupTV()
//                if isVcFrom == "BookingDetailsVC" {
//                    NotificationCenter.default.post(name: NSNotification.Name("reloadAfterLogin"), object: nil)
//                    self.dismiss(animated: true)
//                }else {
//                    //                    commonTableView.reloadData()
//                    setupTVCells()
//                }
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
                setupTV()
//                if isVcFrom == "BookingDetailsVC" || isVcFrom == "SideMenuViewController"{
//                    NotificationCenter.default.post(name: NSNotification.Name("reloadAfterLogin"), object: nil)
//                    self.dismiss(animated: true)
//                }else {
//                    //                        tablerow.removeAll()
//                    setupTVCells()
//                }
            }
        }
    }
}
