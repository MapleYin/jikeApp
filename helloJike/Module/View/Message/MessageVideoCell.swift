//
//  MessageVideoCell.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/26.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit


protocol MessageVideoCellAction : MessageCellAction {
    func messageCell(_ cell:MessageVideoCell, playVideo player:(PlayerView)->Void) -> Void
}

class MessageVideoCell: MessageTextCell {
    
    weak var delegate:MessageVideoCellAction?
    private weak var playerView:PlayerView?
    
    let videoView = MessageVideoView()
    
    override class var identifier:String {
        return "MessageVideoCell"
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mediaView.addSubview(videoView)
        
        videoView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(mediaView)
            make.leading.equalTo(mediaView)
            make.trailing.equalTo(mediaView)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(videoTap(_:)))
        
        videoView.addGestureRecognizer(tapGesture)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(message:Message) {
        super.setup(message: message)
        videoView.setup(message.video!)
    }
    
    
    @objc private func videoTap(_ gestureRecognizer:UIGestureRecognizer) {
        delegate?.messageCell(self, playVideo: { (playerView) in
            self.playerView = playerView
            if playerView.superview != mediaView {
                mediaView.addSubview(playerView)
                playerView.snp.makeConstraints({ (make) in
                    make.edges.equalTo(videoView)
                })
            }
            
            playerView.play()
        })
    }
    
    
    func removePlayerIfNeeded() {
        self.playerView?.pause()
        self.playerView?.removeFromSuperview()
        self.playerView = nil
    }
}
