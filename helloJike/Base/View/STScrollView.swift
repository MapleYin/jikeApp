//
//  STScrollView.swift
//  helloJike
//
//  Created by Maple Yin on 2018/1/17.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class STScrollView: UIScrollView {
    
    private var prevBoundsSize:CGSize = CGSize.zero
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateZoomViewLayout()
    }
    
    
}

// Zoom View Layout
extension STScrollView {
    private func updateZoomViewLayout() {
     
        if let viewForZooming = delegate?.viewForZooming,
            let view = viewForZooming(self) {
            
            let contentWidth = bounds.width * zoomScale
            let size = view.bounds.size
            if size.width != 0 {
                let imageHeight = size.height / size.width * contentWidth
                let y = max(0.0,( bounds.height - imageHeight ) / 2)
                view.frame = CGRect(x: 0, y: y, width: contentWidth, height: imageHeight)
            }
            
            if !prevBoundsSize.equalTo(size) {
                contentSize = view.frame.size
                prevBoundsSize = size
            }
        }
    }
}
