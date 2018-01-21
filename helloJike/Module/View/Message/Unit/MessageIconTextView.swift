//
//  MessageIconTextView.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/21.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class MessageIconTextView: UIView {
    
    var padding:UIEdgeInsets = UIEdgeInsets.zero
    var text :String? {
        didSet{
            textLabel.text = text
        }
    }
    
    private let iconView = UIImageView()
    private let textLabel = UILabel()
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width+padding.left+padding.right, height: size.height+padding.top+padding.bottom)
    }
    
    init(icon:UIImage,text:String? = nil) {
        super.init(frame: CGRect.zero)
        
        iconView.image = icon.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = UIColor.mute
        textLabel.text = text
        textLabel.textColor = UIColor.mute
        textLabel.font = UIFont.systemFont(ofSize: 12)
        
        addSubview(iconView)
        addSubview(textLabel)
        
        
        iconView.snp.makeConstraints { (make) in
            make.leading.equalTo(self)
            make.centerY.equalTo(self)
        }
        textLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(iconView.snp.trailing).offset(5)
            make.centerY.equalTo(self)
            make.trailing.equalTo(self)
            make.height.lessThanOrEqualTo(self)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
