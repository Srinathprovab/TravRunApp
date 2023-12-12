//
//  HomeViewController.swift
//  Travrun
//
//  Created by Mahesh on 09/11/23.
//

import UIKit

class HomeViewController: BaseTableVC, AllCountryCodeListViewModelDelegate, TopFlightDetailsViewModelDelegate {
    
    @IBOutlet weak var fightButton: UIButton!
    @IBOutlet weak var fightView: UIView!
    @IBOutlet weak var hotelButton: UIButton!
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var visaButton: UIButton!
    @IBOutlet weak var visaView: UIView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var payView: UIView!
    
    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var tabSelectCV: UICollectionView!
    
    static var newInstance: HomeViewController? {
        let storyboard = UIStoryboard(name: Storyboard.DashBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HomeViewController
        return vc
    }

    var tabNames = ["Flight","Hotel","Visa", "Pay"]
    var tabNamesImages = ["flightIcon","hotelIcon","visaIcon", "payIcon"]
    var tableRow = [TableRow]()
    
    private var sideMenuViewController: SideMenuViewController!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    var vm: AllCountryCodeListViewModel?
    var viewmodel: TopFlightDetailsViewModel?
    var viewModel1 : FlightListViewModel?
    var profileViewmodel: ProfileDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeViewController")
        setUpView()
        viewmodel = TopFlightDetailsViewModel(self)
        vm = AllCountryCodeListViewModel(self)
        callCountryListAPI()
        self.callApi()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        if callapibool == true {
            DispatchQueue.main.async {
                self.callApi()
            }
        }
    }
    
    func callApi() {
        DispatchQueue.main.async {
            self.callTopFlightsHotelsDetailsAPI()
        }
    }
    
    func callTopFlightsHotelsDetailsAPI() {
        viewmodel?.callTopFlightsHotelsDetailsAPI(dictParam: [:])
    }

    func callCountryListAPI() {
        vm?.CALLGETCOUNTRYLIST_API(dictParam: [:])
    }
    
    func getCountryList(response: AllCountryCodeListModel) {
        countrylist = response.all_country_code_list ?? []
    }

//    override func viewWillAppear(_ animated: Bool) {
//        tabBarController?.tabBar.isHidden = false
//    }
    //MARK: REGISTER TABEL VIEW CELLS
    
    func setUpView() {
        self.commonTableView.registerTVCells(["SpecialDealsTVCell","TopCityTVCell","EmptyTVCell", "holidayTableViewCell"])
        priceLabel.textColor = .white
        priceLabel.font = UIFont.latoRegular(size: 14)
        payView.layer.cornerRadius = 6
        visaView.layer.cornerRadius = 6
        fightView.layer.cornerRadius = 6
        hotelView.layer.cornerRadius = 6
        setUpTableView()
        setupMenu()
    }
    
    
    
    func setUpTableView() {
        tableRow.removeAll()
        if topHotelDetails.count != 0 {
            tableRow.append(TableRow(title:"Popular Hotels",key: "hotels", cellType: .SpecialDealsTVCell))
        } else {
            tableRow.append(TableRow(height: 0,cellType: .EmptyTVCell))
        }
        tableRow.append(TableRow(title:"Popular  Destinations", key: "flights", cellType: .SpecialDealsTVCell))
        if topHolidayList.count != 0 {
            tableRow.append(TableRow(title:"Top Holiday Destinations", key: "holiday", cellType: .holidayTableViewCell))
        } else {
            tableRow.append(TableRow(height: 0,cellType: .EmptyTVCell))
        }
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    //MARK: - RELOAD TABLE VIEW
    @objc func reload(notification: Notification) {
        commonTableView.reloadData()
    }
    
    
    @IBAction func currencyButtonAction(_ sender: Any) {
        
        guard let vc = SelectLanguageViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    @IBAction func sideMenuButtonAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("callprofileapi"), object: nil)
        self.tabBarController?.tabBar.isHidden = true
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    @IBAction func flightButtonAction(_ sender: Any) {
        guard let vc = FlightViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        keyStr = "search"
        vc.isfromVc = "dashboardvc"
        callapibool = true
        self.present(vc, animated: true)
    }
    
}


extension HomeViewController {
    func setupMenu(){
        
        //MARK: Shadow Background View
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
        
        //MARK: Side Menu
        let storyboard = UIStoryboard(name: "DashBoard", bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController
        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
        
        //MARK: Side Menu AutoLayout
        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth + 50),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        //MARK: Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            NotificationCenter.default.post(name: NSNotification.Name("callprofileapi"), object: nil)
            self.tabBarController?.tabBar.isHidden = true
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
            
        }
        else {
            self.tabBarController?.tabBar.isHidden = false
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
            
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    //MARK: CALL TOP FLIGHT DETAILS IMAGES API FUNCTION
    func topFlightDetailsImages(response: TopFlightDetailsModel) {
        topFlightDetails = response.topFlightDetails ?? []
        topHotelDetails = response.topHotelDetails ?? []
        deailcodelist = response.deail_code_list ?? []
        topHolidayList = response.holiday_top_destination ?? []
        DispatchQueue.main.async {[self] in
            setUpTableView()
        }
        
        DispatchQueue.main.async {[self] in
            callCountryListAPI()
        }
        
        
    }
    
}

extension HomeViewController: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard gestureEnabled == true else { return }
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state {
        case .began:
            
            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }
            
            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }
                
                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }
            
        case .changed:
            
            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                    
                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha
                    
                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                        
                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha
                        
                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}


