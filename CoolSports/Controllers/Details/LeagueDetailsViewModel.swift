//
//  LeagueDetailsViewModel.swift
//  CoolSports
//
//  Created by Remya on 12/16/22.
//

import Foundation
import SwiftyJSON

protocol LeagueDetailsViewModelDelegate{
    func didFinishFetch()
    func didFinishPlayerStandingsFetch()
}
class LeagueDetailsViewModel{
    var delegate:LeagueDetailsViewModelDelegate?
    var leaguDetails:LeagueResponse?
    var leagueInfoArray:[League]?
    var normalStandings:TeamStandingsResponse?
    var leaguStanding:LeagueStanding?
    var isNormalStanding = true
    var playerStandings:[PlayerStandings]?
    
    
    func getLeagueDetails(id:Int,subID:Int,grpID:Int){
       // Utility.showProgress()
        HomeAPI().getLeagueDetails(id: id, subID: subID, grpID: grpID) { json in
            let leagueJson = json?["leagueStanding"]
            self.analyseResponseJson(json: leagueJson)
            self.leaguDetails = LeagueResponse(json!)
            self.populateData()
            self.delegate?.didFinishFetch()
        } failed: { _ in
            
        }

    }
    
    func getPlayerStandings(leagueID:Int){
       // Utility.showProgress()
        HomeAPI().getPlayerStandingsList(leagueID: leagueID, subLeagueID: 0) { response in
            self.playerStandings = response.list
            self.delegate?.didFinishPlayerStandingsFetch()
        } failed: { msg in
            Utility.showErrorSnackView(message: msg)
        }
        
    }
    
   
    
    func analyseResponseJson(json:JSON?){
        if json?.arrayValue.first?["totalStandings"].isEmpty ?? true{
            print("Empty json")
            leaguStanding = json?.arrayValue.map { LeagueStanding($0) }.first
            isNormalStanding = false
        }
        else{
        normalStandings =  json?.arrayValue.map { TeamStandingsResponse($0) }.first
            isNormalStanding = true
        }
    }
    
    
    
    func populateData(){
        var tmpArr = [League]()
        let keys = ["Full Name :".localized,"Abbreviation :".localized,"Type :".localized,"Current Sub-League :".localized,"Total Rounds :".localized,"Current Round :".localized,"Current Season :".localized,"Country :".localized]
        let values = getFootballLeagueValues()
        
        for i in 0...values.count-1{
            let obj = League(key: keys[i], value: values[i])
            tmpArr.append(obj)
        }
        leagueInfoArray = tmpArr
        
    }
    
