//
//  MCJ_flight_list.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MCJ_flight_list : Codable {
    let connections : String?
    let totalPrice : String?
    let travelTime : String?
    let platingCarrier : String?
    let carrier : String?
    let access_key : String?
    let adults_Base_Price : Int?
    let basePrice_Breakdown : String?
    //  let adults_Tax_Price : Int?
    //  let baggageAllowance : [[String]]?
    //  let refundable : String?
    let fareType : String?
    let basePrice : String?
    let trip_type : String?
    let aMarkup_cal : Int?
    let myMarkup_cal : Int?
    let price : Price?
    let sITECurrencyType : String?
    //    let airPricingSolution_Key : String?
    //    let farerulesref_content : [[String]]?
    //    let all_Passenger : String?
    //    let farerulesref_Key : [[String]]?
    let flight_details : Flight_details?
    let completeItinerary : String?
    let adults : Int?
    let aMarkup : Int?
    let taxes : String?
    let myMarkup : Int?
    let taxPrice_Breakdown : String?
    let selectedResult : String?
    let totalPrice_API : String?
    let farerulesref_Provider : [[String]]?
    let aPICurrencyType : String?
    
    enum CodingKeys: String, CodingKey {
        
        case connections = "Connections"
        case totalPrice = "TotalPrice"
        case travelTime = "TravelTime"
        case platingCarrier = "PlatingCarrier"
        case carrier = "Carrier"
        case access_key = "access_key"
        case adults_Base_Price = "Adults_Base_Price"
        case basePrice_Breakdown = "BasePrice_Breakdown"
        //   case adults_Tax_Price = "Adults_Tax_Price"
        //      case baggageAllowance = "BaggageAllowance"
        //   case refundable = "Refundable"
        case fareType = "FareType"
        case basePrice = "BasePrice"
        case trip_type = "trip_type"
        case aMarkup_cal = "aMarkup_cal"
        case myMarkup_cal = "MyMarkup_cal"
        case price = "price"
        case sITECurrencyType = "SITECurrencyType"
        //        case airPricingSolution_Key = "AirPricingSolution_Key"
        //        case farerulesref_content = "Farerulesref_content"
        //        case all_Passenger = "All_Passenger"
        //        case farerulesref_Key = "Farerulesref_Key"
        case flight_details = "flight_details"
        case completeItinerary = "CompleteItinerary"
        case adults = "Adults"
        case aMarkup = "aMarkup"
        case taxes = "Taxes"
        case myMarkup = "MyMarkup"
        case taxPrice_Breakdown = "TaxPrice_Breakdown"
        case selectedResult = "selectedResult"
        case totalPrice_API = "TotalPrice_API"
        case farerulesref_Provider = "Farerulesref_Provider"
        case aPICurrencyType = "APICurrencyType"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        connections = try values.decodeIfPresent(String.self, forKey: .connections)
        totalPrice = try values.decodeIfPresent(String.self, forKey: .totalPrice)
        travelTime = try values.decodeIfPresent(String.self, forKey: .travelTime)
        platingCarrier = try values.decodeIfPresent(String.self, forKey: .platingCarrier)
        carrier = try values.decodeIfPresent(String.self, forKey: .carrier)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        adults_Base_Price = try values.decodeIfPresent(Int.self, forKey: .adults_Base_Price)
        basePrice_Breakdown = try values.decodeIfPresent(String.self, forKey: .basePrice_Breakdown)
        //   adults_Tax_Price = try values.decodeIfPresent(Int.self, forKey: .adults_Tax_Price)
        //       baggageAllowance = try values.decodeIfPresent([[String]].self, forKey: .baggageAllowance)
        //    refundable = try values.decodeIfPresent(String.self, forKey: .refundable)
        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
        basePrice = try values.decodeIfPresent(String.self, forKey: .basePrice)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        aMarkup_cal = try values.decodeIfPresent(Int.self, forKey: .aMarkup_cal)
        myMarkup_cal = try values.decodeIfPresent(Int.self, forKey: .myMarkup_cal)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        sITECurrencyType = try values.decodeIfPresent(String.self, forKey: .sITECurrencyType)
        //        airPricingSolution_Key = try values.decodeIfPresent(String.self, forKey: .airPricingSolution_Key)
        //        farerulesref_content = try values.decodeIfPresent([[String]].self, forKey: .farerulesref_content)
        //        all_Passenger = try values.decodeIfPresent(String.self, forKey: .all_Passenger)
        //        farerulesref_Key = try values.decodeIfPresent([[String]].self, forKey: .farerulesref_Key)
        flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
        completeItinerary = try values.decodeIfPresent(String.self, forKey: .completeItinerary)
        adults = try values.decodeIfPresent(Int.self, forKey: .adults)
        aMarkup = try values.decodeIfPresent(Int.self, forKey: .aMarkup)
        taxes = try values.decodeIfPresent(String.self, forKey: .taxes)
        myMarkup = try values.decodeIfPresent(Int.self, forKey: .myMarkup)
        taxPrice_Breakdown = try values.decodeIfPresent(String.self, forKey: .taxPrice_Breakdown)
        selectedResult = try values.decodeIfPresent(String.self, forKey: .selectedResult)
        totalPrice_API = try values.decodeIfPresent(String.self, forKey: .totalPrice_API)
        farerulesref_Provider = try values.decodeIfPresent([[String]].self, forKey: .farerulesref_Provider)
        aPICurrencyType = try values.decodeIfPresent(String.self, forKey: .aPICurrencyType)
    }
    
}
