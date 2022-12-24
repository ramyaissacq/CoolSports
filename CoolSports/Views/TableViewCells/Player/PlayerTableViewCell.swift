//
//  PlayerTableViewCell.swift
//  CoolSports
//
//  Created by Remya on 12/20/22.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPlayer: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(obj:TeamPlayerData?){
        imgPlayer.setImage(with: obj?.photo, placeholder: Utility.getPlaceHolder())
        lblName.text = obj?.nameEn
        if Utility.getCurrentLang() == "cn"{
            lblName.text = obj?.nameChs
        }
        lblValue.text = obj?.value
    }
    
}
