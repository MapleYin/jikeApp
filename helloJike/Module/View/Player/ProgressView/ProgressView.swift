//
//  ProgressView.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/28.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit
import SnapKit

class ProgressView: UIView {
    let totalProgressView = UIView()
    let penddingProgressView:[UIView] = []
    let currentProgressView = UIView()
    
    let indicatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        totalProgressView.backgroundColor = UIColor.black5B
        currentProgressView.backgroundColor = UIColor.mainBlue
        indicatorView.backgroundColor = UIColor.white
        indicatorView.layer.cornerRadius = 6
        indicatorView.layer.shadowColor = UIColor.black.cgColor
        indicatorView.layer.shadowOffset = CGSize(width: 0, height: 0)
        indicatorView.layer.shadowOpacity = 0.6
        
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
    
    
    func addPendingProgress(range:Range<CGFloat>) {
        
    }
    
    func updateCurrentProgress(_ progress:CGFloat) {
        let rato = max(min(progress, 1), 0)
        currentProgressView.snp.remakeConstraints { (make) in
            make.width.equalTo(totalProgressView.snp.width).multipliedBy(rato)
            make.leading.top.bottom.equalTo(self)
        }
    }
}
