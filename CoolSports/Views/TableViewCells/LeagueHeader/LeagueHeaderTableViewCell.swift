//
//  LeagueHeaderTableViewCell.swift
//  CoolSports
//
//  Created by Remya on 12/16/22.
//

import UIKit

class LeagueHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var fixedLeague: UILabel!
    
    @IBOutlet weak var imgPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fixedLeague.text = "League Info".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
