//
//  LeagueDetailsViewController.swift
//  CoolSports
//
//  Created by Remya on 12/16/22.
//

import UIKit
import Lottie

class LeagueDetailsViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var animationView: AnimationView!
    
    //MARK: - Variables
    var leagueID:Int?
    var leagueName:String?
    var viewModel = LeagueDetailsViewModel()
    var typeIndex = 0
    var headings = ["#","Team Name".localized,"MP","W","D","L","GF","GA","PTs"]
    
    var headings2 = ["#","Team Name".localized,"Player Name".localized,"Goals".localized,"Home".localized,"Away".localized]
    var headerSizes = [CGFloat]()
    var secondHeaderSizes = [CGFloat]()
    var padding:CGFloat = 35
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

    }
    
    func initialSettings(){
        setBackButton()
        self.navigationItem.titleView = getHeaderLabel(title: leagueName ?? "")
        searchBar.searchTextField.backgroundColor = Colors.blue2Color()
        configureLottieAnimation()
        tableView.register(UINib(nibName: "LeagueHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueHeaderTableViewCell")
        tableView.register(UINib(nibName: "StandingsHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "standingsHeaderTableViewCell")
        tableView.register(UINib(nibName: "StandingRuleTableViewCell", bundle: nil), forCellReuseIdentifier: "standingRuleTableViewCell")
        tableView.register(UINib(nibName: "StandingsRankTableViewCell", bundle: nil), forCellReuseIdentifier: "standingsRankTableViewCell")
        tableView.register(UINib(nibName: "LeagueDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueDetailsTableViewCell")
        tableView.register(UINib(nibName: "StandingsTableViewCell", bundle: nil), forCellReuseIdentifier: "standingsTableViewCell")
        tableView.register(UINib(nibName: "GeneralRowTableViewCell", bundle: nil), forCellReuseIdentifier: "generalRowTableViewCell")
        //Calculating cell widths for headings1
        headerSizes = [20,85,15,15,15,15,15,15,20]
        var itemSpacing:CGFloat = CGFloat((headings.count - 1) * 5)
        var total_widths:CGFloat = headerSizes.reduce(0, +)
        var totalSpace:CGFloat = total_widths + itemSpacing + padding
        var balance = (UIScreen.main.bounds.width - totalSpace)/CGFloat(headings.count)
        headerSizes = headerSizes.map{$0+balance}
        
        //Calculating cell widths for secondHeadings
        secondHeaderSizes = [15,80,80,20,20,20]
         itemSpacing = CGFloat((headings2.count - 1) * 5)
         total_widths = secondHeaderSizes.reduce(0, +)
         totalSpace = total_widths + itemSpacing + padding
         balance = (UIScreen.main.bounds.width - totalSpace)/CGFloat(headings2.count)
        secondHeaderSizes = secondHeaderSizes.map{$0+balance}
        
        viewModel.delegate = self
        viewModel.getLeagueDetails(id: leagueID!, subID: 0, grpID: 0)
        viewModel.getPlayerStandings(leagueID: leagueID!)
    }
    
    func configureLottieAnimation(){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }

}


extension LeagueDetailsViewController:LeagueDetailsViewModelDelegate{
    func didFinishPlayerStandingsFetch() {
        setupViews()
    }
    
    
    func didFinishFetch() {
        setupViews()
    }
    
    func setupViews(){
        if typeIndex == 0{
            if viewModel.getTeamsCount() == 0 {
                self.emptyView.isHidden = false
                animationView.play()
            }
            else{
                self.emptyView.isHidden = true
                animationView.stop()
            }
        }
//        else{
//            if viewModel.playerStandings?.count == 0{
//                self.emptyView.isHidden = false
//                animationView.play()
//            }
//            else{
//                self.emptyView.isHidden = true
//                animationView.stop()
//            }
//        }
        tableView.reloadData()
    }
    
}


extension LeagueDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return getSections()
//        if typeIndex == 0{
//        return 4
//        }
//        else{
//            return viewModel.getTeamStandingSectionsCount()
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "leagueHeaderTableViewCell") as! LeagueHeaderTableViewCell
            cell.imgPhoto.setImage(with: viewModel.leaguDetails?.leagueData01?.first?.leagueLogo, placeholder: Utility.getPlaceHolder())
            return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "leagueDetailsTableViewCell") as! LeagueDetailsTableViewCell
                cell.configureCell(obj: viewModel.leagueInfoArray?[indexPath.row-1])
                return cell
            }
            
        case 1:
            if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "standingsHeaderTableViewCell") as! StandingsHeaderTableViewCell
            cell.callSelection =  { indx in
                self.typeIndex = indx
                self.tableView.reloadData()
            }
            return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "standingsRankTableViewCell") as! StandingsRankTableViewCell
               
                cell.configureCell(toppers: viewModel.getTopTeams(isTeam: typeIndex == 0))
                cell.callbackRank = { rank in
                    if self.typeIndex == 0{
                        
                        let obj = self.viewModel.getTopTeams(isTeam: true)[rank-1]
                        self.gotoProfile(teamID: obj.teamID, playerID: nil)
                    }
                    else{
                        if rank-1 < self.viewModel.playerStandings?.count ?? 0{
                        let obj = self.viewModel.playerStandings?[rank-1]
                        self.gotoProfile(teamID: obj?.teamID, playerID: obj?.playerId)
                        }
                    }
                }
                
                return cell
            }
            
        case getSections()-1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "standingRuleTableViewCell") as! StandingRuleTableViewCell
            cell.lblRule.text = viewModel.getRule()
            return cell
        
        default:
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "generalRowTableViewCell") as! GeneralRowTableViewCell
                cell.titleType = .Header
                if typeIndex == 0{
                    cell.headerSizes = headerSizes
                    
                    cell.values = headings
                }
                else{
                    cell.headerSizes = secondHeaderSizes
                    cell.values = headings2
                }
                    return cell
            }
            if typeIndex == 0{
            if viewModel.isNormalStanding{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "standingsTableViewCell") as! StandingsTableViewCell
                cell.selectCell = {
                    tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
                }
                //cell.cellIndex = indexPath.row
                cell.headerSizes = headerSizes
               
                    let standings = viewModel.getTeamRowByIndex(index: indexPath.row-1)
                    let results = viewModel.getResultsArrayByIndex(index: indexPath.row-1)
                    let percentageStr = viewModel.getResultsPercentageStringByIndex(index: indexPath.row-1)
                    cell.configureTeamStandings(index: indexPath.row-1, standings: standings, results: results, resultsPercentage: percentageStr)
                return cell
                
            }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "generalRowTableViewCell") as! GeneralRowTableViewCell
                    
                    cell.headerSizes = headerSizes
                        cell.titleType = .Normal
                    cell.values = viewModel.getRareStandingRowByIndex(section: indexPath.section-2, row: indexPath.row-1)
                    cell.selectCell = {
                        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
                    }
                    
                    return cell
                }
            } // end type 0
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "standingsTableViewCell", for: indexPath) as! StandingsTableViewCell
                cell.headerSizes = secondHeaderSizes
                let standings = viewModel.getPlayerRowByIndex(index: indexPath.row-1)
                let points = viewModel.getPlayerPointsByIndex(index: indexPath.row-1)
                cell.configurePlayerStandings(index: indexPath.row-1, standings: standings, points: points)
                cell.selectCell = {
                    tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
                }
                return cell
            }
            
        }//end switch
        

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.section == 2{
            if indexPath.row == 0{
            cell.roundCorners(corners: [.topLeft,.topRight], radius: 10)
            }
            else{
                cell.roundCorners(corners: [.topLeft,.topRight], radius: 0)
            }
        }
        else{
            cell.roundCorners(corners: [.topLeft,.topRight], radius: 0)
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section{
        case 0:
            return viewModel.leagueInfoArray?.count ?? 0 + 1
        case 1:
            if typeIndex == 0 && viewModel.getTopTeams(isTeam: typeIndex == 0).count == 0{
                return 1
            }
            return 2
        case getSections()-1:
            if viewModel.getRule().count == 0{
                return 0
            }
            return 1
        default:
            if typeIndex == 0{
            if viewModel.isNormalStanding{
                return (viewModel.normalStandings?.totalStandings?.count ?? 0) + 1
            }
            else{
                return (viewModel.leaguStanding?.list?.first?.score?.first?.groupScore?[section-2].scoreItems?.count ?? 0) + 1
            }
            }
            else{
                return (viewModel.playerStandings?.count ?? 0) + 1
            }
            
            
           
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if typeIndex == 0{
            if indexPath.section >= 2 && indexPath.section < getSections()-1{
                if indexPath.row > 0{
                    gotoProfile(teamID: viewModel.getTeamID(section: indexPath.section-2, row: indexPath.row-1), playerID: nil)
                }
            }
            
        }
        else{
            if indexPath.section == 2 && indexPath.row > 0{
                let obj = viewModel.playerStandings?[indexPath.row - 1]
                gotoProfile(teamID: obj?.teamID, playerID: obj?.playerId)
                
            }
        }
    }
    
    
    func gotoProfile(teamID:Int?,playerID:Int?){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.leagueName = leagueName
        vc.teamID = teamID
        vc.playerID = playerID
        if typeIndex == 0{
            vc.isTeam = true
        }
        else{
            vc.isTeam = false
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getSections() -> Int{
        var sections = 4
        if typeIndex == 0{
            sections = viewModel.getTeamStandingSectionsCount()
        }
        return sections
    }
    
    
}
