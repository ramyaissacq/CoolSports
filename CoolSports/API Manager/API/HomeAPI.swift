//
//  HomeAPI.swift
//  775775Sports
//
//  Created by Remya on 9/7/22.
//

import Foundation
import SwiftyJSON

class HomeAPI: WebService {
  
    
    func getUrlInfo(completion:@escaping (UrlDetails) -> Void, failed: @escaping (String) -> Void){
        //https://app.8com.cloud/api/v1/setting.php
        //https://app.8com.cloud/api/v1/setting
        let url = "https://d.886811.fun/api/v1/setting.php"
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
        let build = Bundle.main.infoDictionary!["CFBundleVersion"]!
        //"com.test.app",
        //"test2",
        let params:[String:Any] = ["package_name":Bundle.main.bundleIdentifier ?? "",
            "platform":"iOS",
            "device_name":UIDevice.current.model,
            "version":version,
            "build_number":build]
        
        post(url: url, params: params, completion: { json in
           let response = UrlDetails(json!)
            completion(response)
        }, failed: failed)

    }
    
    
    func getLeagueDetails(id:Int,subID:Int,grpID:Int,completion:@escaping (JSON?) -> Void, failed: @escaping (String) -> Void){
        let url = BaseUrl.getBaseUrl() + EndPoints.scores_league.rawValue + "/\(id)/\(subID)/\(grpID)"
        get(url: url, params: [:], completion: { json in
            completion(json)
        }, failed: failed)
    }
    
    
    func getPlayerStandingsList(leagueID:Int,subLeagueID:Int,completion:@escaping (PlayerStandingsResponse) -> Void, failed: @escaping (String) -> Void){
        let url = BaseUrl.getBaseUrl() + EndPoints.playerStandings.rawValue + "/\(leagueID)/season/\(subLeagueID)"
        get(url: url, params: [:], completion: { json in
            let response = PlayerStandingsResponse(json!)
            completion(response)
        }, failed: failed)
    }
    
    func getTeamDetails(id:Int,completion:@escaping (TeamDetailsResponse?) -> Void, failed: @escaping (String) -> Void){
        let url = BaseUrl.getBaseUrl() + EndPoints.teamDetails.rawValue + "/\(id)"
        get(url: url, params: [:], completion: { json in
            let response = TeamDetailsResponse(json!)
            completion(response)
        }, failed: failed)
    }
   
}
