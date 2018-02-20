//
//  ProgressView.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/28.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import SnapKit

protocol ProgressViewDelegate:class {
    func progressView(_ progressView:ProgressView, progressDidChanged:CGFloat) -> Void
    func progressView(_ progressView:ProgressView, progressEndChanged:CGFloat) -> Void
}

class ProgressView: UIView {
    let totalProgressView = UIView()
    let penddingProgressView = UIView()
    let currentProgressView = UIView()
    
    let indicatorView = UIView()
    
    var isDragging = false
    var currentPoint = CGPoint.zero
    
    weak var delegate:ProgressViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        totalProgressView.backgroundColor = UIColor.black5B
        currentProgressView.backgroundColor = UIColor.mainBlue
        indicatorView.backgroundColor = UIColor.white
        indicatorView.layer.cornerRadius = 6
        indicatorView.layer.shadowColor = UIColor.black.cgColor
        indicatorView.layer.shadowOffset = CGSize(width: 0, height: 0)
        indicatorView.layer.shadowOpacity = 0.6
        
        let indicatorPanGesture = UIPanGestureRecognizer(target: self, action: #selector(progressIndicatorPan(_:)))
        
        indicatorView.addGestureRecognizer(indicatorPanGesture)
        
        
        addSubview(totalProgressView)
        addSubview(currentProgressView)
        addSubview(indicatorView)
        
        
        totalProgressView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        currentProgressView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(self)
            make.width.equalTo(totalProgressView.snp.width).multipliedBy(0)
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.width.height.equalTo(12)
            make.centerY.equalTo(self)
            make.centerX.equalTo(currentProgressView.snp.trailing)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func progressIndicatorPan(_ gestureRecognizer:UIPanGestureRecognizer) {
        let point = gestureRecognizer.location(in: self)
        
        switch gestureRecognizer.state {
        case .began:
            isDragging = true
            break
        case .changed:
            let fullWidth = totalProgressView.frame.width
            let positionX = min(max(point.x, 0),fullWidth)
            delegate?.progressView(self, progressDidChanged: positionX/fullWidth)
            break
        case .ended,.cancelled:
            let fullWidth = totalProgressView.frame.width
            let positionX = min(max(point.x, 0),fullWidth)
            delegate?.progressView(self, progressEndChanged: positionX/fullWidth)
            isDragging = false
            break
        default:
            break
        }
    }
    
    func updatePendingProgress(_ progress:CGFloat) {
        let rato = max(min(progress, 1), 0)
        penddingProgressView.snp.remakeConstraints { (make) in
            make.width.equalTo(totalProgressView.snp.width).multipliedBy(rato)
            make.leading.top.bottom.equalTo(self)
        }
    }
    
    func updateCurrentProgress(_ progress:CGFloat) {
        let rato = max(min(progress, 1), 0)
        currentProgressView.snp.remakeConstraints { (make) in
            make.width.equalTo(totalProgressView.snp.width).multipliedBy(rato)
            make.leading.top.bottom.equalTo(self)
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let point = self.convert(point, to: self.indicatorView)
        if CGRect(x: -20, y: -20, width: 52, height: 52).contains(point) {
            return self.indicatorView
        }
        return super.hitTest(point, with: event)
    }
}
