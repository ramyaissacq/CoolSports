//
//  ProfileViewModel.swift
//  CoolSports
//
//  Created by Remya on 12/19/22.
//

import Foundation

protocol ProfileViewModelDelegate{
    func didFinishFetch()
}

class ProfileViewModel{
    var delegate:ProfileViewModelDelegate?
    var teamInfo:TeamDetailsResponse?
    
    
    func getTeamDetails(id:Int){
        HomeAPI().getTeamDetails(id: id) { response in
            self.teamInfo = response
            self.delegate?.didFinishFetch()
            
        } failed: { _ in
            
        }

    }
    
    func getLeagueObject(index:Int) -> League?{
        var league:League?
        switch index{
        case 0:
            var value = teamInfo?.teamInfoData?.first?.nameEn
            if Utility.getCurrentLang() == "cn"{
                value = teamInfo?.teamInfoData?.first?.nameChs
            }
            league = League(key: "Full Name".localized.localized, value: value ?? "")
        case 1:
            let value = teamInfo?.teamInfoData?.first?.foundingDate
            
            league = League(key: "Founding Date:".localized.localized, value: value ?? "")
        case 2:
            var value = teamInfo?.teamInfoData?.first?.areaEn
            if Utility.getCurrentLang() == "cn"{
                value = teamInfo?.teamInfoData?.first?.areaCn
            }
            league = League(key: "Area".localized.localized, value: value ?? "")
        case 3:
            var value = teamInfo?.teamInfoData?.first?.coachEn
            if Utility.getCurrentLang() == "cn"{
                value = teamInfo?.teamInfoData?.first?.coachCn
            }
            league = League(key: "Coach".localized.localized, value: value ?? "")
        case 4:
            let value = teamInfo?.teamInfoData?.first?.capacity
            
            league = League(key: "Capacity".localized.localized, value: value ?? "")
        case 5:
            let value = teamInfo?.teamInfoData?.first?.website
            
            league = League(key: "Website".localized.localized, value: value ?? "")
            
        default:
            break
        }
        return league
    }
    
    
    func getPlayerObject(index:Int,id:Int) -> League?{
        let player = teamInfo?.teamPlayerData?.filter{$0.playerId == id}.first
        var league:League?
        switch index{
        case 0:
            var value = player?.nameEn
            if Utility.getCurrentLang() == "cn"{
                value = player?.nameChs
            }
            league = League(key: "Full Name".localized.localized, value: value ?? "")
        case 1:
            var value = player?.countryEn
            if Utility.getCurrentLang() == "cn"{
                value = player?.countryCn
            }
            league = League(key: "Country".localized.localized, value: value ?? "")
        case 2:
            let value = player?.birthday
            
            league = League(key: "Birthday".localized.localized, value: value ?? "")
        case 3:
            let value = player?.height
            
            league = League(key: "Height".localized.localized, value: value ?? "")
        case 4:
            let value = player?.weight
            
            league = League(key: "Weight".localized.localized, value: value ?? "")
        case 5:
            var value = player?.positionEn
            if Utility.getCurrentLang() == "cn"{
                value = player?.positionCn
            }
            league = League(key: "Position".localized.localized, value: value ?? "")
        case 6:
            let value = player?.number
            
            league = League(key: "Number".localized.localized, value: value ?? "")
        case 7:
            let value = player?.endDateContract
            
            league = League(key: "Contract Ending".localized.localized, value: value ?? "")
            
        default:
            break
        }
        return league
    }
    
}
