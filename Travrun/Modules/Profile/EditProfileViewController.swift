//
//  EditProfileViewController.swift
//  Travrun
//
//  Created by MA1882 on 12/03/24.
//

import UIKit
import MobileCoreServices
import Alamofire

class EditProfileViewController: BaseTableVC, ProfileDetailsViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var updateBtnView: UIView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var profileView: BorderedView!
    @IBOutlet weak var changePicturelbl: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var editBtnView: UIView!
    
    
    static var newInstance: EditProfileViewController? {
        let storyboard = UIStoryboard(name: Storyboard.DashBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? EditProfileViewController
        return vc
    }
    
    var showKey = "profiledit"
    var isfrom = String()
    var tablerow = [TableRow]()
    var first_name = String()
    var last_name = String()
    var address2 = String()
    var date_of_birth = String()
    var address = String()
    var phone = String()
    var email = String()
    var gender = String()
    var country_name = String()
    var state_name = String()
    var city_name = String()
    var pin_code = String()
    var country_code = String()
    var payload = [String:Any]()
    var fname = String()
    var lname = String()
    var mobile = String()
    var address1 = String()
    var countryname = String()
    var statename = String()
    var cityname = String()
    var pincode = String()
    var dob = String()
    var pass = String()
    var isedit = true
    
    
    var viewmodel:ProfileDetailsViewModel?
    
    
    var pickerbool = false
    override func viewDidLoad() {

        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = ProfileDetailsViewModel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isfrom == "SideMenuViewController" {
            profileLabel.text = "Edit Profile"
        } else {
            profileLabel.text = "Profile"
        }
        updateBtnView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
    
        if pickerbool == true {
            
        } else {
            callApi()
        }
    }
    
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        callApi()
    }
    
    
    func callApi() {
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            holderView.isHidden = false
            loginLabel.isHidden = true
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            viewmodel?.CallGetProileDetails_API(dictParam: payload)
        } else {
//                TableViewHelper.EmptyMessage(message: "Please Login To View Your Flight Details", tableview: commonTableView, vc: self)
            holderView.isHidden = true
            loginLabel.isHidden = false
                gotoLoginVC()
        }
    }
    
    
    func gotoLoginVC() {
        guard let vc = LoginViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        present(vc, animated: true)
    }
    
    func setupUI() {
        
        editBtnView.layer.cornerRadius = editBtnView.layer.frame.width / 2
        profileLabel.text = "Profile"
        updateButton.layer.cornerRadius = 8
        updateBtnView.isHidden = true
        profiledetails()
        //        backBtnView.layer.cornerRadius = backBtnView.layer.frame.width / 2
        setAttributedString(str1: "Change Picture")
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["EditProfileTVCell",
                                         "EmptyTVCell"])
        setupTVCells(str: "noedit")
    }
    
    
    
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 1:
            first_name = tf.text ?? ""
            break
            
        case 2:
            last_name = tf.text ?? ""
            break
            
            
        case 3:
            date_of_birth = tf.text ?? ""
            break
            
            
        case 4:
            address = tf.text ?? ""
            break
            
            
        case 5:
            country_name = tf.text ?? ""
            break
            
            
            
        case 6:
            state_name = tf.text ?? ""
            break
            
            
        case 7:
            city_name = tf.text ?? ""
            break
            
            
            
        case 8:
            pin_code = tf.text ?? ""
            break
            
            
            
        default:
            break
        }
    }
    
    
    override func donedatePicker(cell:EditProfileTVCell) {
        date_of_birth = cell.dobTF.text ?? ""
        view.endEditing(true)
    }
    
    
    override func cancelDatePicker(cell:EditProfileTVCell) {
        view.endEditing(true)
    }
    
    
    override func didTapOnMailBtnAction(cell:EditProfileTVCell) {
        gender = cell.gender
    }
    
    override func didTapOnFeMailBtnAction(cell:EditProfileTVCell) {
        gender = cell.gender
    }
    
    
    override func didTapOnUpdateProfileBtnAction(cell: EditProfileTVCell) {
        //        updateProfile()
    }
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        self.isedit.toggle()
        if isedit {
            showKey = "profile"
            profileLabel.text = "Profile"
            updateBtnView.isHidden = true
            setupTVCells(str: "noedit")
            commonTableView.reloadData()
        } else {
            
            showKey = "edit"
            profileLabel.text = "Edit Profile"
            updateBtnView.isHidden = false
            setupTVCells(str: "edit")
            commonTableView.reloadData()
        }
    }
    
    @IBAction func updateBtnAction(_ sender: Any) {
        updateProfile()
    }
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    func getProfileDetails(response: ProfileDetailsModel) {
        pdetails = response.data
        fname = pdetails?.first_name ?? ""
        lname = pdetails?.last_name ?? ""
        mobile = pdetails?.phone ?? ""
        email = pdetails?.email ?? ""
        address = pdetails?.address ?? ""
        address1 = pdetails?.address2 ?? ""
        countryname = pdetails?.country_name ?? ""
        statename = pdetails?.state_name ?? ""
        cityname = pdetails?.city_name ?? ""
        pincode = pdetails?.pin_code ?? ""
        dob = convertDateFormat(inputDate: pdetails?.date_of_birth ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy")
        gender = pdetails?.gender ?? ""
        
        if pdetails?.image?.isEmpty == false {
            self.profilePic.sd_setImage(with: URL(string: pdetails?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
        }
        DispatchQueue.main.async {[self] in
            //            nav.titlelbl.text = "Edit Profile"
            //            nav.contentView.backgroundColor = HexColor("")
            //            changeProfileImgView.isHidden = false
            //            nav.filterBtnView.isHidden = true
            setupTVCells(str: "noedit")
        }
    }
    
    
    func updateProfileDetails(response: ProfileDetailsModel) {
        pdetails = response.data
        showToast(message: response.msg ?? "")
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.showKey = "profiledit"
            self.setupTVCells(str: "edit")
        }
    }
    
}

//MARK: - setupTVCells
extension EditProfileViewController {
    func setupTVCells(str: String) {
        tablerow.removeAll()
        tablerow.append(TableRow(key: str,cellType:.EditProfileTVCell))
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
}



extension EditProfileViewController {
    
    
    func setAttributedString(str1:String) {
        
        let atter1 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,
                                                      NSAttributedString.Key.font:UIFont.InterRegular(size: 12),
                                                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        changePicturelbl.attributedText = combination
        
        if isedit == false {
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
            changePicturelbl.addGestureRecognizer(tapGesture)
            changePicturelbl.isUserInteractionEnabled = true
        }
    }
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        
        if gesture.didTapAttributedString("Change Picture", in: changePicturelbl) {
            didTapOnChangepictureBtnAction()
        }
        
    }
    
    
    
    func didTapOnChangepictureBtnAction() {
        let alert = UIAlertController(title: "Choose To Open", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Gallery", style: .default){ (action) in
            self.openGallery()
        })
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default){ (action) in
            self.openCemera()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ (action) in
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension EditProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profilePic.image = tempImage
        }
        
        self.pickerbool = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openCemera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}



