//
//  CommentViewModel.swift
//  helloJike
//
//  Created by Mapleiny on 2018/2/13.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import Foundation


struct CommentViewModel {
    
    var userIconUrl:URL?
    var username:String = ""
    var timeString:String = ""
    var commentContent:String = ""
    
    init(_ comment:Comment) {
        self.userIconUrl = URL(string: comment.user.profileImageUrl)
        self.username = comment.user.screenName
        self.timeString = comment.createdAt.messageDateString
        self.commentContent = comment.content
    }
}
