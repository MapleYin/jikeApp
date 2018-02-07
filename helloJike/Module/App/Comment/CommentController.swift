//
//  CommentController.swift
//  helloJike
//
//  Created by Mapleiny on 2018/2/7.
//  Copyright © 2018年 Maple Yin. All rights reserved.
//

import UIKit

class CommentController: STTableViewController {
    
    private let messageId:String
    
    private let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    init(_ messageId:String) {
        self.messageId = messageId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}
