//
//  CommentCell.swift
//  helloJike
//
//  Created by Mapleiny on 2018/2/7.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class CommentCell: BaseCell {

    override class var identifier:String {
        return "CommentCell"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
