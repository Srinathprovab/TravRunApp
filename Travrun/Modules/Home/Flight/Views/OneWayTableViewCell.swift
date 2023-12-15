//
//  OneWayTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 17/11/23.
//

import UIKit
import DropDown


protocol OneWayTableViewCellDelegate {
    func didTapOnReturnToOnewayBtnAction(cell: OneWayTableViewCell)
    func didTapOnDepartureBtnAction(cell: OneWayTableViewCell)
    func didTapOnReturnBtnAction(cell: OneWayTableViewCell)
    func didTapOnAdvanedSearchOptions(cell: OneWayTableViewCell)
    func didTapOnAddReturnFlight(cell: OneWayTableViewCell)
    func didTapOnCloseReturnView(cell: OneWayTableViewCell)
    func editingTextField(tf:UITextField)
}

class OneWayTableViewCell: TableViewCell, SelectCityViewModelProtocal {
    
    func ShowCityListMulticity(response: [SelectCityModel]) {}
    
    @IBOutlet weak var infantsPlusLabel: UILabel!
    @IBOutlet weak var childPlusLabel: UILabel!
    @IBOutlet weak var adultPlusLabel: UILabel!
    @IBOutlet weak var airlineValuelbl: UILabel!
    @IBOutlet weak var returnJournyLabel: UILabel!
    @IBOutlet weak var outwardsLabel: UILabel!
    @IBOutlet weak var toTitleLabel: UILabel!
    @IBOutlet weak var fromTitleLabel: UILabel!
    @IBOutlet weak var toSubtitleLabel: UILabel!
    @IBOutlet weak var fromSubtitleLabel: UILabel!
    @IBOutlet weak var returnDateLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var toTVHeight: NSLayoutConstraint!
    @IBOutlet weak var fromTVHeight: NSLayoutConstraint!
    @IBOutlet weak var toTV: UITableView!
    @IBOutlet weak var fromTV: UITableView!
    @IBOutlet weak var airlineTF: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var fromTextfiled: UITextField!
    @IBOutlet weak var adultPlusSymbolLabel: UILabel!
    
    @IBOutlet weak var toClassLabel: UILabel!
    @IBOutlet weak var toDropDownImage: UIImageView!
    @IBOutlet weak var toDropDownLabel: UILabel!
    @IBOutlet weak var fromDropdownLabel: UILabel!
    @IBOutlet weak var addReturnTopVIew: UIView!
    @IBOutlet weak var childPlusView: UIView!
    @IBOutlet weak var infantsPlusView: UIView!
    @IBOutlet weak var infantsMinusView: UIView!
    @IBOutlet weak var advancedUnderlineLabel: UILabel!
    @IBOutlet weak var advancedSearchLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var doubleArrowView: UIView!
    @IBOutlet weak var chekBoxImage: UIImageView!
    @IBOutlet weak var airlineView: UIView!
    @IBOutlet weak var returnJournyView: UIView!
    @IBOutlet weak var outwardsView: UIView!
    @IBOutlet weak var infantsCountView: UIView!
    @IBOutlet weak var infantsCountLabel: UILabel!
    @IBOutlet weak var infantsView: UIView!
    @IBOutlet weak var childCountLabel: UILabel!
    @IBOutlet weak var childCountView: UIView!
    @IBOutlet weak var childMinusView: UIView!
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var adultPlusView: UIView!
    @IBOutlet weak var adultCountLabel: UILabel!
    @IBOutlet weak var adultCountView: UIView!
    @IBOutlet weak var adultMinusView: UIView!
    @IBOutlet weak var adultsView: UIView!
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var departureView: UIView!
    @IBOutlet weak var toEconomyView: UIView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var fromEconomyView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var holderView: UIView!
    
