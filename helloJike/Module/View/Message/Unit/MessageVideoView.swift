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
    let palyIconView = UIImageView()
    
    init() {
        super.init(frame: CGRect.zero)
        
        imageView.backgroundColor = UIColor.gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        
        palyIconView.image = #imageLiteral(resourceName: "icon_play")
        addSubview(palyIconView)
        
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(timeLabel)
        
        
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.height.equalTo(snp.width).multipliedBy(9.0/16.0)
        }
        
        palyIconView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.bottom.equalTo(self).offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ viewModel:VideoViewModel) {
        imageView.kf.setImage(with: viewModel.coverImageUrl)
        timeLabel.text = viewModel.durationText
    }
    
    func setupPlayStatus(isPlaying:Bool) {
        palyIconView.isHidden = isPlaying
        imageView.isHidden = isPlaying
    }
}
