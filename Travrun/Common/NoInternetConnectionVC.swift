//
//  noInternetConnectionVC.swift
//  BabSafar
//
//  Created by MA673 on 08/08/22.
//

import UIKit

class NoInternetConnectionVC: UIViewController {
    
    
    @IBOutlet weak var wifiImg: UIImageView!
    @IBOutlet weak var closeImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var btnlbl: UILabel!
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    
    var key = String()
    static var newInstance: NoInternetConnectionVC? {
        let storyboard = UIStoryboard(name: Storyboard.DashBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? NoInternetConnectionVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if key == "noresult" {
            noresultSetup()
        } else {
            setupUI()
        }
    }
    
    func noresultSetup(){
        wifiImg.image = UIImage(named: "oops")
        setupLabels(lbl: titlelbl, text: "No Results Found", textcolor: .AppLabelColor, font: .latoMedium(size: 18))
        setupLabels(lbl: subTitlelbl, text: "Please Search Again", textcolor: .AppLabelColor, font: .latoRegular(size: 14))
        setupLabels(lbl: btnlbl, text: "Search Again", textcolor: .WhiteColor, font: .latoSemiBold(size: 20))
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        wifiImg.image = UIImage(named: "wifi")
        closeImg.image = UIImage(named: "close1")
        
        setupLabels(lbl: titlelbl, text: "No Internet Connection", textcolor: .AppLabelColor, font: .latoMedium(size: 18))
        setupLabels(lbl: subTitlelbl, text: "Please Check Your Internet Connection", textcolor: .AppLabelColor, font: .latoRegular(size: 14))
        setupLabels(lbl: btnlbl, text: "Try Again", textcolor: .WhiteColor, font: .latoSemiBold(size: 20))
        tryAgainBtn.setTitle("", for: .normal)
        setupViews(v: btnView, radius: 4, color: .AppBtnColor)
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func didTapOnTryAgainBtn(_ sender: Any) {
        if key == "noresult" {
            let tabselect = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected)
            if tabselect == "Flights" {
                guard let vc = FlightViewController.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                vc.isfromVc = "NoInternetConnectionVC"
                self.present(vc, animated: true)
            }
//            }else if tabselect == "Insurence"{
//                guard let vc = InsuranceVC.newInstance.self else {return}
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true)
//            }else if tabselect == "Fasttrack"{
//                guard let vc = SearchFastTrackVC.newInstance.self else {return}
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true)
//            }
            else {
                guard let vc = SearchHotelsVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            
            
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("reloadTV"), object: nil)
            dismiss(animated: false)
        }
    }
    
}
