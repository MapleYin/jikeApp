//
//  Dictionary+Data.swift
//  helloJike
//
//  Created by Maple Yin on 2019/1/13.
//  Copyright © 2019 Maple Yin. All rights reserved.
//

import Foundation


extension Dictionary {
    func data() -> Data? {
        if JSONSerialization.isValidJSONObject(self),
            let data = try? JSONSerialization.data(withJSONObject: self, options: []) {
            return data
        } else {
            return nil
        }
    }
}
