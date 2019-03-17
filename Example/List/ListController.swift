//
//  ViewController.swift
//  Example
//
//  Created by Yulia Moskaleva on 13/03/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import UIKit

protocol ListProtocol: class {
    func showPopup(message: String)
    func updateTable(listViews:[String],listData:[ElementType: ElementData])
}

class ListController: UIViewController, ListProtocol {
    var presenter: ListPresenterProtocol?

    @IBOutlet weak var tableView: UITableView!
    var listViews = [String]()
    var listData = [ElementType: ElementData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ElementType.cellRegistration(tableView: tableView)
        presenter = ListPresenter()
        presenter?.attachView(view: self)
        presenter?.loadList()
    }
    
    func showPopup(message: String){
        let action = PopupAction(title: "I got it!") {}
        PopupController.showPopup(message: message, actions: [action], on: self)
    }
    
    func updateTable(listViews:[String],listData:[ElementType: ElementData]){
        self.listViews = listViews
        self.listData = listData
        tableView.reloadData()
    }
}

extension ListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let elementType = ElementType(rawValue: listViews[indexPath.row]) ?? .Text
        let elementData = listData[elementType]
        let cell = ElementType.cell(for: elementType  , tableView: tableView, indexPath: indexPath, elementData: elementData, vc: self)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let elementType = ElementType(rawValue: listViews[indexPath.row])
        if let elementType = elementType, elementType == .Selector, let cell = tableView.cellForRow(at: indexPath)  as? SelectorCell {
            return elementType.getCellHeight() * cell.factor
            
        }
        return elementType?.getCellHeight() ?? 0.0
        
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let elementType = ElementType(rawValue: listViews[indexPath.row]) else { return }
        var message = ""
        switch elementType {
        case .Text:
            message = "Это просто текст"
        case .Picture:
            message = "Это просто картинка с подписью"
        default: ()
        }
        
        if message != "" {
            DispatchQueue.main.async {
                let action = PopupAction(title: "I got it!") {}
                PopupController.showPopup(message: message, actions: [action], on: self)
            }
        }
    }
}
