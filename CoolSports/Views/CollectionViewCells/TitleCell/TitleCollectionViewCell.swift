//
//  TitleCollectionViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/3/22.
//

import UIKit
enum TitleType{
    case Normal
    case Header
}

class TitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle:UILabel!
    
    //MARK: - Variables
    var titleType:TitleType?{
        didSet{
            setupTitle()
        }
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupTitle(){
        switch titleType{
        case .Normal:
            lblTitle.font = UIFont(name: "Roboto-Regular", size: 10)
        
        case .Header:
            lblTitle.font = UIFont(name: "Roboto-Bold", size: 12)
            
           
        default:
            break
            
        
        }
    }

}
