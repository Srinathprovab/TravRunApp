//
//  SearchResultPageViewController.swift
//  Travrun
//
//  Created by MA1882 on 20/11/23.
//

import UIKit

class SearchResultPageViewController: BaseTableVC, FlightListModelProtocal {
    
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var returnDatalbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var rightButtonView: UIView!
    @IBOutlet weak var leftButtonView: UIView!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var personsCategoryLabel: UILabel!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var editButtonView: UIView!
    
    var lastContentOffset: CGFloat = 0
    static var newInstance: SearchResultPageViewController? {
        let storyboard = UIStoryboard(name: Storyboard.FlightStoryBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchResultPageViewController
        return vc
    }
    
    
    let dateFormatter = DateFormatter()
    var isfromVc = String()
    var tablerow = [TableRow]()
    var kwdPriceArray = [String]()
    var dateArray = [String]()
    let refreshControl = UIRefreshControl()
    var filterdFlightList :[[J_flight_list]]?
    var filterdRTJ_flight_list :[[RTJ_flight_list]]?
    var filterdMCJ_flight_list :[[MCJ_flight_list]]?
    var isFromVc = String()
    var directFlightBool = true
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var viewModel : FlightListViewModel?
    var totalprice = String()
    
    
    override func viewWillAppear(_ animated: Bool) {
        BASE_URL = BASE_URL1
        addObserver()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        if callapibool == true {
            holderView.isHidden = true
            callAPI()
            
        }
    }
    
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .WhiteColor
        super.viewDidLoad()
        
        viewModel = FlightListViewModel(self)
        setUpView()
    }
    
    func setUpView() {
        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        editButtonView.layer.cornerRadius = editButtonView.layer.frame.width / 2
        leftButtonView.layer.cornerRadius = leftButtonView.layer.frame.width / 2
        
        rightButtonView.layer.cornerRadius = rightButtonView.layer.frame.width / 2
        sortView.layer.cornerRadius = 6
        filterView.layer.cornerRadius = 6
        registerTV()
    }
    
    func setupTV() {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedTab == "multicity" {
                multicityFilterdList(list: MCJflightlist ?? [])
            }else {
                onewayFilterdList(list: FlightList ?? [])
            }
        }
    }
    
    
    func registerTV() {
        self.commonTableView.registerTVCells(["SearchFlightResultTVCell",
                                              "EmptyTVCell",
                                              "RoundTripFlightResultTVCell",
                                              "FlightDetailsTVCell",
                                              "NewFlightSearchResultTVCell",
                                              "MultiCityTripFlightResultTVCell"])
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: false)
    }
    
    
    @IBAction func fliterButtonAction(_ sender: Any) {
        
        guard let vc = ProcessingViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    @IBAction func didTapOnPreviousDateBtnAction(_ sender: Any) {
        
        holderView.isHidden = true
        loderBool = true
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the previous day's date
                let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let previousDayString = dateFormatter.string(from: previousDay!)
                print("previousDayString ==== > \(previousDayString)")
                defaults.set(previousDayString, forKey: UserDefaultsKeys.calDepDate)
                payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                self.datelbl.text = previousDayString
                
                callAPI()
                
            } else {
                
                
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: -1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                
                if returnDatalbl.text == nextDayString {
                    showToast(message: "Journey Dates Should Not Same")
                }else {
                    
                    
                    print("nextDayString ==== > \(nextDayString)")
                    defaults.set(nextDayString, forKey: UserDefaultsKeys.rcalDepDate)
                    payload["depature"] = defaults.string(forKey:UserDefaultsKeys.rcalDepDate)
                    self.datelbl.text = nextDayString
                    
                    callAPI()
                }
            }
            
        }
        
        
    }
    
    
    @IBAction func sortButtonAction(_ sender: Any) {
        
        guard let vc = SortViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
        
    }
    
    //MARK: - didTapOnNextDateBtnTapAction
    @IBAction func didTapOnNextDateBtnTapAction(_ sender: Any) {
        
        holderView.isHidden = true
        loderBool = true
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            
            if journeyType == "oneway" {
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                print("nextDayString ==== > \(nextDayString)")
                defaults.set(nextDayString, forKey: UserDefaultsKeys.calDepDate)
                payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                self.datelbl.text = nextDayString
                
                callAPI()
                
            }else {
                
                
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                print("nextDayString ==== > \(nextDayString)")
                
                if returnDatalbl.text == nextDayString {
                    showToast(message: "Journey Dates Should Not Same")
                }else {
                    
                    
                    defaults.set(nextDayString, forKey: UserDefaultsKeys.rcalDepDate)
                    payload["depature"] = defaults.string(forKey:UserDefaultsKeys.rcalDepDate)
                    self.datelbl.text = nextDayString
                    
                    callAPI()
                }
            }
            
        }
        
    }
    
  override func didTapOnflightDetailsButton(cell:NewFlightSearchResultTVCell) {
      guard let vc = FlightDetailsViewController.newInstance.self else {return}
      vc.modalPresentationStyle = .overFullScreen
      self.present(vc, animated: false)
    }
}

