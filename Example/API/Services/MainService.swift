//
//  MainService.swift
//  Example
//
//  Created by Yulia Moskaleva on 15/03/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Foundation

enum MainService {
    
    static func fetchListWithData(on finish: @escaping(ListWithData?, Error?) -> Void) {
        RequestManager.shared.execute(MainRequest.listWithData(), on: finish)
    }
    
}

