//
//  MessageSourceView.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/16.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import SnapKit

class MessageSourceView: UIView {
    let sourceIconView = UIImageView()
    let sourceUser = STButton(type: .custom)
    let sourceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sourceIconView.contentMode = .scaleAspectFit
        
        
        sourceUser.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        sourceUser.setTitleColor(UIColor.mainBlue, for: .normal)
        sourceUser.imageView?.contentMode = .scaleAspectFit
        sourceUser.imageView?.layer.cornerRadius = 3
        sourceUser.imageView?.clipsToBounds = true
        sourceUser.imageSize = CGSize(width: 16, height: 16)
        sourceUser.spacing = 5
        sourceLabel.font = UIFont.systemFont(ofSize: 12)
        sourceLabel.textColor = UIColor.mute
        sourceLabel.text = "来自"
        
        addSubview(sourceIconView)
        addSubview(sourceUser)
        addSubview(sourceLabel)
        
        sourceIconView.snp.makeConstraints { (make) in
            make.height.equalTo(12)
            make.width.equalTo(0)
            make.trailing.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        sourceLabel.snp.makeConstraints { (make) in
            make.leading.greaterThanOrEqualTo(self)
            make.trailing.equalTo(sourceUser.snp.leading).offset(-5)
            make.center.equalTo(self)
        }
        sourceUser.snp.makeConstraints { (make) in
            make.trailing.equalTo(self)
            make.height.equalTo(16)
            make.top.bottom.equalTo(self)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel:MessageViewModel){
        sourceIconView.isHidden = true
        sourceUser.isHidden = true
        sourceLabel.isHidden = true
        
        if let username = viewModel.userName {
            sourceUser.isHidden = false
            sourceLabel.isHidden = false
            sourceUser.setTitle(username, for: .normal)
            if let url = viewModel.userImageUrl {
                sourceUser.kf.setImage(with: url, for: .normal)
            }
        } else if let url = viewModel.iconImageUrl {
            sourceIconView.isHidden = false
            sourceIconView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cachetype, url) in
                if let image = image {
                    var width:CGFloat = 0
                    if image.size.height != 0 {
                        width = image.size.width / image.size.height * 12
                    }
                    self.sourceIconView.snp.updateConstraints({ (make) in
                        make.width.equalTo(width)
                    })
                }
            })
        }
    }
}
