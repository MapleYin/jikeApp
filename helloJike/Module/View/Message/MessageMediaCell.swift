//
//  MessageMediaCell.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/1.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import SnapKit


protocol MessageMediaCellAction : MessageCellAction {
    func messageCell(_ cell:MessageMediaCell, imageViews:[ImageView], index:Int) -> Void
    func messageCell(_ cell:MessageMediaCell, playVideo player:(PlayerView)->Void) -> Void
}


class MessageMediaCell: MessageCell {

    override class var identifier:String {
        return "MessageMediaCell"
    }
    
    weak var delegate:MessageMediaCellAction?
    
    private let titleLabel = UILabel()
    private let videoView = MessageVideoView()
    private let imageMediaView = MessageImageView()
    
    private var constraintFotTitle: [ConstraintMakerFinalizable] = []
    private var constraintFotVideo: [ConstraintMakerFinalizable] = []
    private var constraintFotImage: [ConstraintMakerFinalizable] = []
    
    
    
    
    private weak var playerView:PlayerView?
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // title
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 10
        titleLabel.textColor = UIColor.title
        containerView.addSubview(titleLabel)
        
        // video
        containerView.addSubview(videoView)
        
        // image
        imageMediaView.imageSelectActionBlock = { (imageViews,index) in
            self.delegate?.messageCell(self, imageViews: imageViews, index: index)
        }
        containerView.addSubview(imageMediaView)
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(15)
            make.leading.equalTo(containerView).offset(11)
            make.trailing.equalTo(containerView).offset(-11)
        }
        
        videoView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(10).priority(52)
            self.constraintFotTitle.append(make.top.equalTo(titleLabel.snp.bottom).offset(10).priority(102))
            make.leading.trailing.equalTo(containerView)
        }
        
        imageMediaView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(10).priority(51)
            self.constraintFotTitle.append(make.top.equalTo(titleLabel.snp.bottom).offset(10).priority(101))
            self.constraintFotVideo.append(make.top.equalTo(videoView.snp.bottom).offset(10).priority(201))
            make.leading.trailing.equalTo(containerView)
        }
        
        topicView.snp.remakeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(10).priority(50)
            self.constraintFotTitle.append(make.top.equalTo(titleLabel.snp.bottom).offset(10).priority(100))
            self.constraintFotVideo.append(make.top.equalTo(videoView.snp.bottom).offset(10).priority(200))
            self.constraintFotImage.append(make.top.equalTo(imageMediaView.snp.bottom).offset(10).priority(300))
            make.leading.equalTo(containerView).offset(10)
        }
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(videoTap(_:)))
        
        videoView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func setup(viewModel: MessageViewModel) {
        super.setup(viewModel: viewModel)
        
        titleLabel.isHidden = !viewModel.mediaType.contains(.text)
        if viewModel.mediaType.contains(.text) {
            titleLabel.attributedText = viewModel.title
            self.constraintFotTitle.forEach({ (constraint) in
                constraint.constraint.activate()
            })
        } else {
            self.constraintFotTitle.forEach({ (constraint) in
                constraint.constraint.deactivate()
            })
        }
        
        videoView.isHidden = !viewModel.mediaType.contains(.video)
        if viewModel.mediaType.contains(.video) {
            videoView.setup(viewModel.video!)
            self.constraintFotVideo.forEach({ (constraint) in
                constraint.constraint.activate()
            })
        } else {
            self.constraintFotVideo.forEach({ (constraint) in
                constraint.constraint.deactivate()
            })
        }
        
        imageMediaView.isHidden = !viewModel.mediaType.contains(.image)
        if viewModel.mediaType.contains(.image) {
            imageMediaView.setup(viewModel.images)
            self.constraintFotImage.forEach({ (constraint) in
                constraint.constraint.activate()
            })
        } else {
            self.constraintFotImage.forEach({ (constraint) in
                constraint.constraint.deactivate()
            })
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageMediaView.reset()
    }
}


// MARK: - Image
extension MessageMediaCell {
    func selectedImageViewRect(at index:Int) -> (ImageView, CGRect) {
        let imageView = imageMediaView.imageViewAtIndex(index)
        let rect = imageMediaView.convert(imageView.frame, to: self.contentView)
        return (imageView,rect)
    }
}


// MARK: - Video
extension MessageMediaCell {
    
    @objc private func videoTap(_ gestureRecognizer:UIGestureRecognizer) {
        delegate?.messageCell(self, playVideo: { (playerView) in
            self.playerView = playerView
            if playerView.superview != videoView {
                videoView.addSubview(playerView)
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
