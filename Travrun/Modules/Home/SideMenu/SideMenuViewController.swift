//
//  SideMenuViewController.swift
//  Travrun
//
//  Created by MA1882 on 15/11/23.
//

import UIKit

class SideMenuViewController: BaseTableVC {
    static var newInstance: SideMenuViewController? {
        let storyboard = UIStoryboard(name: Storyboard.DashBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuViewController
        return vc
    }
    
    var tablerow = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupMenuTVCells()
        commonTableView.isScrollEnabled = true
        commonTableView.registerTVCells(["MenuBGTVCell",
                                         "QuickLinkTableViewCell",
                                         "SideMenuTitleTVCell",
                                         "EmptyTVCell"])
    }
    
    func setupMenuTVCells() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType: .MenuBGTVCell))
        tablerow.append(TableRow(height: 20,cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Services",key: "links", image: "",height: 280, cellType: .QuickLinkTableViewCell))
        tablerow.append(TableRow(height: 10, bgColor: HexColor("#FFFFFF") , cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Services",key: "bookings", image: "",height: 170, cellType: .QuickLinkTableViewCell))
        tablerow.append(TableRow(height: 80, cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Logout",key: "logout", image: "IonLogOut",cellType:.SideMenuTitleTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
}
