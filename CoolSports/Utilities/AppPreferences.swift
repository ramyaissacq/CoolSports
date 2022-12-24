

import UIKit
import SwiftyJSON

class AppPreferences {
    private enum Keys : String {
        
        case APPLE_LANGUAGE_KEY = "AppleLanguages"
        case IsFirstRun = "IsFirstRun"
        case popupFrequency = "popupFrequency"
        case mapData = "mapData"
        case isSearched = "isSearched"
        case points = "points"
        case launchDate = "launchDate"
        
    }
    
    class func setLaunchDate(date: String)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(date, forKey: Keys.launchDate.rawValue)
    }
    
    class func getLaunchDate() -> String
    {
        let userDefaults = UserDefaults.standard
        let value = userDefaults.string(forKey: Keys.launchDate.rawValue)
        
        return value ?? ""
        
    }
    
    class func getPoints() -> Int{
        let userDefaults = UserDefaults.standard
        let value = userDefaults.integer(forKey: Keys.points.rawValue)
        return value
    }
    
    class func setPoints(points:Int){
        let userDefaults = UserDefaults.standard
        userDefaults.set(points, forKey: Keys.points.rawValue)
    }
    
    class func setIsSearched(value: Bool)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: Keys.isSearched.rawValue)
    }
    
    class func getIsSearched() -> Bool
    {
        let userDefaults = UserDefaults.standard
        let value = userDefaults.bool(forKey: Keys.isSearched.rawValue)
        
        return value
        
    }
    
    
    class func setMapObject(obj:Mapping){
        
     let userDefaults = UserDefaults.standard
     userDefaults.set(obj.toDictionary(), forKey: Keys.mapData.rawValue)
        
         }
    
   
       class func getMapObject() -> Mapping?{
           let userDefaults = UserDefaults.standard
           if let mapData = userDefaults.object(forKey: Keys.mapData.rawValue) as? [String:Any]
           {
               let mapDataModel = Mapping.init(JSON(mapData))
               return mapDataModel
           }
           return nil
       }
    
  
    
    
    
    class func setIsFirstRun(value: Bool)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: Keys.IsFirstRun.rawValue)
    }
    
    class func getIsFirstRun() -> Bool
    {
        let userDefaults = UserDefaults.standard
        let value = userDefaults.bool(forKey: Keys.IsFirstRun.rawValue)
        
        return value
        
    }
    
    class func setPopupFrequency(frequency: Int)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(frequency, forKey: Keys.popupFrequency.rawValue)
    }
    
    class func getPopupFrequency() -> Int
    {
        let userDefaults = UserDefaults.standard
        let value = userDefaults.integer(forKey: Keys.popupFrequency.rawValue)
        
        return value
        
    }
    
    
    
   
}
