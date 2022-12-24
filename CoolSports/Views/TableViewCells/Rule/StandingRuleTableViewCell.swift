//
//  StandingRuleTableViewCell.swift
//  CoolSports
//
//  Created by Remya on 12/16/22.
//

import UIKit

class StandingRuleTableViewCell: UITableViewCell {

    @IBOutlet weak var fixedRule: UILabel!
    @IBOutlet weak var lblRule: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fixedRule.text = "Rules".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
