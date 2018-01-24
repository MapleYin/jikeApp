//
//  LoadingView.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/24.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation
import NVActivityIndicatorView


class LoadingView : UIView {
    enum LoadingViewType {
        case dataLoading,imageLoading
    }
    
    lazy var indicatorView = NVActivityIndicatorView(frame: CGRect.zero)
    
    var viewType:LoadingViewType
    
    convenience init(type:LoadingViewType) {
        self.init(frame: CGRect.zero)
        viewType = type
    }
    
    override init(frame: CGRect) {
        viewType = .dataLoading
        super.init(frame: frame)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        
    }
    
    func stop() {
        
    }
    
}
