//
//  StandingsHeaderTableViewCell.swift
//  CoolSports
//
//  Created by Remya on 12/16/22.
//

import UIKit

class StandingsHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var types = ["Team Standings".localized,"Player Standings".localized]
    var callSelection:((Int)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.registerCell(identifier: "SelectionCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
}


extension StandingsHeaderTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectionCollectionViewCell", for: indexPath) as! SelectionCollectionViewCell
        cell.lblTitle.text = types[indexPath.row]
        cell.underLineColor = Colors.accentColor()
        cell.titleColor = .white
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callSelection?(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (UIScreen.main.bounds.width - 50) / 2
        return CGSize(width: w, height: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
