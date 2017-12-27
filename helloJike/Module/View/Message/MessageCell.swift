//
//  MessageCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit
import SnapKit

class MessageCell: BaseCell {
    
    override class var identifier:String {
        return "MessageCell"
    }
    
    let warpperView = UIView()
    let containerView = UIStackView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        
        warpperView.layer.borderWidth = 0.5
        warpperView.layer.borderColor = UIColor.gray.cgColor
        warpperView.layer.cornerRadius = 8
        
        containerView.axis = .vertical
        containerView.alignment = .leading
        containerView.distribution = .equalSpacing
        
        warpperView.addSubview(containerView)
        contentView.addSubview(warpperView)
        
        warpperView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(5, 11, 5, 11))
        }
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(warpperView).inset(UIEdgeInsetsMake(5, 11, 5, 11))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
