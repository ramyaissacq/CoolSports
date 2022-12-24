//
//  LeagueDetailsTableViewCell.swift
//  CoolSports
//
//  Created by Remya on 12/16/22.
//

import UIKit

class LeagueDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    var keyColor:UIColor?{
        didSet{
        lblKey.textColor = keyColor
        }
    }
    
    var valueColor:UIColor?{
        didSet{
            lblValue.textColor = valueColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(obj:League?){
        lblKey.text = obj?.key
        lblValue.text = obj?.value
        
    }
    
}
