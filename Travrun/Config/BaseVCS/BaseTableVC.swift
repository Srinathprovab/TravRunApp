//
//  BaseTableVC.swift
//  Clique
//
//  Created by Codebele-03 on 03/06/21.
//

import UIKit

class BaseTableVC: UIViewController, ButtonTVCellDelegate, OneWayTableViewCellDelegate, NewFlightSearchResultTVCellDelegate, FlightSearchButtonTableViewCellDelegate {
    
    @IBOutlet weak var commonScrollView: UITableView!
    @IBOutlet weak var commonTableView: UITableView!
    
    
    @IBOutlet weak var commonTVTopConstraint: NSLayoutConstraint!
    
    
    var commonTVData = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationCapturesStatusBarAppearance = true
        self.navigationController?.navigationBar.isHidden = true
        configureTableView()
        //        self.automaticallyAdjustsScrollViewInsets = false
        
        // Do any additional setup after loading the view.
    }
    
    
    func configureTableView() {
        if commonTableView != nil {
            makeDefaultConfigurationForTable(tableView: commonTableView)
        } else {
            print("commonTableView is nil")
        }
    }
    
    func makeDefaultConfigurationForTable(tableView: UITableView) {
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
    }
    
    func serviceCall_Completed_ForNoDataLabel(noDataMessage: String? = nil, data: [Any]? = nil, centerVal:CGFloat? = nil, color: UIColor = HexColor("#182541")) {
        dealWithNoDataLabel(message: noDataMessage, data: data, centerVal: centerVal ?? 2.0, color: color)
    }
    
    func dealWithNoDataLabel(message: String?, data: [Any]?, centerVal: CGFloat = 2.0, color: UIColor = HexColor("#182541")) {
        if commonTableView == nil { return; }
        
        commonTableView.viewWithTag(100)?.removeFromSuperview()
        
        if let message = message, let data = data {
            if data.count == 0 {
                let tableSize = commonTableView.frame.size
                
                let label = UILabel(frame: CGRect(x: 15, y: 15, width: tableSize.width, height: 60))
                label.center = CGPoint(x: (tableSize.width/2), y: (tableSize.height/centerVal))
                label.tag = 100
                label.numberOfLines = 0
                
                label.textAlignment = NSTextAlignment.center
                //                label.font = UIFont.CircularStdMedium(size: 14)
                label.textColor = color
                label.text = message
                
                commonTableView.addSubview(label)
            }
        }
        
    }
    
    
    //Delegate Methods
    func didTapOnflightDetailsButton(cell: NewFlightSearchResultTVCell) {}
    func didTapOnCloseReturnView(cell: OneWayTableViewCell) {}
    func didTapOnReturnToOnewayBtnAction(cell: OneWayTableViewCell) {}
    func didTapOnAddReturnFlight(cell: OneWayTableViewCell) {}
    func didTapOnflightSearchBtnAction(cell: FlightSearchButtonTableViewCell) {}
    func btnAction(cell: ButtonTVCell) {}
    func didTapOnDualBtn1(cell: ButtonTVCell) {}
    func didTapOnDualBtn2(cell: ButtonTVCell) {}
    func didTapOnFlightDetailsBtnAction(cell: NewFlightSearchResultTVCell) {}
    func didTapOnBookNowBtnAction(cell: NewFlightSearchResultTVCell) {}
    func didTapOnAddReturnFlightBtnAction(cell: NewFlightSearchResultTVCell) {}
    func didTapOnMoreSimilarBtnAction(cell: NewFlightSearchResultTVCell) {}
    func didTapOnAdvanedSearchOptions(cell: OneWayTableViewCell) {}
    func didTapOnButton(cell: ButtonTVCell) {}
    func editingChanged(tf: UITextField) {}
    func didTapOnDepartureBtnAction(cell: OneWayTableViewCell) {}
    func didTapOnReturnBtnAction(cell: OneWayTableViewCell) {}
    func editingTextField(tf: UITextField) {}
}

extension BaseTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = commonTVData[indexPath.row].height
        
        if let height = height {
            return height
        }
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
extension BaseTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == commonTableView {
            return commonTVData.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell: TableViewCell!
        
        var data: TableRow?
        var commonTV = UITableView()
        
        if tableView == commonTableView {
            data = commonTVData[indexPath.row]
            commonTV = commonTableView
        }
        
        
        if let cellType = data?.cellType {
            switch cellType {

                // homme page TVCells
            case .SpecialDealsTVCell:
                let cell: SpecialDealsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell


            case .TopCityTVCell:
                let cell: TopCityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell

            case .EmptyTVCell:
                let cell: EmptyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell

            case .TextfieldTVCell:
                let cell: EmptyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell

            case .ButtonTVCell:
                let cell: ButtonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
            
            case .SideMenuTitleTVCell:
                let cell: SideMenuTitleTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell

            case .MenuBGTVCell:
                let cell: MenuBGTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .QuickLinkTableViewCell:
                let cell: QuickLinkTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .holidayTableViewCell:
                let cell: holidayTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .SelectLanguageTVCell:
                let cell: SelectLanguageTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .OneWayTableViewCell:
                let cell: OneWayTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .NewFlightSearchResultTVCell:
                let cell: NewFlightSearchResultTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .FlightSearchButtonTableViewCell:
                let cell:  FlightSearchButtonTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .FlightInfoTableViewCell:
                let cell:  FlightInfoTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .FareBreakDownTableViewCell:
                let cell:  FareBreakDownTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .totalDiscountTVCell:
                let cell:  totalDiscountTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .FareRulesTableViewCell:
                let cell:  FareRulesTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .BaggageInfoTableViewCell:
                let cell:  BaggageInfoTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .ContactUsLabelTVCell:
                let cell:  ContactUsLabelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .HeaderTableViewCell:
                let cell:  HeaderTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .HeaderSubHeaderTVCellTableViewCell:
                let cell:  HeaderSubHeaderTVCellTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .BCFlightInfoTVCell:
                let cell:  BCFlightInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .PassangerDetailsTableViewCell:
                let cell:  PassangerDetailsTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .ImportentInfoTableViewCell:
                let cell:  ImportentInfoTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .TermsAndConditionTableViewCell:
                let cell: TermsAndConditionTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .SortTableViewCell:
                let cell: SortTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            default:
                print("handle this case in getCurrentCellAt")
            }
        }
        
        commonCell.cellInfo = data
        commonCell.indexPath = indexPath
        commonCell.selectionStyle = .none
        
        return commonCell
    }
} 



extension UITableView {
    func registerTVCells(_ classNames: [String]) {
        for className in classNames {
            register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        }
    }
    
    func dequeTVCell<T: UITableViewCell>(indexPath: IndexPath, osVersion: String? = nil) -> T {
        let className = String(describing: T.self) + "\(osVersion ?? "")"
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    func dequeTVCellForFooter<T: UITableViewCell>() -> T {
        let className = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: className) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    func isLast(for indexPath: IndexPath) -> Bool {
        
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
    
    
}
