//
//  ViewController.swift
//  Travrun
//
//  Created by Mahesh on 09/11/23.
//

import UIKit

func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
    lbl.text = text
    lbl.textColor = textcolor
    lbl.font = font
}

func convertDateFormat(inputDate: String,f1:String,f2:String) -> String {
    
    let olDateFormatter = DateFormatter()
    olDateFormatter.dateFormat = f1
    
    guard let oldDate = olDateFormatter.date(from: inputDate) else { return "" }
    
    let convertDateFormatter = DateFormatter()
    convertDateFormatter.dateFormat = f2
    
    return convertDateFormatter.string(from: oldDate)
}

func checkDepartureAndReturnDates1(_ parameters: [String: Any],p1:String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    guard let departureDateStr = parameters[p1] as? String,
          let departureDate = dateFormatter.date(from: departureDateStr)
    else {
        print("Invalid date format")
        return false
    }
    
    let calendar = Calendar.current
    let currentDate = Date()
    
    if calendar.isDateInTomorrow(departureDate) {
        print("Departure is tomorrow's date")
        return true
    } else if departureDate > currentDate {
        print("Departure is a future date")
        return true
    } else {
        print("Departure is not a future or tomorrow's date")
        return false
    }
    
    
}


func checkDepartureAndReturnDates(_ parameters: [String: Any],p1:String,p2:String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy"
    
    guard let departureDateStr = parameters[p1] as? String,
          let returnDateStr = parameters[p2] as? String,
          let departureDate = dateFormatter.date(from: departureDateStr),
          let returnDate = dateFormatter.date(from: returnDateStr) else {
        print("Invalid date format")
        return false
    }
    
    let calendar = Calendar.current
    let currentDate = Date()
    
    if calendar.isDateInTomorrow(departureDate) {
        print("Departure is tomorrow's date")
        return true
    } else if departureDate > currentDate {
        print("Departure is a future date")
        return true
    } else {
        print("Departure is not a future or tomorrow's date")
        return false
    }
    
    if calendar.isDateInTomorrow(returnDate) {
        print("Return is tomorrow's date")
        return true
    } else if returnDate > currentDate {
        print("Return is a future date")
        return true
    } else {
        print("Return is not a future or tomorrow's date")
        return false
    }
}


func setAttributedTextnew(str1:String,str2:String,lbl:UILabel,str1font:UIFont,str2font:UIFont,str1Color:UIColor,str2Color:UIColor)  {
    
    let atter1 = [NSAttributedString.Key.foregroundColor:str1Color,
                  NSAttributedString.Key.font:str1font] as [NSAttributedString.Key : Any]
    let atter2 = [NSAttributedString.Key.foregroundColor:str2Color,
                  NSAttributedString.Key.font:str2font] as [NSAttributedString.Key : Any]
    
    let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
    let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
    
    
    let combination = NSMutableAttributedString()
    combination.append(atterStr1)
    combination.append(atterStr2)
    
    lbl.attributedText = combination
    
}

//MARK: - convertToDesiredFormat

func convertToDesiredFormat(_ inputString: String) -> String {
    if let number = Int(inputString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
        if inputString.contains("Kilograms") {
            return "\(number) kg"
        } else if inputString.contains("NumberOfPieces") {
            return "\(number) pc"
        }
    }
    return "Invalid input format."
}


//MARK: - INITIAL SETUP LABELS
func setuplabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont,align:NSTextAlignment) {
    lbl.text = text
    lbl.textColor = textcolor
    lbl.font = font
    lbl.numberOfLines = 0
    lbl.textAlignment = align
}

class ViewController: UIViewController {
    @IBOutlet var holderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view .backgroundColor = .WhiteColor
        loderBool = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.gotodashBoardScreen()
        })
    }

    func gotodashBoardScreen() {
        guard let vc = LoginViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

