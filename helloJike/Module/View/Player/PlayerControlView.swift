//
//  PlayerControlView.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/28.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit


protocol PlayerControlDelegate:class {
    func controlView(_ controlView:PlayerControlView, didClickPlayButton:UIButton) -> Void
    func controlView(_ controlView:PlayerControlView, didClickExpandButton:UIButton) -> Void
}

class PlayerControlView: UIView {
    let playTimeLabel = UILabel()
    let totalTimeLabel = UILabel()
    let progressView = ProgressView()
    
    let expandButton = UIButton(type: .custom)
    
    let playButton = UIButton(type: .custom)

    var controlHidden: Bool = false
    
    weak var delegate:PlayerControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        playTimeLabel.textColor = UIColor.white
        playTimeLabel.font = UIFont.systemFont(ofSize: 12)
        
        totalTimeLabel.textColor = UIColor.white
        totalTimeLabel.font = UIFont.systemFont(ofSize: 12)
        
        expandButton.setImage(#imageLiteral(resourceName: "icon_expand"), for: .normal)
        expandButton.addTarget(self, action: #selector(didClickButton(_:)), for: .touchUpInside)
        
        playButton.setImage(#imageLiteral(resourceName: "icon_play"), for: .normal)
        playButton.addTarget(self, action: #selector(didClickButton(_:)), for: .touchUpInside)
        
        addSubview(playTimeLabel)
        addSubview(totalTimeLabel)
        addSubview(progressView)
        addSubview(expandButton)
        
        addSubview(playButton)
        
        
        playTimeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(11)
            make.bottom.equalTo(self).offset(-15)
        }
        
        totalTimeLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(expandButton.snp.leading)
            make.centerY.equalTo(playTimeLabel)
        }
        
        expandButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self)
            make.centerY.equalTo(playTimeLabel)
            make.width.height.equalTo(44)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self)
            make.height.equalTo(3)
        }
        
        
        playButton.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ currentPlayTime:Double, totalTime:Double) {
        playTimeLabel.text = TimeString(Int(currentPlayTime))
        totalTimeLabel.text = TimeString(Int(totalTime))
        
        var progress:CGFloat = 0.0
        if totalTime == 0 {
            progress = 0
        } else {
            progress = CGFloat(currentPlayTime)/CGFloat(totalTime)
        }
        progressView.updateCurrentProgress(progress)
    }
    
    func toggleHiddenStatus(_ isHidden:Bool? = nil) {
        if let isHidden = isHidden {
            controlHidden = isHidden
        } else {
            controlHidden = !controlHidden
        }
        
        
        progressView.indicatorView.alpha = controlHidden ? 0 : 1
        playTimeLabel.alpha = controlHidden ? 0 : 1
        totalTimeLabel.alpha = controlHidden ? 0 : 1
        expandButton.alpha = controlHidden ? 0 : 1
        playButton.alpha = controlHidden ? 0 : 1
        layoutProgress(controlHidden)
    }
    
    @objc func didClickButton(_ btn:UIButton) {
        if btn == self.playButton {
            delegate?.controlView(self, didClickPlayButton: btn)
        } else if btn == self.expandButton {
            delegate?.controlView(self, didClickExpandButton: btn)
        }
    }
    
    func updatPlayStatus(_ isPlaying:Bool) {
        if isPlaying {
            playButton.setImage(#imageLiteral(resourceName: "icon_pause"), for: .normal)
        } else {
            playButton.setImage(#imageLiteral(resourceName: "icon_play"), for: .normal)
        }
    }
    
    
    func layoutProgress(_ isHidden:Bool) {
        if isHidden {
            progressView.snp.remakeConstraints { (make) in
                make.leading.trailing.bottom.equalTo(self)
                make.height.equalTo(3)
            }
        } else {
            progressView.snp.remakeConstraints { (make) in
                make.leading.equalTo(playTimeLabel.snp.trailing).offset(10)
                make.trailing.equalTo(totalTimeLabel.snp.leading).offset(-10)
                make.height.equalTo(3)
                make.centerY.equalTo(playTimeLabel)
            }
        }
        self.layoutIfNeeded()
    }
}
