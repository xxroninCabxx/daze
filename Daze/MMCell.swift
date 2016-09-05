//
//  MMCell.swift
//  Daze
//
//  Created by Cory Billeaud on 9/2/16.
//  Copyright © 2016 Cory. All rights reserved.
//

import UIKit

class MMCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.75).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 3.0
        layer.shadowOffset = CGSize(width: 3, height: 3)
        
        
    }

    
}
