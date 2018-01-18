//
//  STTableViewController.swift
//  helloJike
//
//  Created by Maple Yin on 2017/12/23.
//  Copyright © 2017年 Maple Yin. All rights reserved.
//

import UIKit

class STTableViewController: STViewController {
    
    var tableView:UITableView = UITableView.init(frame: CGRect.zero, style: .plain);
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refreshData), for:.valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(view)
        }
        
        
        registCellClasses(cellToRegist())
    }
    
    @objc open func refreshData() {
        
    }
    
    func loadMore() {
    }
    
    open func cellToRegist() -> [BaseCell.Type] {
        return []
    }
}

extension STTableViewController {
    
    private func registCellClasses(_ cellClasses:[BaseCell.Type]) {
        for clazz in cellClasses {
            tableView.register(clazz, forCellReuseIdentifier: clazz.identifier)
        }
    }
}


extension STTableViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
