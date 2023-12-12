//
//  Constants.swift
//  AppStructureDemo
//
//  Created by U Dinesh Kumar Reddy on 09/03/22.
//

import Foundation
import UIKit

var dateSelectKey = ""
let defaults = UserDefaults.standard
let KPlatform = "Platform"
let KPlatformValue = "iOS"
let KContentType = "Content-Type"
let KContentTypeValue = "application/json"
let KAccept = "Accept"
let KAcceptValue = "application/json"
let KAuthorization = "Authorization"
let KDEVICE_ID = "DEVICE_ID"
var KAccesstoken = "Accesstoken"
var loderBool = false
//let tempAccessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.IjQ5MyI.lZlN_1oQldjp7DX7Cah05igwkYhgiYqmru-JNqvAX60"
var tempAccessToken = "cpk5sre43kpsprytujhjatquwevgtpljkg?e21nfo5k#qaqwe6thnbde"
//http://dev.irepo.in:8080/        POST API Base url
//https://staging.doorcast.tech/     GET API url
//var BASE_URL = "https://staging.doorcast.tech/"
//let signInApi = "DQI-api/signin"
let getApiEndPoint = "api/get_organizations"
var BASE_URL1 = "https://travrun.com/pro_new/mobile/index.php/"
var BASE_URL = "https://travrun.com/pro_new/mobile/index.php/"

let signInApi = "signin"
let homeApi = "events_details"

struct Message {
    static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


let KAevent_status = "event_status"
let KAevent_type = "event_type"
let KAevent_view = "event_view"
let KAeventId = "eventId"
let KApage = "page"
let KAuserId = "userId"

var paymobilecountrycode = String()
var countrylist = [All_country_code_list]()
var cityList:[SelectCityModel] = []
var depatureDatesArray = ["Date","Date"]
var KAevent_statusValue = ""
var KAevent_typeValue = ""
var KAevent_viewValue = ""
var KAeventIdValue = ""
var KApageValue = ""
var KAuserIdValue = ""
var KAccesstokenValue = ""
var KAUserAccessTokenValue = ""
var callapibool = Bool()
var faretypeArray = [String]()
var AirlinesArray = [String]()
var ConnectingFlightsArray = [String]()
var ConnectingAirportsArray = [String]()
var luggageArray = [String]()
var prices = [String]()
var MCJflightlist :[[MCJ_flight_list]]?
var FlightList :[[J_flight_list]]?
var topHotelDetails = [TopHotelDetails]()
var topFlightDetails = [TopFlightDetails]()
var deailcodelist = [Deail_code_list]()
var topHolidayList = [HolidaydestinationList]()
var keyStr = String()
var directFlightBool = true
var oldjournyType = ""
var checkTermsAndCondationStatus = false

//Register
var registrationModel:RegistrationModel?


// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}


var totalprice = String()
var Adults_Base_Price = String()
var Adults_Tax_Price = String()
var Childs_Base_Price = String()
var Childs_Tax_Price = String()
var Infants_Base_Price = String()
var Infants_Tax_Price = String()
var TotalPrice_API = String()
var grandTotal = String()
var subtotal = String()

var AdultsTotalPrice = String()
var ChildTotalPrice = String()
var InfantTotalPrice = String()
var sub_total_adult : String?
var sub_total_child : String?
var sub_total_infant : String?

//MARK: - Profile details
var pdetails:ProfileDetails?

//MARK: - Travellers Details
//var adultTravllersArray = [TravellerData]()
//var childTravllersArray = [TravellerData]()
//var infantaTravllersArray = [TravellerData]()
var checkOptionCountArray = [String]()
var passengertypeArray = [String]()
var genderArray = [String]()
var leadPassengerArray = [String]()
var middleNameArray = [String]()
var arrayOf_SelectedCellsAdult = [IndexPath]()
var arrayOf_SelectedCellsChild = [IndexPath]()
var arrayOf_SelectedCellsInfanta = [IndexPath]()
var totalNoOfTravellers = String()
//var passengerA = [Passenger]()
//var travelerArray: [Traveler] = []
//var ageCategory: AgeCategory = .adult
var latArray = [String]()
var longArray = [String]()
var passportExpireDateBool = false


//MARK: - FILTER RELATED VARIABLES
var filterTap = String()
var filterPrice = String()
var filterModel = FlightFilterModel()
var sortBy: SortParameter = .nothing
var hotelfiltermodel = HotelFilterModel()

//var mapModelArray: [MapModel] = []



//MARK: - Baggage Info details
var farerulerefkey = String()
var farerulesrefcontent = String()
var fdbool = true



//MARK: - HOME SCREEN

struct UserDefaultsKeys {
    static var totalTravellerCount = "totalTravellerCount"
    static var journeyTypeSelectedIndex = "Journey_TypeSelectedIndex"
    static var DashboardTapSelectedCellIndex = "DashboardTapSelectedCellIndex"
    static var mobilecountrycode = "mobilecountrycode"
    static var isSelected = false
    static var gender = "gender"
    static var rinfantsCount = "rInfants_Count"
    static var rchildCount = "rChild_Count"
    static var radultCount = "rAdult_Count"
    static var useremail = "useremail"
    static var usermobile = "usermobile"
    static var uname = "uname"
    static var mcountrycode = "mcountrycode"
    static var userid = "userid"
    static var toairport = "toairport"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var rcalRetDate = "rcalRetDate"
    static var icalDepDate = "icalDepDate"
    static var ircalDepDate = "ircalDepDate"
    static var frcalDepDate = "frcalDepDate"
    static var frcalRetDate = "frcalRetDate"
    static var ircalRetDate = "ircalRetDate"
    static var mcaldate = "mcaldate"
    static var InsurenceJourneyType = "Insurence_Journey_Type"
    static var cellTag = "cellTag"
    static var rcalDepDate = "rcalDepDate"
    static var calDepDate = "calDepDate"
    static var journeyType = "Journey_Type"
    static var selectedCurrency = "selectedCurrency"
    static var loggedInStatus = "loggedInStatus"
    static var APICurrencyType = "APICurrencyType"
    static var APILanguageType = "APILanguageType"
    static var searchid = "search_id"
    static var selectedResult = "selectedResult"
    static var bookingsourcekey = "booking_source_key"
    static var traceId = "traceId"
    
