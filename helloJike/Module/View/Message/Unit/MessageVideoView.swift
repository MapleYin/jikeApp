//
//  MessageVideoView.swift
//  helloJike
//
//  Created by Mapleiny on 2018/1/16.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MessageVideoView: UIView {
    
    let imageView = UIImageView()
    let timeLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        
        imageView.backgroundColor = UIColor.gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(timeLabel)
        
        
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.height.equalTo(snp.width).multipliedBy(9.0/16.0)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.bottom.equalTo(self).offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ video:Video) {
        let url = URL(string: video.thumbnailUrl)
        imageView.kf.setImage(with: url)
        timeLabel.text = video.durationText
    }
}
