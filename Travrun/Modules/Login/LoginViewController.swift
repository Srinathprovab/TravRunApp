//
//  LoginViewController.swift
//  Travrun
//
//  Created by MA1882 on 05/12/23.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, RegisterViewModelProtocal {
   
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwodTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    static var newInstance: LoginViewController? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoginViewController
        return vc
    }
    
    var tablerow = [TableRow]()
    var loginKey = "login"
    var fname = ""
    var lname = ""
    var email = ""
    var mobile = ""
    var pass = ""
    var cpass = ""
    var showPwdBool = true
    var payload = [String:Any]()
    var regViewModel: RegisterViewModel?
    var uname = String()
    var password = String()
    var isVcFrom = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regViewModel = RegisterViewModel(self)
        setiupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    func setiupUI()  {
        holderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        holderView.layer.cornerRadius = 30
        holderView.clipsToBounds = true
        passwodTextField.placeholder = "Enter Password"
        emailTextField.placeholder = "Enter Email Adress"
        passwodTextField.setLeftPaddingPoints(16)
        emailTextField.setLeftPaddingPoints(16)
        passwodTextField.layer.cornerRadius = 4
        passwodTextField.layer.borderColor = HexColor("#CCCCCC").cgColor
        emailTextField.layer.borderColor = HexColor("#CCCCCC").cgColor
        emailTextField.layer.cornerRadius = 4
        loginButton.layer.cornerRadius = 4
        emailTextField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        passwodTextField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        
    }
    
    @IBAction func registerNowAction(_ sender: Any) {
        guard let vc = RegisterViewController.newInstance.self else {return}
       vc.modalPresentationStyle = .fullScreen
       present(vc, animated: true)
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        callLoginAPI()
    }
    
    @IBAction func forgotPassAction(_ sender: Any) {
        guard let vc = ResetPasswordVC.newInstance.self else {return}
       vc.modalPresentationStyle = .fullScreen
       present(vc, animated: true)
    }
    
    
    func callLoginAPI() {
        if uname == "" {
            showToast(message: "Enter Email")
        }else if uname.isValidEmail() == false {
            showToast(message: "Enter Valid Email")
        }else if password == "" {
            showToast(message: "Enter Password")
        }else {
            payload.removeAll()
            payload["username"] = uname
            payload["password"] = password
            regViewModel?.CallLoginAPI(dictParam: payload)
            
        }
    }
    
    @objc func editingText(textField:UITextField) {
        uname = emailTextField.text ?? ""
        password = passwodTextField.text ?? ""
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        dismiss(animated: true)
    }
}

extension LoginViewController {
    func RegisterDetails(response: RegisterModel) {}
    
    func loginDetails(response: LoginModel) {
        print(response)
        if response.status == false {
            showToast(message: response.data ?? "")
        }else {
            
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set(response.user_id, forKey: UserDefaultsKeys.userid)
            
            
            showToast(message: response.data ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                
                if isVcFrom == "BookingDetailsViewController" || isVcFrom == "SideMenuViewController"{
                    NotificationCenter.default.post(name: NSNotification.Name("reloadAfterLogin"), object: nil)
                    self.dismiss(animated: true)
                }else {
                    gotoHomeScreen()
                }
            }
        }
    }
    
    func gotoHomeScreen() {
        guard let vc = DashBoardTabBarViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        present(vc, animated: true)
    }

}


extension LoginViewController {
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
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
