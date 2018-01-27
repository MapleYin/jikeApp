//
//  MessageMultipleImageCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

protocol MessageMultipleImageCellAction : MessageCellAction {
    func messageCell(_ cell:MessageMultipleImageCell, imageViews:[ImageView], index:Int) -> Void
}

class MessageMultipleImageCell: MessageTextCell {
    
    weak var delegate:MessageMultipleImageCellAction?
    
    private let multipleImageView = MessageMultipleImageView()
    
    override class var identifier:String {
        return "MessageMultipleImageCell"
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mediaView.addSubview(multipleImageView)
        
        multipleImageView.imageSelectActionBlock = { (imageViews,index) in
            self.delegate?.messageCell(self, imageViews: imageViews, index: index)
        }
        
        multipleImageView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(mediaView)
            make.leading.equalTo(mediaView)
            make.trailing.equalTo(mediaView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setup(message:Message) {
        super.setup(message: message)
        multipleImageView.setup(message.pictureUrls!)
    }
    
    func selectedImageViewRect(at index:Int) -> (ImageView, CGRect) {
        let imageView = multipleImageView.imageViewAtIndex(index)
        let rect = multipleImageView.convert(imageView.frame, to: self.contentView)
        return (imageView,rect)
    }
}
