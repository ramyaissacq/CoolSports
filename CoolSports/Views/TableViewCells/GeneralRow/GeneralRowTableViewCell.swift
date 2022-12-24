//
//  GeneralRowTableViewCell.swift
//  775775Sports
//
//  Created by Remya on 9/7/22.
//

import UIKit

class GeneralRowTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var collectionViewRow: UICollectionView!
    
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    //MARK: - Variables
    var values:[String]?{
        didSet{
            if case .Normal = titleType {
                height = 55
                collectionViewRow.backgroundColor = .white
            }
            else{
                height = 25
                collectionViewRow.backgroundColor = Colors.accentColor()
            }
            collectionHeight.constant = height
           
            collectionViewRow.reloadData()
        }
    }
    var headerSizes = [CGFloat]()
    var titleType = TitleType.Normal
    var height:CGFloat = 55
    var spacing:CGFloat = 5
    var needBorder = false
    var selectCell:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewRow.delegate = self
        collectionViewRow.dataSource = self
        collectionViewRow.registerCell(identifier: "TitleCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension GeneralRowTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
        cell.titleType = titleType
        cell.lblTitle.text = values?[indexPath.row]
        if needBorder {
        cell.borderColor = .lightGray
        cell.borderWidth = 0.5
        }
        else{
            cell.borderColor = .clear
            cell.borderWidth = 0
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCell?()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: headerSizes[indexPath.row], height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    }
    
    
}
