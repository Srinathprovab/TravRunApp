//
//  SearchHotelsResultVC.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//
//HotelBookingDetailsViewController
import UIKit
import DropDown

class SearchHotelsResultVC: BaseTableVC, UITextFieldDelegate, HotelSearchViewModelDelegate {
    
    @IBOutlet weak var dontClickBackLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var modifyButton: UIButton!
    @IBOutlet weak var modifyView: UIView!
    @IBOutlet weak var roomAdultCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityNAme: UILabel!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var cvHolderView: UIView!
    @IBOutlet weak var recommandedView: UIView!
    @IBOutlet weak var recommandedlbl: UILabel!
    @IBOutlet weak var recommandedbtn: UIButton!
    @IBOutlet weak var filterBtnView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterlbl: UILabel!
    @IBOutlet weak var filterBtn: UIButton!
   
    let dropDown = DropDown()
    var lastContentOffset: CGFloat = 0
    var tablerow = [TableRow]()
    var filtered = [HotelSearchResult]()
    var isSearchBool = false
    var searchText = String()
    var isvcfrom = String()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var countrycode = String()
    var isLoadingData = false
    var bsDataArray = [ABSData]()
    var viewModel:HotelSearchViewModel?
    var cityName = String()
    
    static var newInstance: SearchHotelsResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.SearchHotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchHotelsResultVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        
        if callapibool == true{
            holderView.isHidden = true
            callActiveBookingSourceAPI()
        }
    }
    
    
    func setupinitialView() {
        
        setupUI()
        commonTableView.register(UINib(nibName: "HotelsTVCell", bundle: nil), forCellReuseIdentifier: "cell44")
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupinitialView()
        viewModel = HotelSearchViewModel(self)
        //setuptv()
        
    }
    
    //MARK: - setupRefreshControl
   
    func setupUI() {
        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        modifyView.layer.cornerRadius = modifyView.layer.frame.width / 2
        cityNAme.text = defaults.string(forKey: UserDefaultsKeys.locationcityname) ?? ""
        dateLabel.text = "Checkin:\(defaults.string(forKey: UserDefaultsKeys.checkin) ?? "") | Checkout:\(defaults.string(forKey: UserDefaultsKeys.checkout) ?? "")"
        modifyButton.addTarget(self, action: #selector(didTapOnEditBtn(_:)), for: .touchUpInside)
        cvHolderView.isHidden = true
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        cvHolderView.backgroundColor = .WhiteColor
        cvHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        recommandedbtn.setTitle("", for: .normal)
        setuplabels(lbl: recommandedlbl, text: "SORT", textcolor: .AppLabelColor, font: .InterRegular(size: 16), align: .right)
        setuplabels(lbl: filterlbl, text: "FILTER", textcolor: .AppLabelColor, font: .InterRegular(size: 16), align: .left)
        
        commonTableView.backgroundColor = .WhiteColor
        filterBtn.addTarget(self, action: #selector(didTapOnFilterBtnAction(_:)), for: .touchUpInside)
        recommandedbtn.addTarget(self, action: #selector(didTapOnSortBtnAction(_:)), for: .touchUpInside)
        setupDropDown()
    }
    
    
    func setupDropDown() {
        
        dropDown.direction = .any
        dropDown.backgroundColor = .WhiteColor
        dropDown.dataSource = ["Price (Low to High)","Price (High to Low)","Hotel Name(A to Z)","Hotel Name(Z to A)"]
        dropDown.anchorView = self.recommandedbtn
        dropDown.bottomOffset = CGPoint(x: 0, y: recommandedbtn.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            print(item)
            
            switch item {
            case "Price (Low to High)":
                self?.filtersSortByApplied(sortBy: .PriceLow)
                break
                
            case "Price (High to Low)":
                self?.filtersSortByApplied(sortBy: .PriceHigh)
                break
                
            case "Hotel Name(A to Z)":
                self?.filtersSortByApplied(sortBy: .airlinessortatoz)
                break
                
            case "Hotel Name(Z to A)":
                self?.filtersSortByApplied(sortBy: .airlinessortztoa)
                break
                
            default:
                break
            }
        }
    }
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        // dismiss(animated: true)
        
        callapibool = false
        if isvcfrom == "dashboard" {
            guard let vc = DashBoardTabBarViewController.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.selectedIndex = 0
            self.present(vc, animated: false)
            dismiss(animated: true)
        } else {
//            guard let vc = SearchHotelsVC.newInstance.self else {return}
//            vc.modalPresentationStyle = .fullScreen
//            vc.isFromvc = "hotelvc"
//            self.present(vc, animated: false)
            dismiss(animated: true)
        }
    }
    
    
    @objc func didTapOnEditBtn(_ sender:UIButton){
        guard let vc = ModifyHotelViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .popover
        callapibool = true
        present(vc, animated: true)
    }
    
    override func viewBtnAction(cell: CommonFromCityTVCell) {
        print(cell.subtitlelbl.text as Any)
    }
    
    override func didTapOnDual1Btn(cell:CommonFromCityTVCell){
        print(cell.dual1lbl2.text ?? "")
    }
    override func didTapOnDual2Btn(cell:CommonFromCityTVCell){
        print(cell.dual2lbl2.text ?? "")
    }
    
    
    @objc func editingTextField1(_ tf: UITextField) {
        searchText = tf.text ?? ""
        
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
            
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        filtered.removeAll()
        filtered = hotelSearchResult.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        commonTableView.reloadData()
    }
    
    
    override func mapViewBtnAction(cell: SearchLocationTFTVCell){
        print("mapViewBtnAction ..")
    }
    
    
    
    //MARK: - didTapOnTermsAndConditionBtn HotelsTVCell
    override func didTapOnTermsAndConditionBtn(cell: HotelsTVCell) {
        goToTermsPopupVC(titlestr: cell.hotelNamelbl.text ?? "", hoteldesc: cell.hotel_DescLabel)
    }
    
    
    func goToTermsPopupVC(titlestr:String,hoteldesc:String) {
        guard let vc = TermsPopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titlestr = titlestr
        vc.hotel_desc = hoteldesc
        present(vc, animated: false)
    }
    
    
    
    //MARK: - didTapOnBookNowBtnAction HotelsTVCell
    override func didTapOnBookNowBtnAction(cell: HotelsTVCell){
        self.goToHotelDetailsVC(hid: cell.hotelid, bs: cell.bookingsource, kwdprice: cell.kwdlbl.text ?? "")
    }
    
    
    func goToHotelDetailsVC(hid:String,bs:String,kwdprice:String) {
        guard let vc = HotelDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.hotelid = hid
        vc.bookingsource = bs
        vc.kwdprice = kwdprice
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: - scrollViewDidScroll
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        if scrollView.contentOffset.y > self.lastContentOffset {
    //            // scrolling down
    //            if self.hiddenView.alpha == 1 {
    //                UIView.animate(withDuration: 0.3) {
    //                    self.hiddenView.alpha = 0
    //                    self.hiddenView.isHidden = true
    //                }
    //            }
    //        } else if scrollView.contentOffset.y < self.lastContentOffset {
    //            // scrolling up
    //            if self.hiddenView.alpha == 0 {
    //                UIView.animate(withDuration: 0.3) {
    //                    self.hiddenView.alpha = 1
    //                    self.hiddenView.isHidden = false
    //                }
    //            }
    //        }
    //        self.lastContentOffset = scrollView.contentOffset.y
    //    }
    
    //    @IBAction func didTapOnMoveUpScreenBtn(_ sender: Any) {
    //        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    //        self.hiddenView.isHidden = true
    //    }
    
    
    @objc func didTapOnFilterBtnAction(_ sender:UIButton) {
        gotoFilterVC(strkey: "hotelfilter")
    }
    
    
    @objc func didTapOnSortBtnAction(_ sender:UIButton) {
        dropDown.show()
    }
    
    func gotoFilterVC(strkey:String) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.filterKey = strkey
        present(vc, animated: true)
    }
    
    
    
    func setAttributedText1(str1:String,str2:String,lbl:UILabel)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,
                      NSAttributedString.Key.font:UIFont.InterRegular(size: 14)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor: HexColor("#3C627A"),
                      NSAttributedString.Key.font:UIFont.InterBold(size: 22)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        lbl.attributedText = combination
        
    }
    
    
    @IBAction func bakBtnAction(_ sender: Any) {
        
        callapibool = false
        if isvcfrom == "ModifyHotelViewController" {
            guard let vc = SearchHotelsVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.isFromvc = "SearchHotelsResultVC"
            present(vc, animated: true)
        } else if isvcfrom == "BookingDetailsVC" {
            guard let vc = SearchHotelsVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.isFromvc = "SearchHotelsResultVC"
            present(vc, animated: true)
        } else {
            dismiss(animated: false)
        }
    }
    
    
    @IBAction func didTapOnMapViewBtnAction(_ sender: Any) {
        
        guard let vc = MapViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}


extension SearchHotelsResultVC {
    
   
    func callActiveBookingSourceAPI() {
        viewModel?.CALL_GET_ACTIVE_BOOKING_SOURCE_API(dictParam: [:])
    }
    
    func activebookingSourceResult(response: ActiveBookingSourceModel) {
        
        bsDataArray = response.data ?? []
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            callHotelPreSearchAPI()
        }
    }
    
    
    
    
    func callHotelPreSearchAPI() {
        
        loderBool = true
        do {
            
            let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
            print(theJSONText ?? "")
            payload1["search_params"] = theJSONText
           
            
            viewModel?.CallHotelPreSearchAPI(dictParam: payload1)
            
        }catch let error as NSError{
            print(error.description)
        }
        
    }
    
    func hoteSearchPreResult(response: HotelSearchNewModel) {
        
        bsDataArray.forEach { i in
            
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                callHotelSearchAPI(bookingsource: i.source_id ?? "",
                                      searchid: "\(response.search_id ?? 0)")
            }
            
        }
       
    }
    
    
    func callHotelSearchAPI(bookingsource:String,searchid:String){
        payload.removeAll()
        payload["offset"] = "0"
        payload["limit"] = "10"
        payload["booking_source"] = bookingsource
        payload["search_id"] = searchid
        
        viewModel?.CallHotelSearchAPI(dictParam: payload)
    }
    
    
    
    func hoteSearchResult(response: HotelSearchModel) {
        
        latArray.removeAll()
        longArray.removeAll()
        prices.removeAll()
        mapModelArray.removeAll()
        hotelSearchResult.removeAll()
        
//        navView.isHidden = false
        filterBtnView.isHidden = false
        commonTableView.isHidden = false
        cvHolderView.isHidden = false
        loderBool = false
        holderView.isHidden = false
        
        hotelSearchId = (response.search_id ?? "0")
        hsearchid = (response.search_id ?? "0")
        hbookingsource = response.data?.hotelSearchResult?[0].booking_source ?? ""
        hotelSearchResult = response.data?.hotelSearchResult ?? []
        //   hotel_filtersumry = response.filter_sumry
       // hotelSearchResult.append(response.data?.hotelSearchResult ?? [])
        
        
        response.data?.hotelSearchResult?.forEach { i in
            prices.append(i.price ?? "")
            let mapModel = MapModel(
                longitude: i.longitude ?? "",
                latitude: i.latitude ?? "",
                hotelname: i.name ?? ""
            )
            mapModelArray.append(mapModel)
        }
        
        if response.status != 0 {
            secondsLabel.isHidden = true
            dontClickBackLabel.isHidden = true
        }
        //        response.filter_sumry?.loc?.forEach({ i in
        //            nearBylocationsArray.append(i.v ?? "")
        //        })
        //
        //        response.filter_sumry?.near_by?.forEach({ i in
        //            neighbourwoodArray.append(i.v ?? "")
        //        })
        //
        //        response.filter_sumry?.facility?.forEach({ i in
        //            amenitiesArray.append(i.v ?? "")
        //        })
        //
        
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check search text & original text
        if( isSearchBool == true){
            return filtered.count
        }else{
            return hotelSearchResult.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell44", for: indexPath) as? HotelsTVCell{
            cell.selectionStyle = .none
            cell.delegate = self
            
            if( isSearchBool == true){
                
                let dict = filtered[indexPath.row]
                
                cityName = dict.location ?? ""
                cell.hotelNamelbl.text = dict.name
                cell.hotelImg.sd_setImage(with: URL(string: dict.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.ratingslbl.text = String(dict.star_rating ?? "0")
                cell.locationlbl.text = dict.address
                setAttributedText1(str1: dict.currency ?? "", str2: dict.price ?? "", lbl: cell.kwdlbl)
                cell.bookingsource = dict.booking_source ?? ""
                cell.hotelid = String(dict.hotel_code ?? "0")
                cell.lat = dict.latitude ?? ""
                cell.long = dict.longitude ?? ""
                
                cell.perNightlbl.text = "Total Price For 2 Night"
                cell.setAttributedString1(str1:dict.currency ?? "", str2: dict.price ?? "")
                
                
                cell.hotel_DescLabel = dict.hotel_desc ?? "bbbbb"
                //                if let hotel_desc = dict.hotel_desc{
                //                    cell.hotelDescLabel = hotel_desc
                //                } else {
                //                    // Handle the case when facility is empty or nil
                //                    print("hotel_desc array is empty or nil")
                //                }
                
                if let facilities = dict.facility, !facilities.isEmpty {
                    cell.facilityArray = facilities
                } else {
                    // Handle the case when facility is empty or nil
                    print("Facility array is empty or nil")
                }
                
                
                cell.faretypelbl.text = dict.refund ?? ""
                if cell.faretypelbl.text == "Non Refundable" {
                    cell.faretypelbl.textColor = .AppBtnColor
                }
                
                ccell = cell
            }else{
                let dict = hotelSearchResult[indexPath.row]
                
                cell.hotelNamelbl.text = dict.name
                cell.hotelImg.sd_setImage(with: URL(string: dict.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.ratingslbl.text = String(dict.star_rating ?? "0")
                cell.locationlbl.text = dict.address
                setAttributedText1(str1: dict.currency ?? "", str2: dict.price ?? "", lbl: cell.kwdlbl)
                cell.bookingsource = dict.booking_source ?? ""
                cell.hotelid = String(dict.hotel_code ?? "0")
                cell.lat = dict.latitude ?? ""
                cell.long = dict.longitude ?? ""
                cell.perNightlbl.text = "Total Price For 2 Night"
                cell.setAttributedString1(str1:dict.currency ?? "", str2: dict.price ?? "")
                
                
                cell.hotel_DescLabel = dict.hotel_desc ?? "bbbbb"
                //                if let hotel_desc = dict.hotel_desc{
                //                    cell.hotelDescLabel = hotel_desc
                //                } else {
                //                    // Handle the case when facility is empty or nil
                //                    print("hotel_desc array is empty or nil")
                //                }
                
                if let facilities = dict.facility, !facilities.isEmpty {
                    cell.facilityArray = facilities
                } else {
                    // Handle the case when facility is empty or nil
                    print("Facility array is empty or nil")
                }
                
                
                
                cell.faretypelbl.text = dict.refund ?? ""
                if cell.faretypelbl.text == "Non Refundable" {
                    cell.faretypelbl.textColor = .AppBtnColor
                }
                
                ccell = cell
            }
        }
        
        return ccell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}




extension SearchHotelsResultVC {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex && !isLoadingData {
            callHotelSearchPaginationAPI()
        }
    }
    
    func callHotelSearchPaginationAPI() {
        print("You've reached the last cell, trigger the API call.")
        
        payload.removeAll()
        payload["booking_source"] = hbookingsource
        payload["search_id"] = hsearchid
        payload["offset"] = "2"
        payload["limit"] = "10"
        payload["no_of_nights"] = "1"
        
        viewModel?.CallHotelSearchPagenationAPI(dictParam: payload)
        
    }
    
    func hoteSearchPagenationResult(response: HotelSearchModel) {
        
        
        response.data?.hotelSearchResult?.forEach { i in
            prices.append(i.price ?? "")
            let mapModel = MapModel(
                longitude: i.longitude ?? "",
                latitude: i.latitude ?? "",
                hotelname: i.name ?? ""
            )
            mapModelArray.append(mapModel)
        }
        
        
        if let newResults = response.data?.hotelSearchResult, !newResults.isEmpty {
            // Append the new data to the existing data
            hotelSearchResult.append(contentsOf: newResults)
            DispatchQueue.main.async {
                self.commonTableView.reloadData()
            }
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }
        
        
        
        
    }
    
}




extension SearchHotelsResultVC:AppliedFilters{
    
    
    
    func filtersByApplied(minpricerange: Double, maxpricerange: Double, noofStopsArray: [String], refundableTypeArray: [String], departureTime: [String], arrivalTime: [String], noOvernightFlight: [String], airlinesFilterArray: [String], luggageFilterArray: [String], connectingFlightsFilterArray: [String], ConnectingAirportsFilterArray: [String]) {
    }
    
    //MARK: - hotelFilterByApplied
    
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, refundableTypeArray: [String], nearByLocA: [String], niberhoodA: [String], aminitiesA: [String]) {
        
        // Set the filter flag to true
        isSearchBool = true
        
        // Print filter parameters for debugging
        print("Min Price Range: \(minpricerange)")
        print("Max Price Range: \(maxpricerange)")
        print("Star Rating: \(starRating)")
        print("Refundable Types: \(refundableTypeArray)")
        print(" ==== nearByLocA === \n\(nearByLocA)")
        print(" ==== niberhoodA === \n\(niberhoodA)")
        print(" ==== aminitiesA === \n\(aminitiesA)")
        
        
        // Filter the hotels based on the specified criteria
        let filteredArray = hotelSearchResult.filter { hotel in
            guard let netPrice = Double(hotel.price ?? "0.0") else { return false }
            
            // Check if the hotel's star rating matches the selected star rating or is empty
            let ratingMatches = starRating.isEmpty || String(hotel.star_rating ?? "0") == starRating
            
            // Check if the hotel's refund type matches any selected refundable types or the array is empty
            let refundableMatch = refundableTypeArray.isEmpty || refundableTypeArray.contains(hotel.refund ?? "")
            
            // Check if the hotel's price falls within the specified range
            let priceInRange = netPrice >= minpricerange && netPrice <= maxpricerange
            
            return ratingMatches && refundableMatch && priceInRange
        }
        
        // Update the filtered results
        filtered = filteredArray
        
        // Display a message if no hotels match the criteria
        if filtered.count == 0 {
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        } else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
        }
        
        // Reload the table view with the filtered results
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - SORT BY FILTER
    func filtersSortByApplied(sortBy: SortParameter) {
        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        switch sortBy {
            
        case .PriceLow:
            
            isSearchBool = true
            
            // Sort the hotelSearchResult array by price in ascending order
            filtered = hotelSearchResult.sorted { (item1, item2) in
                let price1 = Double(item1.price ?? "0") ?? 0
                let price2 = Double(item2.price ?? "0") ?? 0
                return price1 < price2
            }
            
            
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
        case .PriceHigh:
            
            isSearchBool = true
            // Sort the hotelSearchResult array by price in ascending order
            filtered = hotelSearchResult.sorted { (item1, item2) in
                let price1 = Double(item1.price ?? "0") ?? 0
                let price2 = Double(item2.price ?? "0") ?? 0
                return price1 > price2
            }
            
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
        case .airlinessortatoz:
            
            isSearchBool = true
            filtered = hotelSearchResult.sorted { $0.name ?? "" < $1.name ?? "" }
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
        case .airlinessortztoa:
            isSearchBool = true
            
            filtered = hotelSearchResult.sorted { $0.name ?? "" > $1.name ?? "" }
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            break
            
            
            
        default:
            break
        }
    }
    
}



extension SearchHotelsResultVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
    }
    
    
    @objc func reload() {
        commonTableView.reloadData()
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
    
    
}


