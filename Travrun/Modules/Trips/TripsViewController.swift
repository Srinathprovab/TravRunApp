//
//  TripsViewController.swift
//  Travrun
//
//  Created by Mahesh on 09/11/23.
//

import UIKit

class TripsViewController: BaseTableVC {

    @IBOutlet weak var payImage: UIImageView!
    @IBOutlet weak var visaImage: UIImageView!
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var flightIconImage: UIImageView!
    @IBOutlet weak var cancelledLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var upcomingLabel: UILabel!
    @IBOutlet weak var cancelledView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var visaLabel: UILabel!
    @IBOutlet weak var hotleLabel: UILabel!
    @IBOutlet weak var flightLabel: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var fightButton: UIButton!
    @IBOutlet weak var fightView: UIView!
    @IBOutlet weak var hotelButton: UIButton!
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var visaButton: UIButton!
    @IBOutlet weak var visaView: UIView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var payView: UIView!
    
    var tablerow = [TableRow]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        commonTableView.registerTVCells(["BookingDetailsCardTVCellTableViewCell"])
    }
    
    func setUpUI() {
        bannerImage.image = UIImage(named: "flightBanner")
        upcomingLabel.textColor = HexColor("FFFFFF")
        visaImage.image = UIImage(named: "visaIcon")
        payImage.image = UIImage(named: "payIcon")
        hotelImage.image = UIImage(named: "hotelIcon")
        flightIconImage.image = UIImage(named: "flightIcon")
        fightView.layer.borderColor = HexColor("#D4D4D4").cgColor
        fightView.layer.borderWidth = 1
        visaView.layer.borderWidth = 1
        visaView.layer.borderColor = HexColor("#D4D4D4").cgColor
        hotelView.layer.borderWidth = 1
        hotelView.layer.borderColor = HexColor("#D4D4D4").cgColor
        payView.layer.borderWidth = 1
        payView.layer.borderColor = HexColor("#D4D4D4").cgColor
        fightView.layer.borderWidth = 1
        payView.layer.cornerRadius = 6
        visaView.layer.cornerRadius = 6
        fightView.layer.cornerRadius = 6
        hotelView.layer.cornerRadius = 6
        setupTVCells()
    }
    
    @IBAction func flightButtonAction(_ sender: Any) {
        fightView.backgroundColor = .AppBtnColor
        flightLabel.textColor = UIColor.white
        visaLabel.textColor = HexColor("#3C627A")
        payLabel.textColor = HexColor("#3C627A")
        hotleLabel.textColor = HexColor("#3C627A")
        fightView.layer.borderColor = UIColor.clear.cgColor
        hotelView.layer.borderColor = HexColor("#D4D4D4").cgColor
        visaView.layer.borderColor = HexColor("#D4D4D4").cgColor
        payView.layer.borderColor = HexColor("#D4D4D4").cgColor
        hotelView.backgroundColor = UIColor.white
        visaView.backgroundColor = UIColor.white
        payView.backgroundColor = UIColor.white
        bannerImage.image = UIImage(named: "flightBanner")
        flightIconImage.image = UIImage(named: "flightIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        visaImage.image = UIImage(named: "visaIcon")
        payImage.image = UIImage(named: "payIcon")
        hotelImage.image = UIImage(named: "hotelIcon")
    }
    @IBAction func hotelButtonAction(_ sender: Any) {
        fightView.backgroundColor = UIColor.white
        hotelView.backgroundColor = .AppBtnColor
        visaView.backgroundColor = UIColor.white
        payView.backgroundColor = UIColor.white
        hotelView.layer.borderColor = UIColor.clear.cgColor
        fightView.layer.borderColor = HexColor("#D4D4D4").cgColor
        visaView.layer.borderColor = HexColor("#D4D4D4").cgColor
        payView.layer.borderColor = HexColor("#D4D4D4").cgColor
        flightLabel.textColor = HexColor("#3C627A")
        visaLabel.textColor = HexColor("#3C627A")
        payLabel.textColor = HexColor("#3C627A")
        hotleLabel.textColor = HexColor("#FFFFFF")
        bannerImage.image = UIImage(named: "hotelBanner")
        hotelImage.image = UIImage(named: "hotelIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        visaImage.image = UIImage(named: "visaIcon")
        payImage.image = UIImage(named: "payIcon")
        flightIconImage.image = UIImage(named: "flightIcon")
    }
    @IBAction func visaButtonAction(_ sender: Any) {
        fightView.backgroundColor = UIColor.white
        hotelView.backgroundColor = UIColor.white
        visaView.backgroundColor = .AppBtnColor
        payView.backgroundColor = UIColor.white
        visaView.layer.borderColor = UIColor.clear.cgColor
        fightView.layer.borderColor = HexColor("#D4D4D4").cgColor
        hotelView.layer.borderColor = HexColor("#D4D4D4").cgColor
        payView.layer.borderColor = HexColor("#D4D4D4").cgColor
        flightLabel.textColor = HexColor("#3C627A")
        visaLabel.textColor = HexColor("#FFFFFF")
        payLabel.textColor = HexColor("#3C627A")
        hotleLabel.textColor = HexColor("#3C627A")
        bannerImage.image = UIImage(named: "hotelBanner")
        visaImage.image = UIImage(named: "visaIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        payImage.image = UIImage(named: "payIcon")
        hotelImage.image = UIImage(named: "hotelIcon")
        flightIconImage.image = UIImage(named: "flightIcon")
    }
    @IBAction func payButtonAction(_ sender: Any) {
        fightView.backgroundColor = UIColor.white
        hotelView.backgroundColor = UIColor.white
        visaView.backgroundColor = UIColor.white
        payView.backgroundColor = .AppBtnColor
        payView.layer.borderColor = UIColor.clear.cgColor
        fightView.layer.borderColor = HexColor("#D4D4D4").cgColor
        hotelView.layer.borderColor = HexColor("#D4D4D4").cgColor
        visaView.layer.borderColor = HexColor("#D4D4D4").cgColor
        flightLabel.textColor = HexColor("#3C627A")
        visaLabel.textColor = HexColor("#3C627A")
        payLabel.textColor = HexColor("#FFFFFF")
        hotleLabel.textColor = HexColor("#3C627A")
        payImage.image = UIImage(named: "payIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        visaImage.image = UIImage(named: "visaIcon")
        hotelImage.image = UIImage(named: "hotelIcon")
        flightIconImage.image = UIImage(named: "flightIcon")
    }
    
    @IBAction func upComingButtonAction(_ sender: Any) {
        upcomingLabel.textColor = HexColor("FFFFFF")
        completedLabel.textColor = HexColor("#000000")
        cancelledLabel.textColor = HexColor("#000000")
        cancelledView.backgroundColor = UIColor.clear
        upcomingView.backgroundColor = HexColor("3C627A")
        completedView.backgroundColor = UIColor.clear
      
    }
    @IBAction func completedButtonAction(_ sender: Any) {
        upcomingLabel.textColor = HexColor("000000")
        completedLabel.textColor = HexColor("FFFFFF")
        cancelledLabel.textColor = HexColor("#000000")
        cancelledView.backgroundColor = UIColor.clear
        completedView.backgroundColor = HexColor("3C627A")
        upcomingView.backgroundColor = UIColor.clear
    }
    @IBAction func cancelledButtonAction(_ sender: Any) {
        cancelledLabel.textColor = HexColor("FFFFFF")
        completedLabel.textColor = HexColor("#000000")
        upcomingLabel.textColor = HexColor("#000000")
        upcomingView.backgroundColor = UIColor.clear
        cancelledView.backgroundColor = HexColor("3C627A")
        completedView.backgroundColor = UIColor.clear
    }
    
    func setupTVCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .BookingDetailsCardTVCellTableViewCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
}
