//
//  ListPtresenter.swift
//  Example
//
//  Created by Yulia Moskaleva on 17/03/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Foundation

protocol ListPresenterProtocol: class {
    func loadList()
    func attachView(view : ListProtocol?)
}

class ListPresenter: ListPresenterProtocol{
    weak var controller: ListProtocol?
    
    func attachView(view:ListProtocol?){
        controller = view
    }
    
    func loadList(){
        MainService.fetchListWithData { [weak self] (list, error) in
           
            if let error = error {
                self?.controller?.showPopup(message: error.localizedDescription)
            }
            if let list = list {
                if let result = self?.checkAndParseData(list: list) {
                    self?.controller?.updateTable(listViews: list.view, listData: result)
                } else {
                    self?.controller?.showPopup(message: "Ошибка формата данных")
                }
            }
            
        }
    }

    func checkAndParseData(list: ListWithData ) -> [ElementType:ElementData]? {
        var result = [ElementType:ElementData]()
        let set = Set(list.view)
    
        if set.count != list.data.count { return nil }
        for item in set {
            if let element = list.data.first(where: {$0.name == item}), let type = ElementType(rawValue: item) {
                result[type] = element.data
            } else {
                return nil
            }
        }
        return result
    }
    
}
