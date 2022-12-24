

import UIKit
//import SideMenu

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarColor()
    }
    
    func setTitleMargin()
    {
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 5
        navigationController?.navigationBar.standardAppearance.largeTitleTextAttributes = [NSAttributedString.Key.paragraphStyle : style]
    }
    
    func setNavBarColor(color:UIColor = Colors.gradient1Color())
    {
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.removeBottomLine()
        let yourBackImage = UIImage(named: "back")
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.setBackIndicatorImage(yourBackImage, transitionMaskImage: yourBackImage)
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = color
        
        navBarAppearance.shadowColor = .clear
        self.navigationController?.navigationBar.backgroundColor = color
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
       
    }
    
    func makeTransparentBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        UINavigationBar.appearance().standardAppearance = appearance
        
    }
    
   
    
    func setTitle(title:String){
        self.navigationItem.titleView = getHeaderLabel(title: title)
    }
    
    func getHeaderLabel(title:String) -> UILabel{
        let w = title.width(forHeight: 26, font: UIFont(name: "Roboto-Bold", size: 26)!)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 26))
        label.text = title
        label.font = UIFont(name: "Roboto-Bold", size: 26)
        label.textColor = Colors.accentColor()
        return label
    }
    
   
   
    func getGradientHeaderLabel(title:String) -> UILabel{
        let w = title.width(forHeight: 26, font: UIFont(name: "Roboto-Bold", size: 26)!)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 26))
        label.text = title
        label.font = UIFont(name: "Roboto-Bold", size: 26)
        let gradient = label.getGradientLayer(bounds: label.bounds)
        label.textColor = label.gradientColor(bounds: label.bounds, gradientLayer: gradient)
        return label
    }
    
    func setCustomNavBarColor(color:UIColor){
        self.navigationController?.navigationBar.backgroundColor = color
        self.navigationController?.navigationBar.barTintColor = color
    }
    
  
        

    
}
