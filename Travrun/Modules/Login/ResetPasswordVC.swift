//
//  ResetPasswordVC.swift
//  BabSafar
//
//  Created by MA673 on 28/07/22.
//

import UIKit

class ResetPasswordVC: BaseTableVC, ForgetPasswordViewModelDelegate {
    

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var nav: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    var tablerow = [TableRow]()
    var email = String()
    var mobile = String()
    static var newInstance: ResetPasswordVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ResetPasswordVC
        return vc
    }
    
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
        viewmodel = ForgetPasswordViewModel(self)
    }
    
    
    func setupUI() {
        commonTableView.isHidden = false
        popUpView.isHidden = true
        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        commonTableView.registerTVCells(["LabelTVCell","TextfieldTVCell","ButtonTVCell"])
        setuptv()
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"Enter the Email adress or Id associated with your account and we’ll send an email with instructions to reset your password.",key: "cpwd",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Email Id*",key: "email", text: "1", tempText: "Email Id",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Mobile Number*",key: "email", text: "12", tempText: "Mobile Number",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(title:"Send",key: "Send", cellType: .ButtonTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    override func editingTextField(tf: UITextField) {
        switch tf.tag {
        case 1:
            email = tf.text ?? ""
            break
            
        case 12:
            mobile = tf.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    override func btnAction(cell: ButtonTVCell) {
        
        if self.email == "" {
            showToast(message: "Enter Email")
        }else if self.email.isValidEmail() == false {
            showToast(message: "Enter Valid Email ID")
        }else if self.mobile == "" {
            showToast(message: "Enter Mobile Number")
        }else if self.mobile.isValidMobileNumber() == false {
            showToast(message: "Enter Valid Mobile Number")
        } else {
            callResetPasswordAPI()
        }
    }
    
    var payload = [String:Any]()
    var viewmodel:ForgetPasswordViewModel?
    func callResetPasswordAPI() {
        payload["email"] = email
        payload["phone"] = mobile
        viewmodel?.CallForgetPasswordAPI(dictParam: payload)
    }
    
    
    func forgetPasswordSucessDetails(response: ForgetPasswordModel) {
        
        let seconds = 2.0
        if response.status == false {
            showToast(message: response.data ?? "")
        } else {
            showToast(message: response.data ?? "")
            commonTableView.isHidden = true
            popUpView.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            
        }
    }
    
    func gotoCreateNewPasswordVC() {
//        guard let vc = CreateNewPasswordVC.newInstance.self else {return}
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
    }
}