    var isCheckin = Bool()
    var counts = 0
    var count = 0
    var adultsCount = 1
    var childCount = 0
    var economy = String()
    var toEco = String()
    var infantsCount = 0
    var nationalityCode = String()
    var billingCountryName = String()
    var isoCountryCode = String()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    var countrylist = [All_country_code_list]()
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [All_country_code_list]()
    let dropDown1 = DropDown()
    let fromEconomyDropdown = DropDown()
    let toEconomyDropdown = DropDown()
    var payload = [String:Any]()
    var cityViewModel: SelectCityViewModel?
    var txtbool = Bool()
    let ouwardsDropDown = DropDown()
    let returnJournyDropDown = DropDown()
    let dropDown = DropDown()
    var isAdvanceSearh = false
    var delegate: OneWayTableViewCellDelegate?
    var fromEonomy = ["Economy", "Premium Economy", "Business", "Frist"]
    var toEonomy = ["Economy", "Premium Economy", "Business", "Frist"]
    var otward = ["12:00 AM - 6:00 AM", "12:00 PM - 6:00 AM", "06:00 PM - 12:00 AM"]
    var returnJourny = ["12:00 AM - 6:00 AM", "12:00 PM - 6:00 AM", "06:00 PM - 12:00 AM"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
        bottomView.isHidden = true
        addReturnTopVIew.isHidden = false
        setupTF(txtField: airlineTF)
        cityViewModel = SelectCityViewModel(self)
        fromTextfiled.delegate = self
        toTextField.delegate = self
        //        airlineTF.delegate = self
        
        if infantsCount != 0 {
            infantsPlusLabel.textColor = .white
            infantsPlusView.backgroundColor = HexColor("#3C627A")
        } else {
            infantsPlusLabel.textColor = .AppLabelColor
            infantsPlusView.backgroundColor = .clear
        }
        
        if childCount != 0 {
            childPlusLabel.textColor = .white
            childPlusView.backgroundColor = HexColor("#3C627A")
        } else {
            childPlusLabel.textColor = .AppLabelColor
            childPlusView.backgroundColor = .clear
        }
        
        self.adultCountLabel.text = "\(adultsCount)"
        self.fromTitleLabel.textColor = UIColor.AppLabelColor
        self.toTitleLabel.textColor = UIColor.AppLabelColor
        self.fromTitleLabel.font = UIFont.InterMedium(size: 16)
        self.toTitleLabel.font = UIFont.InterMedium(size: 16)
        self.departureDateLabel.font = UIFont.InterRegular(size: 15)
        self.departureDateLabel.textColor = UIColor.lightGray
        self.returnDateLabel.font = UIFont.InterRegular(size: 15)
        self.returnDateLabel.textColor = UIColor.lightGray
        setupLabels(lbl: airlineValuelbl, text: "Airline", textcolor: HexColor("#191919"), font: .InterMedium(size: 18))
        fromTextfiled.tag = 1
        fromTextfiled.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        toTextField.tag = 2
        toTextField.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        setupDropDown()
        airlineTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        airlineTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupTV() {
        fromTV.delegate = self
        fromTV.dataSource = self
        fromTV.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        toTV.delegate = self
        toTV.dataSource = self
        toTV.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    override func updateUI() {
        
        self.isCheckin = ((cellInfo?.isEditable) != nil)
        setupTV()
        fromTVHeight.constant = 0
        toTVHeight.constant = 0
        CallShowCityListAPI(str: "")
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                economy = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? ""
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                fromSubtitleLabel.text = defaults.string(forKey: UserDefaultsKeys.fromcityCode) ?? ""
                toSubtitleLabel.text = defaults.string(forKey: UserDefaultsKeys.toCityCode) ?? ""
                fromTitleLabel.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "Origin"
                toTitleLabel.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "Destination"
                self.departureDateLabel.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Departure Date"
                self.returnDateLabel.text = defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "Return Date"
            } else {
                //                defaults.string(forKey:UserDefaultsKeys.selectClass)
                toEco = defaults.string(forKey:UserDefaultsKeys.rselectClass) ?? ""
                fromSubtitleLabel.text = defaults.string(forKey: UserDefaultsKeys.fromcityCode) ?? ""
                toSubtitleLabel.text = defaults.string(forKey: UserDefaultsKeys.toCityCode) ?? ""
                fromTitleLabel.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "Origin"
                toTitleLabel.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "Destination"
                self.departureDateLabel.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Departure Date"
                self.returnDateLabel.text = defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "Return Date"
                returnView.alpha = 1
            }
        }
        
        if cellInfo?.key == "roundTrip" {
            print("roundTrip")
            addReturnTopVIew.isHidden = true
            toClassLabel.isHidden = false
            toDropDownLabel.isHidden = false
            toDropDownImage.isHidden = false
            toEconomyView.backgroundColor = HexColor("#FFFFFF")
        } else {
            addReturnTopVIew.isHidden = false
            toClassLabel.isHidden = true
            toDropDownLabel.isHidden = true
            toDropDownImage.isHidden = true
            toEconomyView.backgroundColor = .clear
            addReturnTopVIew.backgroundColor = HexColor("#F5F5F5")
            toEconomyView.layer.borderColor = UIColor.clear.cgColor
            print("oneway")
        }
    }
    
    
    func setupfromEconomyDropDown() {
        fromEconomyDropdown.backgroundColor = HexColor("#F0F0F0")
        fromEconomyDropdown.dataSource = fromEonomy
        fromEconomyDropdown.direction = .bottom
        fromEconomyDropdown.backgroundColor = .WhiteColor
        fromEconomyDropdown.anchorView = self.fromEconomyView
        fromEconomyDropdown.bottomOffset = CGPoint(x: 0, y: self.fromEconomyView.frame.size.height + 10)
        fromEconomyDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.fromDropdownLabel.text = self?.fromEonomy[index]
        }
    }
    
    func setupToEconomyDropDown() {
        toEconomyDropdown.backgroundColor = HexColor("#F0F0F0")
        toEconomyDropdown.dataSource = toEonomy
        toEconomyDropdown.direction = .bottom
        toEconomyDropdown.backgroundColor = .WhiteColor
        toEconomyDropdown.anchorView = self.toEconomyView
        toEconomyDropdown.bottomOffset = CGPoint(x: 0, y: self.toEconomyView.frame.size.height + 10)
        toEconomyDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.toDropDownLabel.text = self?.toEonomy[index]
        }
    }
    
    func setupOutwardDropDown() {
        ouwardsDropDown.backgroundColor = HexColor("#F0F0F0")
        ouwardsDropDown.dataSource = otward
        ouwardsDropDown.direction = .bottom
        ouwardsDropDown.backgroundColor = .WhiteColor
        ouwardsDropDown.anchorView = self.outwardsView
        ouwardsDropDown.bottomOffset = CGPoint(x: 0, y: self.outwardsView.frame.size.height + 10)
        ouwardsDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.outwardsLabel.text = self?.otward[index]
            self?.outwardsLabel.font = UIFont.InterMedium(size: 12)
        }
    }
    
    func setupTimeofReturnDropDown() {
        
        returnJournyDropDown.backgroundColor = HexColor("#F0F0F0")
        returnJournyDropDown.dataSource = returnJourny
        returnJournyDropDown.direction = .bottom
        returnJournyDropDown.backgroundColor = .WhiteColor
        returnJournyDropDown.anchorView = self.returnJournyView
        returnJournyDropDown.bottomOffset = CGPoint(x: 0, y: self.returnJournyView.frame.size.height + 10)
        returnJournyDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.returnJournyLabel.text = self?.returnJourny[index]
            self?.returnJournyLabel.font = UIFont.InterMedium(size: 12)
        }
    }
    
    @IBAction func returnCancelButtonAction(_ sender: Any) {
        delegate?.didTapOnReturnToOnewayBtnAction(cell: self)
    }
    
    @IBAction func fromEconomyButtonAction(_ sender: Any) {
        fromEconomyDropdown.show()
        setupfromEconomyDropDown()
        economy = fromDropdownLabel.text ?? ""
        defaults.set(economy, forKey: UserDefaultsKeys.selectClass)
    }
    
    @IBAction func toEconomyButtonAction(_ sender: Any) {
        toEconomyDropdown.show()
        setupToEconomyDropDown()
        toEco = toDropDownLabel.text ?? ""
        //        defaults.set(economy, forKey: UserDefaultsKeys.selectClass)
        defaults.set(toEco, forKey: UserDefaultsKeys.rselectClass)
    }
    
    @IBAction func departureButtonAction(_ sender: Any) {
        delegate?.didTapOnDepartureBtnAction(cell: self)
    }
    
    @IBAction func returnButtonAction(_ sender: Any) {
        delegate?.didTapOnReturnBtnAction(cell: self)
    }
    
    @IBAction func adultsDecrementButtonAction(_ sender: Any) {
        if adultsCount > 1 {
            adultsCount -= 1
            //            self.counts -= 1
            adultCountLabel.text = "\(adultsCount)"
        }
        
        defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
    }
    
    @IBAction func childDecrementButtonAction(_ sender: Any) {
        if self.counts > 0 {
            self.counts -= 1
            childCountLabel.text = "\(self.counts)"
        }
        childCount = self.counts
        defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
    }
    
    @IBAction func childIncrementButtonAction(_ sender: Any) {
        if (adultsCount + childCount) < 9 {
            // Increment children, but don't exceed 9 travelers in total
            if  self.counts >= 0 {
                self.counts += 1
                childCountLabel.text = "\(self.counts)"
            }
            childCount = self.counts
        }
        
        defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
    }
    
    @IBAction func infantsDecrementButtonAction(_ sender: Any) {
        
        if infantsCount > 0 {
            infantsCount -= 1
            self.counts -= 1
            infantsCountLabel.text = "\(self.counts)"
        }
        
        defaults.set(infantsCount, forKey: UserDefaultsKeys.infantsCount)
    }
    
    @IBAction func infantsIncrementButtonAction(_ sender: Any) {
        
        if infantsCount < adultsCount {
            infantsCount += 1
            self.counts += 1
            infantsCountLabel.text = "\(infantsCount)"
        }
        defaults.set(infantsCount, forKey: UserDefaultsKeys.infantsCount)
    }
    
    @IBAction func toCancelButtonAction(_ sender: Any) {
        toTextField.text = ""
        toTitleLabel.text = ""
        toSubtitleLabel.text = ""
        defaults.set("", forKey: UserDefaultsKeys.toCity)
        defaults.set("", forKey: UserDefaultsKeys.toCityCode)
    }
    @IBAction func outwardsButtonAction(_ sender: Any) {
        ouwardsDropDown.show()
        setupOutwardDropDown()
    }
    
    @IBAction func returnJournyButtonAction(_ sender: Any) {
        returnJournyDropDown.show()
        setupTimeofReturnDropDown()
    }
    
    @IBAction func airlineButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func adultsIncrimentButtonAction(_ sender: Any) {
        if (adultsCount + childCount) < 9 {
            adultsCount += 1
            self.counts += 1
            adultCountLabel.text = "\(adultsCount)"
        }
        
        defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
    }
    
    @IBAction func directFlightCheckBoxAction(_ sender: Any) {
        
        if isCheckin == false {
            isCheckin = true
            chekBoxImage.image = UIImage(named: "check")
        } else {
            isCheckin = false
            chekBoxImage.image = UIImage(named: "checkBox")
        }
    }
    
    
    @IBAction func advancedSearchOptionAction(_ sender: Any) {
        delegate?.didTapOnAdvanedSearchOptions(cell: self)
    }
    
    @IBAction func addReturnFlightAction(_ sender: Any) {
        delegate?.didTapOnAddReturnFlight(cell: self)
    }
    
    
    func setupTF(txtField:UITextField) {
        txtField.delegate = self
        txtField.backgroundColor = .clear
        txtField.setLeftPaddingPoints(20)
        txtField.font = UIFont.InterMedium(size: 16)
        txtField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        txtField.isSecureTextEntry = false
    }
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    @IBAction func fromCancelButtonAction(_ sender: Any) {
        fromTextfiled.text = ""
        fromTitleLabel.text = ""
        fromSubtitleLabel.text = ""
        defaults.set("", forKey: UserDefaultsKeys.fromCity)
        defaults.set("", forKey: UserDefaultsKeys.fromcityCode)
    }
    
    
    //MARK: - Text Filed Editing Changed
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        if textField == fromTextfiled {
            txtbool = true
            self.fromSubtitleLabel.text = ""
            self.fromTitleLabel.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
        }else if textField == toTextField {
            txtbool = false
            self.toSubtitleLabel.text = ""
            self.toTitleLabel.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
        }
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fromTextfiled {
            fromSubtitleLabel.text = ""
            self.fromTitleLabel.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
            
        } else if textField == toTextField {
            toSubtitleLabel.text = ""
            self.toTitleLabel.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
            
        }
    }
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    func ShowCityList(response: [SelectCityModel]) {
        cityList = response
        print(cityList)
        if txtbool == true {
            fromTVHeight.constant = CGFloat(cityList.count * 80)
            DispatchQueue.main.async {[self] in
                fromTV.reloadData()
            }
        }else {
            toTVHeight.constant = CGFloat(cityList.count * 80)
            DispatchQueue.main.async {[self] in
                toTV.reloadData()
            }
        }
        
    }
    
    
    
}


