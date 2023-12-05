//
//  RegisterViewController.swift
//  Travrun
//
//  Created by MA1882 on 05/12/23.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, RegisterViewModelProtocal  {
   
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var phoneNumerTextField: UITextField!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var regButton: UIButton!
    @IBOutlet weak var passwodTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    static var newInstance: RegisterViewController? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? RegisterViewController
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
    
    }
    
    func setiupUI()  {
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.cornerRadius = 30
        containerView.clipsToBounds = true
        passwodTextField.placeholder = "Enter Password"
        emailTextField.placeholder = "Enter Email Adress"
        phoneNumerTextField.placeholder = "Enter Phone Number"
        countryCodeTextField.placeholder = "+91"
        countryCodeTextField.setLeftPaddingPoints(16)
        passwodTextField.setLeftPaddingPoints(16)
        emailTextField.setLeftPaddingPoints(16)
        phoneNumerTextField.setLeftPaddingPoints(16)
        passwodTextField.layer.cornerRadius = 4
        passwodTextField.layer.borderColor = HexColor("#CCCCCC").cgColor
        passwodTextField.layer.borderWidth =  0.7
        emailTextField.layer.borderWidth =  0.7
        phoneNumerTextField.layer.borderWidth =  0.7
        phoneNumerTextField.layer.borderColor = HexColor("#CCCCCC").cgColor
        emailTextField.layer.borderColor = HexColor("#CCCCCC").cgColor
        emailTextField.layer.cornerRadius = 4
        regButton.layer.cornerRadius = 4
        emailTextField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        passwodTextField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        phoneNumerTextField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    @objc func editingText(textField:UITextField) {
        uname = emailTextField.text ?? ""
        password = passwodTextField.text ?? ""
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        callRegisterAPI()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let vc = LoginViewController.newInstance.self else {return}
       vc.modalPresentationStyle = .fullScreen
       present(vc, animated: true)
    }
    
    @IBAction func backButtonAtion(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func callRegisterAPI() {
        mobile = phoneNumerTextField.text ?? ""
        email = emailTextField.text ?? ""
        pass = passwodTextField.text ?? ""
        
        if email == "" {
            showToast(message: "Enter Email Adress")
        }else if email.isValidEmail() == false {
            showToast(message: "Enter the Valid Email Address")
        } else if mobile == "" {
            showToast(message: "Enter Phone Number")
        } else if mobile.isValidMobileNumber() == false {
            showToast(message: "Enter Valid Phone No")
        } else if pass == "" {
            showToast(message: "Enter Password")
        } else {
            payload["first_name"] = fname
            payload["last_name"] = lname
            payload["email"] = email
            payload["password"] = pass
            payload["phone"] = mobile
            regViewModel?.CallRegisterAPI(dictParam: payload)
        }
    }
    
    
    func RegisterDetails(response: RegisterModel) {
        print(response)
        if response.status == false {
            showToast(message: response.msg ?? "")
        } else {
            showToast(message: "Register Sucess")
            defaults.set(response.data?.user_id, forKey: UserDefaultsKeys.userid)
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                if isVcFrom == "BookingDetailsVC" {
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
    
    
    func loginDetails(response: LoginModel) {}
}
