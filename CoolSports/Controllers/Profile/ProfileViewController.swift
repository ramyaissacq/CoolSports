//
//  ProfileViewController.swift
//  CoolSports
//
//  Created by Remya on 12/19/22.
//

import UIKit
import Lottie

class ProfileViewController: BaseViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var animationView: AnimationView!
    
    //Variables
    var isTeam = true
    var teamID:Int?
    var playerID:Int?
    var leagueName:String?
    var headers = ["Team Info".localized,"Top Scorers".localized,"Most Value Player".localized]
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()

    }
    
    func initialSettings(){
        setBackButton()
        self.navigationItem.titleView = getHeaderLabel(title: leagueName ?? "")
        configureLottieAnimation()
        tableView.register(UINib(nibName: "LeagueDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueDetailsTableViewCell")
        tableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        tableView.register(UINib(nibName: "ProfileHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileHeaderTableViewCell")
        
        viewModel.delegate = self
        viewModel.getTeamDetails(id: teamID!)
    }
    
    func configureLottieAnimation(){
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }
    
}


extension ProfileViewController:ProfileViewModelDelegate{
    func didFinishFetch() {
        if isTeam{
            imgProfile.setImage(with: viewModel.teamInfo?.teamInfoData?.first?.logo, placeholder: Utility.getPlaceHolder())
            lblTitle.text = viewModel.teamInfo?.teamInfoData?.first?.nameEn
            if Utility.getCurrentLang() == "cn"{
                lblTitle.text = viewModel.teamInfo?.teamInfoData?.first?.nameChs
            }
            if viewModel.teamInfo?.teamInfoData?.first?.nameEn?.count ?? 0 > 0{
                emptyView.isHidden = true
                animationView.stop()
            }
            else{
                emptyView.isHidden = false
                animationView.play()
            }
        }
        else{
            let player = viewModel.teamInfo?.teamPlayerData?.filter{$0.playerId == playerID!}.first
            imgProfile.setImage(with: player?.photo, placeholder: Utility.getPlaceHolder())
            lblTitle.text = player?.nameEn
            if Utility.getCurrentLang() == "cn"{
                lblTitle.text = player?.nameChs
            }
            if player?.nameEn?.count ?? 0 > 0{
                emptyView.isHidden = true
                animationView.stop()
            }
            else{
                emptyView.isHidden = false
                animationView.play()
            }
        }
        tableView.reloadData()
    }
  
}

extension ProfileViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if isTeam{
            return 3
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isTeam{
            if section == 0{
                return 6
            }
            else if section == 1{
                return 3
            }
            else{
                return 1
            }
        }
        
        return 8
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isTeam{
            if indexPath.section == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "leagueDetailsTableViewCell") as! LeagueDetailsTableViewCell
                cell.configureCell(obj: viewModel.getLeagueObject(index: indexPath.row))
                cell.keyColor = .black
                cell.valueColor = Colors.blue1Color()
                return cell
            }
            else if indexPath.section == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell") as! PlayerTableViewCell
                cell.configureCell(obj: viewModel.teamInfo?.teamPlayerData?[indexPath.row])
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell") as! PlayerTableViewCell
                let obj = viewModel.teamInfo?.teamPlayerData?.sorted{ (Int($0.value ?? "") ?? 0) > (Int($1.value ?? "") ?? 0)}.first
                cell.configureCell(obj: obj)
                return cell
            }
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "leagueDetailsTableViewCell") as! LeagueDetailsTableViewCell
            cell.configureCell(obj: viewModel.getPlayerObject(index: indexPath.row, id: playerID!))
            cell.keyColor = .black
            cell.valueColor = Colors.blue1Color()
            return cell
            
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderTableViewCell") as! ProfileHeaderTableViewCell
        if isTeam{
            
        cell.lblTitle.text = headers[section]
           
        }
        else{
            cell.lblTitle.text = "Player Info".localized
        }
        return cell
    }
}