extension OneWayTableViewCell {
    func setUpView() {
        advancedUnderlineLabel.backgroundColor = HexColor("#191919")
        
        infantsCountView.layer.cornerRadius = 6
        infantsCountView.layer.borderWidth = 1
        infantsCountView.layer.borderColor = HexColor("#CACACA").cgColor
        
        airlineView.layer.cornerRadius = 8
        airlineView.layer.borderWidth = 1
        airlineView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        returnJournyView.layer.cornerRadius = 8
        returnJournyView.layer.borderWidth = 1
        returnJournyView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        childCountView.layer.cornerRadius = 6
        childCountView.layer.borderWidth = 1
        childCountView.layer.borderColor = HexColor("#CACACA").cgColor
        
        adultCountView.layer.cornerRadius = 6
        adultCountView.layer.borderWidth = 1
        adultCountView.layer.borderColor = HexColor("#CACACA").cgColor
        
        fromView.layer.cornerRadius = 8
        fromView.layer.borderWidth = 1
        fromView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        returnView.layer.cornerRadius = 8
        returnView.layer.borderWidth = 1
        returnView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        toView.layer.cornerRadius = 8
        toView.layer.borderWidth = 1
        toView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        departureView.layer.cornerRadius = 8
        departureView.layer.borderWidth = 1
        departureView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        toEconomyView.layer.cornerRadius = 8
        toEconomyView.layer.borderWidth = 1
        toEconomyView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        fromEconomyView.layer.cornerRadius = 8
        fromEconomyView.layer.borderWidth = 1
        fromEconomyView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        adultsView.layer.cornerRadius = 8
        adultsView.layer.borderWidth = 1
        adultsView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        childView.layer.cornerRadius = 8
        childView.layer.borderWidth = 1
        childView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        infantsView.layer.cornerRadius = 8
        infantsView.layer.borderWidth = 1
        infantsView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        infantsView.layer.cornerRadius = 8
        infantsView.layer.borderWidth = 1
        infantsView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        outwardsView.layer.cornerRadius = 8
        outwardsView.layer.borderWidth = 1
        outwardsView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        doubleArrowView.layer.cornerRadius = doubleArrowView.frame.width / 2
        doubleArrowView.layer.borderWidth = 1
        doubleArrowView.layer.borderColor = HexColor("#E6E8E7").cgColor
        
        adultMinusView.layer.cornerRadius = 6
        adultMinusView.layer.borderWidth = 1
        adultMinusView.layer.borderColor = HexColor("#CACACA").cgColor
        
        adultPlusView.layer.cornerRadius = 6
        adultPlusView.layer.borderWidth = 1
        adultPlusView.layer.borderColor = HexColor("#CACACA").cgColor
        adultPlusView.backgroundColor = HexColor("#3C627A")
        adultPlusSymbolLabel.textColor = UIColor.white
        
        
        childPlusView.layer.cornerRadius = 6
        childPlusView.layer.borderWidth = 1
        childPlusView.layer.borderColor = HexColor("#CACACA").cgColor
        
        childMinusView.layer.cornerRadius = 6
        childMinusView.layer.borderWidth = 1
        childMinusView.layer.borderColor = HexColor("#CACACA").cgColor
        
        infantsPlusView.layer.cornerRadius = 6
        infantsPlusView.layer.borderWidth = 1
        infantsPlusView.layer.borderColor = HexColor("#CACACA").cgColor
        
        infantsMinusView.layer.cornerRadius = 6
        infantsMinusView.layer.borderWidth = 1
        infantsMinusView.layer.borderColor = HexColor("#CACACA").cgColor
        
        addReturnTopVIew.layer.cornerRadius = 8
        addReturnTopVIew.layer.borderWidth = 1
        addReturnTopVIew.layer.borderColor = HexColor("#E6E8E7").cgColor
    }
}


