//
//  BookingDetailsViewController.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23.
//

import UIKit

class BookingDetailsViewController: BaseTableVC {
   
    @IBOutlet weak var backButtonView: UIView!
    var tablerow = [TableRow]()
    var viewmodel: DefaultBookingDetailsViewModel?
    
    static var newInstance: BookingDetailsViewController? {
        let storyboard = UIStoryboard(name: Storyboard.BookingDetails.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingDetailsViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        viewmodel = DefaultBookingDetailsViewModel()
        commonTableView.registerTVCells(["BookingDetailsCardTVCellTableViewCell",
                                         "EmptyTVCell", "RegisterSelectionLoginTableViewCell", "GuestRegisterTableViewCell", "RegisterNowTableViewCell", "LoginDetailsTableViewCell"])
        setupFilterTVCells()
    }
    
    
    func setupFilterTVCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .BookingDetailsCardTVCellTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
        tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .GuestRegisterTableViewCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupRegisterNowTvCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        tablerow.append(TableRow(cellType: .BookingDetailsCardTVCellTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
        tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
        tablerow.append(TableRow(key: "register",cellType: .RegisterNowTableViewCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupLoginTvCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        tablerow.append(TableRow(cellType: .BookingDetailsCardTVCellTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
        tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .LoginDetailsTableViewCell))
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
}