    func getFootballLeagueValues()->[String]{
        var values = [String]()
        var leagueName = ""
        var shortName = ""
        var subName  = ""
        var country = ""
        switch Utility.getCurrentLang(){
        case "en":
        leagueName = leaguDetails?.leagueData01?.first?.nameEn ?? ""
        shortName = leaguDetails?.leagueData01?.first?.nameEnShort ?? ""
        subName  = leaguDetails?.leagueData02?.first?.subNameEn ?? ""
        country = leaguDetails?.leagueData01?.first?.countryEn ?? ""
        case "cn":
            leagueName = leaguDetails?.leagueData01?.first?.nameCn ?? ""
            shortName = leaguDetails?.leagueData01?.first?.nameCnShort ?? ""
            subName  = leaguDetails?.leagueData02?.first?.subNameEn ?? ""
            country = leaguDetails?.leagueData01?.first?.countryCn ?? ""
            
        case "id":
            leagueName = leaguDetails?.leagueData01?.first?.nameId ?? ""
            shortName = leaguDetails?.leagueData01?.first?.nameIdShort ?? ""
            subName  = leaguDetails?.leagueData02?.first?.subNameId ?? ""
            country = leaguDetails?.leagueData01?.first?.countryId ?? ""
            
        case "vi":
            leagueName = leaguDetails?.leagueData01?.first?.nameVi ?? ""
            shortName = leaguDetails?.leagueData01?.first?.nameViShort ?? ""
            subName  = leaguDetails?.leagueData02?.first?.subNameVi ?? ""
            country = leaguDetails?.leagueData01?.first?.countryNameVi ?? ""
            
        case "th":
            leagueName = leaguDetails?.leagueData01?.first?.nameTh ?? ""
            shortName = leaguDetails?.leagueData01?.first?.nameThShort ?? ""
            subName  = leaguDetails?.leagueData02?.first?.subNameTh ?? ""
            country = leaguDetails?.leagueData01?.first?.countryNameTh ?? ""
           
        default:
            break
        
        
        }
        values.append(leagueName)
        values.append(shortName)
        values.append(leaguDetails?.leagueData01?.first?.type ?? "")
        values.append(subName)
        values.append(leaguDetails?.leagueData02?.first?.totalRound ?? "")
        values.append(leaguDetails?.leagueData01?.first?.currRound ?? "")
        values.append(leaguDetails?.leagueData01?.first?.currSeason ?? "")
        values.append(country)
        return values
    }
   
    
    //Methods for handling teamstandings display
    func getTeamRowByIndex(index:Int)->[String]{
        var standings = [String]()
        let obj = normalStandings?.totalStandings?[index]
        standings.append("\(obj?.rank ?? 0)")
        var team = ""
        if let teamID = obj?.teamId{
            let teamObj = normalStandings?.teamInfo?.filter{$0.teamId == teamID}.first
            var teamName = ""
            switch Utility.getCurrentLang(){
            case "en":
               teamName = teamObj?.nameEn ?? ""
            case "cn":
                teamName = teamObj?.nameChs ?? ""
            
            default:
                teamName = teamObj?.nameEn ?? ""
            
            
            }
            team = (teamName) + "," + (teamObj?.flag ?? "")
        }
        standings.append(team)
        standings.append("\(obj?.totalCount ?? 0)")
        standings.append("\(obj?.winCount ?? 0)")
        standings.append("\(obj?.drawCount ?? 0)")
        standings.append("\(obj?.loseCount ?? 0)")
        standings.append("\(obj?.getScore ?? 0)")
        standings.append("\(obj?.loseScore ?? 0)")
        standings.append("\(obj?.integral ?? 0)")
        
        return standings
    }
    
    func getResultsPercentageStringByIndex(index:Int)->String{
        let obj = normalStandings?.totalStandings?[index]
        let percentageString = "W%=\(obj?.winRate ?? "")% / L%=\(obj?.loseRate ?? "")% / AVA=\(obj?.loseAverage ?? 0) / D%=\(obj?.drawRate ?? "")% / AVF=\(obj?.winAverage ?? 0)"
        return percentageString
    }
    
    func getResultsArrayByIndex(index:Int)->[String]{
        var results = [String]()
        let obj = normalStandings?.totalStandings?[index]
        if let status = Int(obj?.recentFirstResult ?? ""){
            results.append(getStatusName(status: status))
        }
        if let status = Int(obj?.recentSecondResult ?? ""){
            results.append(getStatusName(status: status))
        }
        if let status = Int(obj?.recentThirdResult ?? ""){
            results.append(getStatusName(status: status))
        }
        if let status = Int(obj?.recentFourthResult ?? ""){
            results.append(getStatusName(status: status))
        }
        if let status = Int(obj?.recentFifthResult ?? ""){
            results.append(getStatusName(status: status))
        }
        if let status = Int(obj?.recentSixthResult ?? ""){
            results.append(getStatusName(status: status))
        }
        return results
    }
    
    func getStatusName(status:Int)->String{
        switch status{
        case 0:
            return "W"
        case 1:
            return "D"
        case 2:
            return "L"
        case 3:
            return "TBD"
        default:
            return ""
        }
    }
    
    
    //Methods for handling rare standing object display
    func getRareStandingRowByIndex(section:Int,row:Int)->[String]{
        var standings = [String]()
        var teamName = ""
        let obj = leaguStanding?.list?.first?.score?.first?.groupScore?[section].scoreItems?[row]
        switch Utility.getCurrentLang(){
        case "en":
            teamName = obj?.teamNameEn ?? ""
        case "cn":
            teamName = obj?.teamNameChs ?? ""
       
        default:
            teamName = obj?.teamNameEn ?? ""
        
        }
        
        standings.append(obj?.rank ?? "0")
        standings.append(teamName)
        standings.append(obj?.totalCount ?? "0")
        standings.append(obj?.winCount ?? "0")
        standings.append(obj?.drawCount ?? "0")
        standings.append(obj?.loseCount ?? "0")
        standings.append(obj?.getScore ?? "0")
        standings.append(obj?.loseScore ?? "0")
        standings.append(obj?.integral ?? "0")
        
        return standings
    }
    
