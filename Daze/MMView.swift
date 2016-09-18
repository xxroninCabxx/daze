//
//  MMView.swift
//  Daze
//
//  Created by Cory Billeaud on 9/2/16.
//  Copyright © 2016 Cory. All rights reserved.
//

import UIKit

class MMView: UIView {

    override func awakeFromNib() {
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.9).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 5, height: 3)
        
    }

}
