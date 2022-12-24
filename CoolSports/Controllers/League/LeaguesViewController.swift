//
//  LeaguesViewController.swift
//  CoolSports
//
//  Created by Remya on 12/15/22.
//

import UIKit
import ImageSlideshow

class LeaguesViewController:BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageSlideshow:ImageSlideshow!
    
    var leagues:[FootballLeague]?
    let pageIndicator = UIPageControl()
    static var urlDetails:UrlDetails?
    static var popupFlag = 1
    static var timer = Timer()
    static var fromLanguage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LeaguesViewController.popupFlag = 1
        setupLeftView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        LeaguesViewController.popupFlag = 0
    }
    
    
    func initialSettings(){
        FootballLeague.populateFootballLeagues()
        leagues = FootballLeague.leagues
        searchBar.searchTextField.backgroundColor = Colors.blue2Color()
        setupNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSlides), name: Notification.Name("RefreshSlideshow"), object: nil)
        tableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.reloadData()
    }
    
    @objc func refreshSlides(){
        if LeaguesViewController.urlDetails?.mapping?.count ?? 0 > 0{
            setupSlideshow()
        }
       
    }
    
    
    func setupLeftView(){
      
        if AppPreferences.getMapObject() != nil{
            let btn = getButton(image: UIImage(named: "next")!)
            //let gradient = btn.getGradientLayer(bounds: btn.bounds)
            btn.backgroundColor = Colors.accentColor()
            btn.cornerRadius = 4
            //btn.gradientColor(bounds: btn.bounds, gradientLayer: gradient)
            btn.addTarget(self, action: #selector(specialButtonAction), for: .touchUpInside)
            self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: btn)]
        }
        
       
    }
    
    @objc func specialButtonAction() {
        if AppPreferences.getMapObject()?.openType == "0"{
            AppPreferences.setIsSearched(value: true)
            let urlString = AppPreferences.getMapObject()?.redirectUrl ?? ""
        gotoWebview(url: urlString)
        }
        else{
            AppPreferences.setIsSearched(value: false)
            guard let url = URL(string: AppPreferences.getMapObject()?.redirectUrl ?? "") else{return}
                    Utility.openUrl(url: url)
        }
        
    }
    
    func setupNavBar(){
        self.navigationItem.titleView = getHeaderLabel(title: "Cool Sports".localized)
        let menuBtn = getButton(image: UIImage(named: "menu")!)
        menuBtn.addTarget(self, action: #selector(toSettings), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
       
    }
    
    @objc func toSettings(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func gotoWebview(url:String){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        if url != ""{
            vc.urlString = url
        }
        self.navigationController?.pushViewController(vc, animated: true)
        clearSearch()
        
    }
    
    static func configureTimer(){
        if LeaguesViewController.urlDetails?.prompt?.repeat_status == 1{
        let time:Double = Double(LeaguesViewController.urlDetails?.prompt?.repeat_time ?? 0)
       timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    @objc static func timerAction(){
        if LeaguesViewController.urlDetails?.prompt?.repeat_status == 1{
            LeaguesViewController.openPrompt()
        }
    }
   
   
    static func showPopup(){
        
        NotificationCenter.default.post(name: Notification.Name("RefreshSlideshow"), object: nil)
        let frequency = AppPreferences.getPopupFrequency()
        if LeaguesViewController.urlDetails?.prompt?.repeat_status == 1{
         openPrompt()
        
        }
        else{
        let promptFrequency = LeaguesViewController.urlDetails?.prompt?.frequency ?? 0
        if frequency < promptFrequency{
            openPrompt()
            AppPreferences.setPopupFrequency(frequency: frequency+1)
        }
        }
    }
    
    static func openPrompt(){
        //
        if LeaguesViewController.fromLanguage{
            LeaguesViewController.fromLanguage = false
            //timer.invalidate()
            //configureTimer()
            return
        }
        if LeaguesViewController.popupFlag == 1{
            timer.invalidate()
        let title = LeaguesViewController.urlDetails?.prompt?.title ?? ""
        let message = LeaguesViewController.urlDetails?.prompt?.message ?? ""
            let btnText = LeaguesViewController.urlDetails?.prompt?.button ?? "OK".localized
        Dialog.openSpecialSuccessDialog(buttonLabel: btnText, title: title, msg: message, completed: {}, tapped: {
            configureTimer()
            if LeaguesViewController.urlDetails?.prompt?.redirect_url?.count ?? 0 > 0{
            var mapObj = Mapping()
            mapObj.openType = LeaguesViewController.urlDetails?.prompt?.open_type
            mapObj.redirectUrl = LeaguesViewController.urlDetails?.prompt?.redirect_url
            AppPreferences.setMapObject(obj: mapObj)
            }
            else{
                return
            }
            
            if LeaguesViewController.urlDetails?.prompt?.open_type == "0"{
                AppPreferences.setIsSearched(value: true)
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
                
                    vc.urlString = LeaguesViewController.urlDetails?.prompt?.redirect_url ?? ""
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                if let nav = appDelegate?.window?.rootViewController as? UINavigationController{
                nav.pushViewController(vc, animated: true)
                }
            }
            else{
                AppPreferences.setIsSearched(value: false)
                guard let url = URL(string: LeaguesViewController.urlDetails?.prompt?.redirect_url ?? "") else{return}
                Utility.openUrl(url: url)
            }
            
        }, closed: {
            configureTimer()
        })
        }
    }
    
    
    func setupSlideshow(){
       
        pageIndicator.currentPageIndicatorTintColor =  Colors.accentColor()
        pageIndicator.pageIndicatorTintColor = UIColor.black
        pageIndicator.numberOfPages = LeaguesViewController.urlDetails?.banner?.count ?? 0
        imageSlideshow.pageIndicator = pageIndicator
        imageSlideshow.contentScaleMode = .scaleAspectFill
        imageSlideshow.slideshowInterval = 2
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageSlideshow.addGestureRecognizer(gestureRecognizer)
        if LeaguesViewController.urlDetails?.banner?.count ?? 0 > 0{
            var images = [InputSource]()
            for m in LeaguesViewController.urlDetails?.banner ?? []{
                if let src = KingfisherSource(urlString: m.image ?? ""){
                    images.append(src)
                }
            }
            imageSlideshow.setImageInputs(images)
            imageSlideshow.isHidden = false
        }
        else{
            imageSlideshow.isHidden = true
        }
       
    }
    
    
    @objc func didTap(){
        let index = pageIndicator.currentPage
        let banner = LeaguesViewController.urlDetails?.banner?[index]
        var mapObj = Mapping()
        mapObj.openType = banner?.openType
        mapObj.redirectUrl = banner?.redirectUrl
        AppPreferences.setMapObject(obj: mapObj)
        if banner?.openType == "0"{
            AppPreferences.setIsSearched(value: true)
        gotoWebview(url: banner?.redirectUrl ?? "")
        }
        else{
            AppPreferences.setIsSearched(value: false)
            guard let url = URL(string: banner?.redirectUrl ?? "") else{return}
            Utility.openUrl(url: url)
        }
        
    }
}




extension LeaguesViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leagues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LeagueTableViewCell
        cell.lblLeague.text = leagues?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        vc.leagueID = leagues?[indexPath.row].id
        vc.leagueName = leagues?[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)
        clearSearch()
}
    
}


extension LeaguesViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trim() != ""{
            if let obj = LeaguesViewController.urlDetails?.mapping?.filter({$0.keyword?.lowercased() == searchText.lowercased()}).first{
                AppPreferences.setMapObject(obj: obj)
                if obj.openType == "0"{
                    AppPreferences.setIsSearched(value: true)
                    gotoWebview(url: obj.redirectUrl ?? "")
                }
                else{
                    AppPreferences.setIsSearched(value: false)
                    guard let url = URL(string: obj.redirectUrl ?? "") else {return}
                    Utility.openUrl(url: url)
                    clearSearch()
                }

            }
            else{
                doSearch(text: searchText)
                
            }
         
        }
        else{
            leagues = FootballLeague.leagues
            tableView.reloadData()
        }
    }
    
    func doSearch(text:String){
        leagues = FootballLeague.leagues?.filter{$0.name?.contains(text) ?? false}
        tableView.reloadData()
    }
    
    func clearSearch(){
        searchBar.text = ""
        searchBar.endEditing(true)
        leagues = FootballLeague.leagues
        tableView.reloadData()
    }
    
}