extension SearchResultPageViewController {
    
}

extension SearchResultPageViewController {
    
    func callAPI() {
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "multicity" {
                viewModel?.CallMulticityTripSearchFlightAPI(dictParam: payload)
            }else {
                viewModel?.CallSearchFlightAPI(dictParam: payload)
            }
        }
    }
    
    
    func onewayFilterdList(list:[[J_flight_list]]) {
        commonTableView.backgroundColor = .AppHolderViewColor
        tablerow.removeAll()
        var updatedUniqueList: [[J_flight_list]] = []
        updatedUniqueList = getUniqueElements_oneway(inputArray: list)
        
        if list.count == 0 {
            tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        } else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            tablerow.removeAll()
            
            updatedUniqueList.forEach({ i in
                i.forEach { j in
                    let similarFlights1 = similar(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)
                    
                    
                    // Append the current flight and its similar flights to tablerow
                    var row: [TableRow] = []
                    row.append(TableRow(title:"\(j.price?.api_total_display_fare_withoutmarkup ?? 0.0)",
                                        subTitle: j.fareType ?? "",
                                        price: "\(j.price?.api_total_display_fare ?? 0.0)",
                                        bookingsource: j.booking_source,
                                        bookingsourcekey: j.booking_source_key,
                                        key: "oneway",
                                        text: j.selectedResult ?? "",
                                        buttonTitle: j.aPICurrencyType ?? "",
                                        data: similarFlights1,
                                        moreData: j.flight_details?.summary ?? [],
                                        cellType:.NewFlightSearchResultTVCell))
                    
                    // Append the row to tablerow
                    tablerow.append(contentsOf: row)
                }
            })
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
    }
    
    
    func onewayFilterdList1(list:[J_flight_list]) {
        commonTableView.backgroundColor = .AppHolderViewColor
        tablerow.removeAll()
        
        
        
        list.forEach { j in
            let similarFlights1 = similar(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)
            
            tablerow.append(TableRow(title:"\(j.price?.api_total_display_fare_withoutmarkup ?? 0.0)",
                                     subTitle: j.fareType ?? "",
                                     price: "\(j.price?.api_total_display_fare ?? 0.0)",
                                     bookingsource: j.booking_source,
                                     bookingsourcekey: j.booking_source_key,
                                     key: "oneway",
                                     text: j.selectedResult ?? "",
                                     buttonTitle: j.aPICurrencyType ?? "",
                                     data: similarFlights1,
                                     moreData: j.flight_details?.summary ?? [],
                                     cellType:.NewFlightSearchResultTVCell))
            
            
        }
        
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        if list.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            //     self.hiddenView.isHidden = true
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
    
    
    
    
    //MARK: - multicityFilterdList
    
    func multicityFilterdList(list:[[MCJ_flight_list]]) {
        commonTableView.backgroundColor = .AppHolderViewColor
        tablerow.removeAll()
        var updatedUniqueList: [[MCJ_flight_list]] = []
        updatedUniqueList = getUniqueElements_multicity(inputArray: list)
        
        if list.count == 0 {
            tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        } else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            tablerow.removeAll()
            
            updatedUniqueList.forEach({ i in
                i.forEach { j in
                    let similarFlights1 = similar_multicity(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)
                    
                    // Append the current flight and its similar flights to tablerow
                    var row: [TableRow] = []
                    row.append(TableRow(title:"\(j.price?.api_total_display_fare_withoutmarkup ?? 0.0)",
                                        subTitle: j.fareType ?? "",
                                        price: "\(j.price?.api_total_display_fare ?? 0.0)",
                                        //                                        bookingsource: j.booking_source,
                                        //                                        bookingsourcekey: j.booking_source_key,
                                        key: "oneway",
                                        text: j.selectedResult ?? "",
                                        buttonTitle: j.aPICurrencyType ?? "",
                                        data: similarFlights1,
                                        moreData: j.flight_details?.summary ?? [],
                                        cellType:.NewFlightSearchResultTVCell))
                    
                    
                    
                    // Append the row to tablerow
                    tablerow.append(contentsOf: row)
                }
            })
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
    }
    
    
    
    
    func multicityFilterdList1(list:[MCJ_flight_list]) {
        commonTableView.backgroundColor = .AppHolderViewColor
        tablerow.removeAll()
        
        
        
        list.forEach { j in
            let similarFlights1 = similar(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)
            
            tablerow.append(TableRow(title:"\(j.price?.api_total_display_fare_withoutmarkup ?? 0.0)",
                                     subTitle: j.fareType ?? "",
                                     price: "\(j.price?.api_total_display_fare ?? 0.0)",
                                     //                                     bookingsource: j.booking_source,
                                     //                                     bookingsourcekey: j.booking_source_key,
                                     key: "oneway",
                                     text: j.selectedResult ?? "",
                                     buttonTitle: j.aPICurrencyType ?? "",
                                     data: similarFlights1,
                                     moreData: j.flight_details?.summary ?? [],
                                     cellType:.NewFlightSearchResultTVCell))
            
            
        }
        
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        if list.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            //     self.hiddenView.isHidden = true
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
}

extension SearchResultPageViewController {
    
    func similar(fare: Double) -> [[J_flight_list]] {
        // Create a dictionary to group flights with the same api_total_display_fare
        var similarFlightsDictionary: [Double: [[J_flight_list]]] = [:]
        
        // Iterate through the FlightList (ensure that FlightList contains the correct data)
        FlightList?.forEach { flightArray in
            flightArray.forEach { flight in
                if let flightFare = Double(String(format: "%.2f", flight.price?.api_total_display_fare ?? "")) {
                    // Check if the fare is already present in the dictionary
                    if let existingFlights = similarFlightsDictionary[flightFare] {
                        // If it exists, append the current flight to the existing array
                        var updatedFlights = existingFlights
                        updatedFlights.append([flight])
                        similarFlightsDictionary[flightFare] = updatedFlights
                    } else {
                        // If it doesn't exist, create a new array with the current flight
                        similarFlightsDictionary[flightFare] = [[flight]]
                    }
                }
            }
        }
        
        // To access the flights with a specific fare, you can do something like this:
        if let flightsWithFare = similarFlightsDictionary[fare] {
            // flightsWithFare will contain an array of flights with api_total_display_fare equal to the specified fare
            return flightsWithFare
        } else {
            // If no similar flights found for the specified fare, return an empty array
            return []
        }
    }
    
    
    
    //MARK: - similar_multicity  MCJ_flight_list
    func similar_multicity(fare:Double) -> [[MCJ_flight_list]] {
        // Create a dictionary to group flights with the same api_total_display_fare
        var similarFlightsDictionary: [Double: [[MCJ_flight_list]]] = [:]
        
        // Iterate through the FlightList (ensure that FlightList contains the correct data)
        MCJflightlist?.forEach { flightArray in
            flightArray.forEach { flight in
                if let flightFare = Double(String(format: "%.2f", flight.price?.api_total_display_fare ?? "")) {
                    // Check if the fare is already present in the dictionary
                    if let existingFlights = similarFlightsDictionary[flightFare] {
                        // If it exists, append the current flight to the existing array
                        var updatedFlights = existingFlights
                        updatedFlights.append([flight])
                        similarFlightsDictionary[flightFare] = updatedFlights
                    } else {
                        // If it doesn't exist, create a new array with the current flight
                        similarFlightsDictionary[flightFare] = [[flight]]
                    }
                }
            }
        }
        
        // To access the flights with a specific fare, you can do something like this:
        if let flightsWithFare = similarFlightsDictionary[fare] {
            // flightsWithFare will contain an array of flights with api_total_display_fare equal to the specified fare
            return flightsWithFare
        } else {
            // If no similar flights found for the specified fare, return an empty array
            return []
        }
    }
    
    
    
    
    
    //MARK: - Function to get unique elements based on totalPrice oneway
    func getUniqueElements_oneway(inputArray: [[J_flight_list]]) -> [[J_flight_list]] {
        var uniqueElements: [[J_flight_list]] = []
        var uniquePrices: Set<String> = []
        
        for array in inputArray {
            var uniqueArray: [J_flight_list] = []
            for item in array {
                if !uniquePrices.contains("\(item.price?.api_total_display_fare ?? 0.0)") {
                    uniquePrices.insert("\(item.price?.api_total_display_fare ?? 0.0)")
                    uniqueArray.append(item)
                }
            }
            if !uniqueArray.isEmpty {
                uniqueElements.append(uniqueArray)
            }
        }
        
        return uniqueElements
    }
    
    
    
    
    
    //MARK: - Function to get unique elements based on totalPrice oneway
    func getUniqueElements_multicity(inputArray: [[MCJ_flight_list]]) -> [[MCJ_flight_list]] {
        var uniqueElements: [[MCJ_flight_list]] = []
        var uniquePrices: Set<String> = []
        
        for array in inputArray {
            var uniqueArray: [MCJ_flight_list] = []
            for item in array {
                if !uniquePrices.contains("\(item.price?.api_total_display_fare ?? 0.0)") {
                    uniquePrices.insert("\(item.price?.api_total_display_fare ?? 0.0)")
                    uniqueArray.append(item)
                }
            }
            if !uniqueArray.isEmpty {
                uniqueElements.append(uniqueArray)
            }
        }
        
        return uniqueElements
    }
    
    
    
    //MARK: - APPEND PRICE AND DATE
    func appendPriceAndDate() {
        
        kwdPriceArray.removeAll()
        dateArray.removeAll()
        AirlinesArray.removeAll()
        ConnectingFlightsArray.removeAll()
        ConnectingAirportsArray.removeAll()
        prices.removeAll()
        luggageArray.removeAll()
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "multicity" {
                MCJflightlist.map { i in
                    
                    i.map { j in
                        
                        j.map { k in
                            faretypeArray.append(k.fareType ?? "")
                            k.flight_details?.summary.map({ l in
                                
                                prices.append("\(k.price?.api_total_display_fare ?? 0.0)")
                                
                                l.map { m in
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd MMM yyyy"
                                    if let date = dateFormatter.date(from: "\(m.origin?.date ?? "")"){
                                        dateFormatter.dateFormat = "dd MMM"
                                        let resultString = dateFormatter.string(from: date)
                                        dateArray.append(dateFormatter.string(from: date))
                                    }
                                    
                                    AirlinesArray.append(m.operator_name ?? "")
                                    ConnectingFlightsArray.append(m.operator_name ?? "")
                                    ConnectingAirportsArray.append(m.destination?.airport_name ?? "")
                                    luggageArray.append(convertToDesiredFormat(m.weight_Allowance ?? ""))
                                }
                            })
                        }
                    }
                }
            }else {
                FlightList.map { i in
                    i.map { j in
                        
                        j.map { k in
                            k.flight_details?.summary.map({ l in
                                
                                l.map { m in
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd MMM yyyy"
                                    if let date = dateFormatter.date(from: "\(m.origin?.date ?? "")"){
                                        dateFormatter.dateFormat = "dd MMM"
                                        _ = dateFormatter.string(from: date)
                                        dateArray.append(dateFormatter.string(from: date))
                                    }
                                    
                                    faretypeArray.append(k.fareType ?? "")
                                    prices.append("\(k.price?.api_total_display_fare ?? 0.0)")
                                    AirlinesArray.append(m.operator_name ?? "")
                                    
                                    if m.weight_Allowance != nil || m.weight_Allowance?.isEmpty == false {
                                        luggageArray.append(convertToDesiredFormat(m.weight_Allowance ?? ""))
                                    }
                                    
                                    
                                    //                                    ConnectingFlightsArray.append(m.operator_name ?? "")
                                    //                                    ConnectingAirportsArray.append(m.destination?.airport_name ?? "")
                                    
                                    
                                }
                            })
                            
                            k.flight_details?.details?.forEach({ a in
                                a.forEach { b in
                                    ConnectingFlightsArray.append(b.operator_name ?? "")
                                    ConnectingAirportsArray.append(b.destination?.airport_name ?? "")
                                }
                            })
                            
                            
                            
                        }
                        
                        
                    }
                }
            }
        }
        
        faretypeArray = faretypeArray.unique()
        dateArray = dateArray.unique()
        AirlinesArray = AirlinesArray.unique()
        ConnectingFlightsArray = ConnectingFlightsArray.unique()
        ConnectingAirportsArray = ConnectingAirportsArray.unique()
        prices = prices.unique()
        luggageArray = luggageArray.unique()
        
    }
}

