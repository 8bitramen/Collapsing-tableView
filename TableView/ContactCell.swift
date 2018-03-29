//
//  ContactCell.swift
//  TableView
//
//  Created by Leahy, William on 1/24/18.
//  Copyright © 2018 Leahy, William. All rights reserved.
//

import Foundation
import UIKit

class ContactCell : UITableViewCell {
    
    var cellDelegate : ViewController?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // NOTE : by default system buttons have default CGRect width and height values of 0,0, so you must set to a non-zero, positive value in order to see them in your cell.  
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "star_icon"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        // tap star button action
        starButton.addTarget(self, action: #selector(handleMarkFavorited), for: .touchUpInside)
        accessoryView = starButton
    }
    
    @objc private func handleMarkFavorited() {
        cellDelegate?.isFavorited(sender: self)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
