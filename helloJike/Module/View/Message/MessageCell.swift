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
    
    let containerView = UIStackView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 8
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.axis = .vertical
        containerView.alignment = .leading
        containerView.spacing = 10
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(5, 11, 5, 11))
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