    func getGroupName(section:Int)->String?{
        let obj = leaguStanding?.list?.first?.score?.first?.groupScore?[section]
        if Utility.getCurrentLang() == "cn"{
            return obj?.groupCn
        }
        return obj?.groupEn
        
    }
    
    func getTeamStandingSectionsCount() -> Int{
        if isNormalStanding{
            return 4
        }
        else{
            return (leaguStanding?.list?.first?.score?.first?.groupScore?.count ?? 0) + 3
        }
        
    }
    
    func getTeamID(section:Int,row:Int) -> Int?{
        if isNormalStanding{
            return normalStandings?.totalStandings?[row].teamId
        }
        else{
            return Int(leaguStanding?.list?.first?.score?.first?.groupScore?[section].scoreItems?[row].teamId ?? "")
        }
    }
    
    func getTeamsCount() -> Int{
        if isNormalStanding{
            return normalStandings?.totalStandings?.count ?? 0
        }
        else{
            return leaguStanding?.list?.first?.score?.first?.groupScore?.count ?? 0
        }
    }
    
    func getTopTeams(isTeam:Bool) -> [Topper]{
        var topers = [Topper]()
        if isTeam{
        if isNormalStanding{
            if normalStandings?.totalStandings?.count ?? 0 >= 3{
                for i in 0...2{
                    let arr = getTeamRowByIndex(index: i)
                    let strArr = arr[1].components(separatedBy: ",")
                    let tp = Topper(name: strArr.first ?? "", logo: strArr.last ?? "", teamID: normalStandings?.totalStandings?[i].teamId ?? 0)
                    topers.append(tp)
                }
            }
        }
        else{
            if leaguStanding?.list?.first?.score?.first?.groupScore?[0].scoreItems?.count ?? 0 >= 3{
                for i in 0...2{
                    let arr = getRareStandingRowByIndex(section:0,row:i)
                    let teamID = Int(leaguStanding?.list?.first?.score?.first?.groupScore?[0].scoreItems?[i].teamId ?? "") ?? 0
                    let tp = Topper(name: arr[1], logo: "", teamID: teamID)
                    topers.append(tp)
                }
                
            }
            
        }
        }
        else{
            if playerStandings?.count ?? 0 >= 3{
                for i in 0...2{
                    let arr = getPlayerRowByIndex(index: i)
                    let teamID = playerStandings?[i].teamID ?? 0
                    let tp = Topper(name: arr[2], logo: "", teamID: teamID)
                    topers.append(tp)
            }
        }
        }
        return topers
    }
    
    
    func getRule() -> String {
        if Utility.getCurrentLang() == "cn"{
            return leaguDetails?.leagueData04?.first?.ruleCn ?? ""
        }
        else{
            return leaguDetails?.leagueData04?.first?.ruleEn ?? ""
        }
        
    }
    
    //Methods for handling player standings display
    
    func getPlayerRowByIndex(index:Int)->[String]{
        var standings = [String]()
        let obj = playerStandings?[index]
        var teamName = ""
        var playerName = ""
        switch Utility.getCurrentLang(){
        case "en":
           teamName = obj?.teamNameEn ?? ""
            playerName = obj?.playerNameEn ?? ""
        case "cn":
            teamName = obj?.teamNameChs ?? ""
            playerName = obj?.playerNameChs ?? ""
        
        default:
            teamName = obj?.teamNameEn ?? ""
            playerName = obj?.playerNameEn ?? ""
        
        
        }
        standings.append("\(index+1)")
        standings.append(teamName)
        standings.append(playerName)
        standings.append("\(obj?.goals ?? 0)")
        standings.append("\(obj?.homeGoals ?? 0)")
        standings.append("\(obj?.awayGoals ?? 0)")
        return standings
    }
    
    func getPlayerPointsByIndex(index:Int)->[String]{
        var points = [String]()
        let obj = playerStandings?[index]
        points.append("\("Home Penalty".localized) : \(obj?.homePenalty ?? 0)")
        points.append("\("Away Penalty".localized) : \(obj?.awayPenalty ?? 0)")
                      points.append("\("Match Number".localized) : \(obj?.matchNum ?? 0)")
        points.append("\("Sub Number".localized) : \(obj?.subNum ?? 0)")
        return points
    }
    
}