extension OneWayTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if tableView == fromTV {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FromCityTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = cityList[indexPath.row].city
                cell.subTitlelbl.text = cityList[indexPath.row].name
                cell.id = cityList[indexPath.row].id ?? ""
                cell.cityname = cityList[indexPath.row].name ?? ""
                cell.citycode = cityList[indexPath.row].code ?? ""
                ccell = cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? FromCityTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = cityList[indexPath.row].city
                cell.subTitlelbl.text = cityList[indexPath.row].name
                cell.id = cityList[indexPath.row].id ?? ""
                cell.cityname = cityList[indexPath.row].name ?? ""
                cell.citycode = cityList[indexPath.row].code ?? ""
                ccell = cell
            }
        }
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            print(cell.id)
            print(cell.citycode)
            print(cell.cityname)
            
            if tableView == fromTV {
                fromSubtitleLabel.text = cityList[indexPath.row].code ?? ""
                if  fromTextfiled.text != "" {
                    fromTitleLabel.textColor = .AppLabelColor
                    fromTitleLabel.font = .InterMedium(size: 16)
                    fromTitleLabel.text = cityList[indexPath.row].label ?? ""
                } else {
                    fromTitleLabel.textColor = .lightGray
                    fromTitleLabel.font = .InterMedium(size: 16)
                }
                
                fromTitleLabel.textColor = .AppLabelColor
                fromTextfiled.resignFirstResponder()
                
                if let selectedJType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if selectedJType == "circle" {
                        defaults.set(cityList[indexPath.row].code ?? "", forKey: UserDefaultsKeys.fromcityCode)
                        defaults.set(cityList[indexPath.row].code ?? "", forKey: UserDefaultsKeys.toCityCode)
                        defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.fromCity)
                        defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.fromlocid)
                        defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.fromairport)
                        defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.fromcityname)
                        
                    } else {
                        defaults.set(cityList[indexPath.row].code ?? "", forKey: UserDefaultsKeys.fromcityCode)
                        defaults.set(cityList[indexPath.row].code ?? "", forKey: UserDefaultsKeys.toCityCode)
                        defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.fromCity)
                        defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.fromlocid)
                        defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.fromairport)
                        defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.fromcityname)
                    }
                    
                }
                fromTVHeight.constant = 0
            } else {
                toSubtitleLabel.text = cityList[indexPath.row].code ?? ""
                toTitleLabel.text = cityList[indexPath.row].label ?? ""
                toTitleLabel.textColor = .AppLabelColor
                toTextField.text = ""
                toTextField.placeholder = ""
                toTextField.resignFirstResponder()
                
                if let selectedJType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if selectedJType == "circle" {
                        defaults.set(cityList[indexPath.row].code ?? "", forKey: UserDefaultsKeys.fromcityCode)
                        defaults.set(cityList[indexPath.row].code ?? "", forKey: UserDefaultsKeys.toCityCode)
                        defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.toCity)
                        defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.tolocid)
                        defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.toairport)
                        defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.tocityname)
                        
                    }else {
                        defaults.set(cityList[indexPath.row].code ?? "", forKey: UserDefaultsKeys.fromcityCode)
                        defaults.set(cityList[indexPath.row].code ?? "", forKey: UserDefaultsKeys.toCityCode)
                        defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.toCity)
                        defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.tolocid)
                        defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.toairport)
                        defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.tocityname)
                        
                    }
                    
                }
                toTVHeight.constant = 0
            }
        }
    }
}


extension OneWayTableViewCell {
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.airlineView
        dropDown.bottomOffset = CGPoint(x: 0, y: self.airlineView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            self?.airlineValuelbl.text = self?.countryNames[index]
            self?.airlineTF.text = ""
            self?.airlineTF.resignFirstResponder()
            self?.isoCountryCode = self?.isocountrycodeArray[index] ?? ""
            self?.billingCountryName = self?.countryNames[index] ?? ""
            self?.nationalityCode = self?.originArray[index] ?? ""
        }
    }
    
    @objc func searchTextBegin(textField: UITextField) {
        airlineTF.text = ""
        airlineValuelbl.text = ""
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
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
        
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist.filter { thing in            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        isocountrycodeArray.removeAll()
        originArray.removeAll()
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
            isocountrycodeArray.append(i.iso_country_code ?? "")
            originArray.append(i.origin ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = countryNames
        }
    }
}
