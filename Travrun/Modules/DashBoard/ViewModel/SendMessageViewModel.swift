//
//  SendMessageViewModel.swift
//  BabSafar
//
//  Created by FCI on 22/02/23.
//

import Foundation


//
//protocol SendMessageViewModelDelegate : BaseViewModelProtocol {
//    func sendMessageSucessDetails(response : SendMsgModel)
//}
//
//class SendMessageViewModel {
//    
//    var view: SendMessageViewModelDelegate!
//    init(_ view: SendMessageViewModelDelegate) {
//        self.view = view
//    }
//    
//    
//    func CALL_SEND_MESSAGE_API(dictParam: [String: Any]){
//        let parms = NSDictionary(dictionary:dictParam)
//        print("Parameters = \(parms)")
//        
//        self.view?.showLoader()
//        
//        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.contactus)", parameters: parms as NSDictionary, resultType: SendMsgModel.self, p:dictParam) { sucess, result, errorMessage in
//            
//            DispatchQueue.main.async {
//                self.view?.hideLoader()
//                if sucess {
//                    guard let response = result else {return}
//                    self.view.sendMessageSucessDetails(response: response)
//                } else {
//                    // Show alert
//                    print("error = \(errorMessage ?? "")")
//                    self.view.showToast(message: errorMessage ?? "")
//                }
//            }
//        }
//    }
//    
//}
//
//
//struct SendMsgModel : Codable {
//    let status : Int?
//    let msg : String?
//    let data : [String]?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case status = "status"
//        case msg = "msg"
//        case data = "data"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        status = try values.decodeIfPresent(Int.self, forKey: .status)
//        msg = try values.decodeIfPresent(String.self, forKey: .msg)
//        data = try values.decodeIfPresent([String].self, forKey: .data)
//    }
//    
//}
//
