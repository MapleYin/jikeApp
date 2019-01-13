//
//  VideoViewModel.swift
//  helloJike
//
//  Created by Maple Yin on 2018/2/1.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation

class VideoViewModel {
    
    let durationText: String
    var coverImageUrl: URL?
    
    init(_ video:Video) {
        durationText = {
            let minite = video.duration / 60000
            let secend:Int = Int(Float(video.duration).truncatingRemainder(dividingBy: 60000) / 1000)
            return String(format: "%.2d:%.2d", minite,secend)
        }()
        if let url = video.image?.thumbnailUrl {
            coverImageUrl = URL(string: url)
        }
    }
}
