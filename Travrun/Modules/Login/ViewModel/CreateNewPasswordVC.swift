//
//  CreateNewPasswordVC.swift
//  BabSafar
//
//  Created by MA673 on 27/07/22.
//

import UIKit

class CreateNewPasswordVC: BaseTableVC {
    
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: UIView!
    
    var tablerow = [TableRow]()
    static var newInstance: CreateNewPasswordVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CreateNewPasswordVC
        return vc
    }
    
    var oldpass = String()
    var newPass = String()
    var confPass = String()
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        callApi()
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        callApi()
    }
    
    
    //MARK: - callApi
    func callApi() {
        commonTableView.reloadData()
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        commonTableView.registerTVCells(["LabelTVCell","TextfieldTVCell","ButtonTVCell"])
        setuptv()
    }
    
    func setuptv() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"enter the email associated with your account and we’ll send an email with instructions to reset your password.",key: "cpwd",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Old Password",key: "cpwd", text: "1", tempText: "Old Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"New password",key: "cpwd", text: "2", tempText: "New password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Confirm password",key: "cpwd", text: "3", tempText: "Confirm password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Reset  ",cellType:.ButtonTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func editingTextField(tf: UITextField) {
        switch tf.tag {
        case 1:
            oldpass = tf.text ?? ""
            break
        case 2:
            newPass = tf.text ?? ""
            break
        case 3:
            confPass = tf.text ?? ""
            break
        default:
            break
        }
    }
    
    override func btnAction(cell: ButtonTVCell) {
        if oldpass == "" {
            showToast(message: "Enter Old Password")
        }else if newPass == "" {
            showToast(message: "Enter New Password")
        }else if confPass == "" {
            showToast(message: "Enter Conform Password")
        }else if newPass != confPass {
            showToast(message: "Password Did Not Match")
        }else {
            print("Call API.....")
            
            guard let vc = DashBoardTabBarViewController.newInstance.self else {return}
            vc.selectedIndex = 0
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
