//
//  API.swift
//  Example
//
//  Created by Yulia Moskaleva on 13/03/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Foundation

enum Api {
    static let host = "https://prnk.blob.core.windows.net"
    
}

protocol ResponseProcessor {
    func process(on finish:() -> Void)
}