    static var fromCity = "fromCity"
    static var toCity = "toCity"
    static var fromcityCode = "fromcityCode"
    static var toCityCode = "toCityCode"
    static var calRetDate = "calRetDate"
    static var adultCount = "Adult_Count"
    static var childCount = "Child_Count"
    static var infantsCount = "Infants_Count"
    static var selectClass = "select_class"
    static var select_classIndex = "select_classIndex"
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var fromairport = "fromairport"
    static var fromcityname = "fromcityname"
    static var tocityname = "tocityname"
    static var tairportCode = "tairportCode"
    static var travellerDetails = "travellerDetails"
    static var hadultCount = "HAdult_Count"
    static var hchildCount = "HChild_Count"
    static var dashboardTapSelected = "DashboardTapSelected"
    static var rtravellerDetails = "rtravellerDetails"
    static var rselectClass = "rselect_class"
    static var bookingsource = "booking_source"
    static var selectedFareType = "fare_type"
}


struct sessionMgrDefaults {
    static var loggedInStatus = "email"
}

struct ApiEndpoints {
    static let mobileUpdateTraveller = "mobileUpdateTraveller"
    static let mobileInsertTraveller = "mobileInsertTraveller"
    static let mobilepreprocessbooking = "mobile_pre_process_booking"
    static let mobileprocesspassengerdetail = "mobile_process_passenger_detail"
    static let mobileShowTraveller = "mobileShowTraveller"
    static let mobileTravellerDetailsByOrigin = "mobileTravellerDetailsByOrigin"
    static let register = "mobile_register_on_light_box"
    static let mobileforgotpassword = "mobile_forgot_password"
    static let login = "mobile_login"
    static let mobilelogout = "mobile_ajax_logout"
    static let mobileprofile = "mobile_profile"
    static let getTopFlightHotelDestination = "getTopFlightHotelDestination"
    static let getCountryList = "getCountryList"
    static let getairportcodelistmulticity = "get_airport_code_list_ios"
    static let currencylist = "currency_list"
    static let mobilePreFlightSearch = "mobile_pre_flight_search"
    static let getairportcodelist = "get_airport_code_list"
    static let mobileDeleteTraveller = "mobileDeleteTraveller"
}
