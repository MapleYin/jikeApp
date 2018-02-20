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
    
    let userHeaderView = STButton(type: .custom)
    let timeLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        userHeaderView.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        userHeaderView.setTitleColor(UIColor.mainBlue, for: .normal)
        userHeaderView.imageView?.contentMode = .scaleAspectFit
        userHeaderView.imageView?.layer.cornerRadius = 3
        userHeaderView.imageView?.clipsToBounds = true
        userHeaderView.imageSize = CGSize(width: 24, height: 24)
        userHeaderView.spacing = 5
        
        timeLabel.textColor = UIColor.mute
        
        contentLabel.textColor = UIColor.black33
        contentLabel.numberOfLines = 0
        
        contentView.addSubview(userHeaderView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(contentLabel)
        
        userHeaderView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.contentView).offset(11)
            make.top.equalTo(self.contentView).offset(15)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.contentView).offset(-11)
            make.centerY.equalTo(userHeaderView)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(userHeaderView)
            make.top.equalTo(userHeaderView.snp.bottom).offset(15)
            make.trailing.equalTo(timeLabel)
            make.bottom.equalTo(self.contentView).offset(-15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ viewModel:CommentViewModel) {
        if let url = viewModel.userIconUrl {
            self.userHeaderView.kf.setImage(with: url, for: .normal)
        }
        self.userHeaderView.setTitle(viewModel.username, for: .normal)
        self.timeLabel.text = viewModel.timeString
        self.contentLabel.text = viewModel.commentContent
    }
    
}