extension SearchResultPageViewController {
    func flightList(response: FlightSearchModel) {
        
        if response.status == 1 {
            
            
            
            self.holderView.isHidden = false
            loderBool = false
            
            oldjournyType = response.data?.search_params?.trip_type ?? ""
            //   chatBtnView.isHidden = false
            holderView.backgroundColor = .AppHolderViewColor
            FlightList = response.data?.j_flight_list
            defaults.set(response.data?.search_id, forKey: UserDefaultsKeys.searchid)
            defaults.set(response.data?.traceId, forKey: UserDefaultsKeys.traceId)
            
            
            //                    setuplabels(lbl: navView.lbl1, text: "\(defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "")(\(response.data?.search_params?.from_loc ?? "")) - \(defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "")(\(response.data?.search_params?.to_loc ?? ""))", textcolor: .WhiteColor, font: UIFont.latoSemiBold(size: 18), align: .center)
            //
            //
            //                    setuplabels(lbl: datelbl, text: response.data?.search_params?.depature ?? "", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
            //
            //
            //                    setuplabels(lbl: cityCodelbl, text: "\(response.data?.search_params?.from_loc ?? "")-\(response.data?.search_params?.to_loc ?? "")", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
            //
            //                    setuplabels(lbl: navView.lbl2, text: "On \(convertDateFormat(inputDate: "\(response.data?.search_params?.depature ?? "")", f1: "dd-MM-yyyy", f2: "dd MMM")) \n \(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .center)
            
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "circle" {
                    returnDatalbl.isHidden = false
                    
                    //                            setuplabels(lbl: navView.lbl1, text: "\(defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "")", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .center)
                    //
                    //
                    //                            setuplabels(lbl: datelbl, text: response.data?.search_params?.depature ?? "", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
                    //
                    //                            setuplabels(lbl: returnDatalbl, text: response.data?.search_params?.freturn ?? "", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
                    //
                    //
                    //                            setuplabels(lbl: cityCodelbl, text: "\(response.data?.search_params?.from_loc ?? "")-\(response.data?.search_params?.to_loc ?? "")", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
                    //
                    //                            setuplabels(lbl: navView.lbl2, text: "On \(convertDateFormat(inputDate: "\(response.data?.search_params?.depature ?? "")", f1: "dd-MM-yyyy", f2: "dd MMM")) & Return \(convertDateFormat(inputDate: "\(response.data?.search_params?.freturn ?? "")", f1: "dd-MM-yyyy", f2: "dd MMM")) \n \(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .center)
                    
                }
            }
            
            DispatchQueue.main.async {[self] in
                setupTV()
                appendPriceAndDate()
            }
        } else {
            guard let vc = NoInternetConnectionVC.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            vc.key = "noresult"
            self.present(vc, animated: true)
        }
    }
    
    
    func multiTripflightList(response: MulticityModel) {
        
        
        //        if response.status == 1 {
        //
        //            self.holderView.isHidden = false
        //            loderBool = false
        //
        //            oldjournyType = response.data?.search_params?.trip_type ?? "''"
        //            MCJflightlist = response.data?.j_flight_list
        //            defaults.set(response.data?.search_id, forKey: UserDefaultsKeys.searchid)
        //            defaults.set(response.data?.booking_source, forKey: UserDefaultsKeys.bookingsource)
        //            defaults.set(response.data?.booking_source_key, forKey: UserDefaultsKeys.bookingsourcekey)
        //            defaults.set(response.data?.traceId, forKey: UserDefaultsKeys.traceId)
        //
        //
        //
        //
        //            setuplabels(lbl: navView.lbl1, text: response.data?.search_params?.from_loc?.joined(separator: "-") ?? "", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .center)
        //            setuplabels(lbl: navView.lbl2, text: response.data?.search_params?.depature?.joined(separator: ",") ?? "", textcolor: .WhiteColor, font: UIFont.latoRegular(size: 14), align: .center)
        //            setuplabels(lbl: datelbl, text: response.data?.search_params?.depature?[0] ?? "", textcolor: .AppLabelColor, font: UIFont.latoRegular(size: 14), align: .center)
        //            setuplabels(lbl: cityCodelbl, text: "\(response.data?.search_params?.from_loc?[0] ?? "") - \(response.data?.search_params?.from_loc?[1] ?? "")", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        //
        //
        //
        //            DispatchQueue.main.async {[self] in
        //                setInputs()
        //                appendPriceAndDate()
        //            }
        //
        //        }else {
        //
        //            guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        //            vc.modalPresentationStyle = .overCurrentContext
        //            vc.key = "noresult"
        //            self.present(vc, animated: true)
        //        }
        //
        //    }
    }
    
}
extension SearchResultPageViewController {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        
    }
    
    
    @objc func reloadTV() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func reload() {
        
        DispatchQueue.main.async {[self] in
            callAPI()
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
    
}

extension SearchResultPageViewController {

}
