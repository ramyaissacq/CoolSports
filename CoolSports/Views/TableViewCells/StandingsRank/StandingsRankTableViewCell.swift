//
//  StandingsRankTableViewCell.swift
//  CoolSports
//
//  Created by Remya on 12/16/22.
//

import UIKit

class StandingsRankTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rank2View: UIView!
    @IBOutlet weak var rank1View: UIView!
    @IBOutlet weak var rank3View: UIView!
    @IBOutlet weak var topper1Title: UILabel!
    @IBOutlet weak var topper1Image: UIImageView!
    @IBOutlet weak var topper2Title: UILabel!
    @IBOutlet weak var topper2Image: UIImageView!
    @IBOutlet weak var topper3Title: UILabel!
    @IBOutlet weak var topper3Image: UIImageView!
    
    var callbackRank:((Int)->Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tappedRank1))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tappedRank2))
        let tap3 = UITapGestureRecognizer(target: self, action:#selector(tappedRank3))
        rank1View.addGestureRecognizer(tap1)
        rank2View.addGestureRecognizer(tap2)
        rank3View.addGestureRecognizer(tap3)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(toppers:[Topper]){
        if toppers.count >= 3{
        topper1Title.text = toppers.first?.name
        topper1Image.setImage(with: toppers.first?.logo, placeholder: Utility.getPlaceHolder())
        topper2Title.text = toppers[1].name
        topper2Image.setImage(with: toppers[1].logo, placeholder: Utility.getPlaceHolder())
        topper3Title.text = toppers[2].name
        topper3Image.setImage(with: toppers[2].logo, placeholder: Utility.getPlaceHolder())
        }
        
    }
    
    @objc func tappedRank1(){
        callbackRank?(1)
        
    }
    
    @objc func tappedRank2(){
        callbackRank?(2)
    }
    
    @objc func tappedRank3(){
        callbackRank?(3)
    }
    
}