//MARK: - setupTVCells
extension EditProfileViewController {
    
    func profiledetails() {
        profilePic.layer.cornerRadius = 40
        first_name =  pdetails?.first_name ?? ""
        last_name = pdetails?.last_name ?? ""
        date_of_birth = pdetails?.date_of_birth ?? ""
        address = pdetails?.address ?? ""
        country_name = pdetails?.country_name ?? ""
        state_name = pdetails?.state_name ?? ""
        city_name = pdetails?.city_name ?? ""
        pin_code = pdetails?.pin_code ?? ""
        phone = pdetails?.phone ?? ""
        email = pdetails?.email ?? ""
        gender = pdetails?.gender ?? ""
        
        
        if pdetails?.image == "" || pdetails?.image == nil {
            profilePic.image = UIImage(named: "noprofile")
        }else {
            profilePic.sd_setImage(with: URL(string: pdetails?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        }
        
        
        if gender == "" {
            gender = "Male"
        }
        
    }
    
    
    func updateProfile(){
        if first_name.isEmpty == true {
            showToast(message: "Enter First Name")
        }else  if last_name.isEmpty == true {
            showToast(message: "Enter Last Name")
        }else  if date_of_birth.isEmpty == true {
            showToast(message: "Enter Date Of Birth")
        }else {
            
            payload.removeAll()
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            payload["first_name"] = first_name
            payload["last_name"] = last_name
            payload["phone"] = phone
            payload["email"] = email
            payload["address"] = address
            payload["address2"] = ""
            payload["country_name"] = country_name
            payload["state_name"] = state_name
            payload["city_name"] = city_name
            payload["pin_code"] = pin_code
            payload["date_of_birth"] =  convertDateFormat(inputDate: date_of_birth, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd")
            payload["gender"] = gender
            
            
            
            // MySingleton.shared.profilevm?.CALL_UPDATE_PROFILE_DETAILS_API(dictParam: payload)
            callUpdateProfileAPI()
        }
    }
    
    
    func profileDetails(response: ProfileDetailsModel) {
        
    }
    
    func profileUpdateSucess(response: ProfileDetailsModel) {
        
        pdetails = response.data
        showToast(message: response.msg ?? "")
        NotificationCenter.default.post(name: NSNotification.Name("logindone"), object: nil)
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.dismiss(animated: true)
        }
    }
    
    
    func callUpdateProfileAPI() {
        
        self.viewmodel?.view.showLoader()
        
        AF.upload(multipartFormData: { MultipartFormData  in
            
            for(key,value) in self.payload{
                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
            if let img =  self.profilePic.image {
                if let imageData = img.jpegData(compressionQuality: 0.4) {
                    MultipartFormData.append(imageData, withName: "image", fileName: "\(Date()).jpeg", mimeType: "image/jpeg")
                }
            }
            
            
        }, to: "\(BASE_URL)user/mobile_profile").responseDecodable(of: ProfileDetailsModel.self){ [self] resp in
            
            switch resp.result{
            case let .success(data):
                print("AF.upload ===== >")
                self.viewmodel?.view.hideLoader()
                self.showToast(message: data.msg ?? "")
                self.updateBtnView.isHidden = true
                self.profileLabel.text = "Profile"
                self.isedit = true
                let seconds = 1.0
                payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
                viewmodel?.CallGetProileDetails_API(dictParam: payload)
                if self.isfrom == "SideMenuViewController"{
//                    dismiss(animated: true)
                    self.profileLabel.text = "Edit Profile"
                    guard let vc = DashBoardTabBarViewController.newInstance.self else {return}
                    vc.modalPresentationStyle = .fullScreen
                    vc.selectedIndex = 0
                    callapibool = true
                    present(vc, animated: true)
                }
                
                break
                
            case .failure(let encodingError):
                self.viewmodel?.view.hideLoader()
                print("ERROR RESPONSE: \(encodingError)")
                
            }
            
        }
        
    }
}
