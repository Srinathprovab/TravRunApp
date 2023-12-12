//
//  BookingDetailsViewController.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23.
//

import UIKit

class BookingDetailsViewController: BaseTableVC, RegisterViewModelProtocal, ProfileDetailsViewModelDelegate {
 
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var backButtonView: UIView!
    var tablerow = [TableRow]()
    var viewmodel1:ProfileDetailsViewModel?
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
        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        commonTableView.registerTVCells(["BookingDetailsCardTVCellTableViewCell",
                                         "EmptyTVCell", "RegisterSelectionLoginTableViewCell", "GuestRegisterTableViewCell", "RegisterNowTableViewCell", "LoginDetailsTableViewCell", "AddAdultTableViewCell", "FareSummaryTableViewCell", "AcceptTermsAndConditionTVCell", "HeaderTableViewCell", "AddressTableViewCell"])
        setupFilterTVCells()
        callProfileDetailsAPI()
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

