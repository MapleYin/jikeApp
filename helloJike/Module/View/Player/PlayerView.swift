//
//  PlayerView.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/28.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    private let player:AVPlayer = AVPlayer()
    private var playerLayer:AVPlayerLayer
    private var message:Message?
    
    private let placeHolderView = ImageView()
    private let controlView = PlayerControlView()
    private let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    
    var isPlaying = false
    var isAnimating = false
    var periodicTimeObserver:Any?
    
    
    init() {
        self.playerLayer = AVPlayerLayer(player: player)
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.black
        self.playerLayer.backgroundColor = UIColor.black.cgColor
        
        placeHolderView.contentMode = .scaleAspectFill
        placeHolderView.clipsToBounds = true
        self.addSubview(placeHolderView)
        
        placeHolderView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.layer.addSublayer(self.playerLayer)
        self.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        controlView.delegate = self
        self.addSubview(controlView)
        controlView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapControlView(_:)))
        self.addGestureRecognizer(tap)
        
        periodicTimeObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(0.5, Int32(NSEC_PER_SEC)), queue: nil) { (cmtime) in
            self.updateControlView()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(interruptionComing(_:)), name: NSNotification.Name.AVAudioSessionInterruption, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEndPlay(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if periodicTimeObserver != nil {
            player.removeTimeObserver(periodicTimeObserver!)
        }
    }
    
    
    override func layoutSubviews() {
        self.playerLayer.frame = self.frame
    }
    
    
    
}

// control
extension PlayerView {
    
    func setup(message:Message) {
        self.message = message
        self.controlView.update(0, totalTime: 0)
        if let urlString = message.video?.thumbnailUrl,
            let url = URL(string: urlString) {
            self.placeHolderView.kf.setImage(with: url)
        } else {
            self.placeHolderView.image = nil
        }
    }
    
    func play() {
        isPlaying = true
        indicatorView.startAnimating()
        self.playerLayer.isHidden = true
        self.message?.videoUrl { (item) in
            self.playerLayer.isHidden = false
            self.player.replaceCurrentItem(with: item)
            self.player.play()
            
            self.indicatorView.stopAnimating()
        }
        controlView.updatPlayStatus(isPlaying)
    }
    
    func pause() {
        isPlaying = false
        player.pause()
        controlView.updatPlayStatus(isPlaying)
    }
    
    
    @objc func didTapControlView(_ gestureRecognizer:UIGestureRecognizer ) {
        if !isAnimating {
            isAnimating = true
            UIView.animate(withDuration: 0.25, animations: {
                self.controlView.toggleHiddenStatus()
            }, completion: { (finished) in
                self.isAnimating = false
            })
        }
    }
    
    private func playerItemDuration() -> CMTime {
        let thePlayerItem = self.player.currentItem
        if thePlayerItem?.status == .readyToPlay {
            return thePlayerItem!.duration
        }
        return kCMTimeInvalid
    }
    
    
    func updateControlView() {
        let seconds = self.player.currentTime().seconds
        let cmTime = playerItemDuration()
        if cmTime != kCMTimeInvalid {
            let total = playerItemDuration().seconds
            self.controlView.update(seconds, totalTime: total)
        }
    }
}

// MARK: - Action
extension PlayerView {
    @objc private func didEndPlay(_ notification:Notification) {
        pause()
        self.controlView.toggleHiddenStatus(true)
    }
    
    @objc private func interruptionComing(_ notification:Notification) {
        pause()
        self.controlView.toggleHiddenStatus(true)
    }
}


// MARK: - PlayerControlDelegate
extension PlayerView : PlayerControlDelegate{
    func controlView(_ controlView: PlayerControlView, didClickPlayButton: UIButton) {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func controlView(_ controlView: PlayerControlView, didClickExpandButton: UIButton) {
        
//        UIApplication.shared.keyWindow?.rootViewController?.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
}
