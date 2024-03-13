//
//  SideMenuViewController.swift
//  Travrun
//
//  Created by MA1882 on 15/11/23.
//

import UIKit

class SideMenuViewController: BaseTableVC, ProfileDetailsViewModelDelegate, LogoutViewModelDelegate {
   
    static var newInstance: SideMenuViewController? {
        let storyboard = UIStoryboard(name: Storyboard.DashBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuViewController
        return vc
    }
    
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var viewmodel1:ProfileDetailsViewModel?
    var logoutvm :LogoutViewModel?
    var profilcallAPIBool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel1 = ProfileDetailsViewModel(self)
        logoutvm = LogoutViewModel(self)
        setupUI()
        setupMenuTVCells()
        self.callProfileDetailsAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if profilcallAPIBool == true {
            DispatchQueue.main.async {
                self.callProfileDetailsAPI()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(callprofileapi), name: Notification.Name("reloadAfterLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(callprofileapi), name: Notification.Name("callprofileapi"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
    }
    
    //MARK: - callprofileapi
    @objc func callprofileapi() {
        DispatchQueue.main.async {
            self.callProfileDetailsAPI()
        }
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    func setupUI() {
        commonTableView.isScrollEnabled = true
        commonTableView.registerTVCells(["MenuBGTVCell",
                                         "QuickLinkTableViewCell",
                                         "SideMenuTitleTVCell",
                                         "EmptyTVCell", "SupportTVCellTableViewCell"])
      }
    
    func setupMenuTVCells() {
        tablerow.removeAll()
        tablerow.append(TableRow(cellType: .MenuBGTVCell))
        tablerow.append(TableRow(height: 20,cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Services",key: "links", image: "", height: 250, cellType: .QuickLinkTableViewCell))
        tablerow.append(TableRow(height: 10, bgColor: HexColor("#FFFFFF") , cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Services",key: "bookings", image: "",height: 170, cellType: .SupportTVCellTableViewCell))
        tablerow.append(TableRow(height: 80, cellType: .EmptyTVCell))
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            tablerow.append(TableRow(title:"Logout",key: "logout", image: "IonLogOut",cellType:.SideMenuTitleTVCell))
        }
        tablerow.append(TableRow(height: 25, cellType: .EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
        guard let vc = LoginViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.isVcFrom = "SideMenuVC"
        present(vc, animated: true)

    }
    
    override func didTaponFlightBtn(cell: QuickLinkTableViewCell) {
        guard let vc = FlightViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overFullScreen
        vc.isfromVc = "SideMenuViewController"
        present(vc, animated: true)
    }
    override func didTaponHotelBtn(cell: QuickLinkTableViewCell) {
        guard let vc = SearchHotelsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overFullScreen
        vc.isFromvc = "SideMenuViewController"
        present(vc, animated: true)
    }
    
    override func didTaponCell(cell: SideMenuTitleTVCell) {
//        switch cell.menuTitlelbl.text {
//        case "Flight":
//            print("Flight")
//            showFlightSearchVC()
//            break
//        case "Hotel":
//            print("Hotel")
//            break
//        case "Visa":
//            print("Visa")
//            break
//        case "Auto Payment":
//            print("Auto Payment")
//            break
//        case "My Bookings":
//            print("My Bookings")
//            break
//        case "Free Cancelation":
//            print("Free Cancelation")
//            break
//        case "Customer Support":
//            print("Customer Support")
//            break
//        case "Logout":
//            print("logout here")
//            callLogoutAPI()
//            break
//        default:
//            break
//        }
        callLogoutAPI()
    }
    
    func showFlightSearchVC() {
    guard let vc = FlightViewController.newInstance.self else {return}
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true)
    }
    
    func callLogoutAPI() {
        BASE_URL = BASE_URL1
        payload.removeAll()
        payload["username"] = defaults.string(forKey: UserDefaultsKeys.useremail) ?? ""
        logoutvm?.CALL_MOBILE_USER_LOGOUT_API(dictParam: payload)
    }
    
    
    func logoutSucessDetails(response: LogoutModel) {
        showToast(message: response.data ?? "")
        let seconds = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set("0", forKey: UserDefaultsKeys.userid)
            defaults.set("", forKey: UserDefaultsKeys.useremail)
            defaults.set("", forKey: UserDefaultsKeys.usermobile)
            defaults.set("", forKey: UserDefaultsKeys.uname)
            defaults.set("", forKey: UserDefaultsKeys.mcountrycode)
            
            // Reset Standard User Defaults
            UserDefaults.resetStandardUserDefaults()
            self.setupMenuTVCells()
        }
    }
    
    
    
    
    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            guard let vc = EditProfileViewController.newInstance.self else {return}
            vc.modalPresentationStyle = .popover
            vc.isfrom = "SideMenuViewController"
            present(vc, animated: true)
        } else {
            guard let vc = LoginViewController.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true)
        }
    }
    
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
        DispatchQueue.main.async {[self] in
            setupMenuTVCells()
        }
    }
    
    func updateProfileDetails(response: ProfileDetailsModel) {}
}

