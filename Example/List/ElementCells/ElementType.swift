//
//  ElementType.swift
//  Example
//
//  Created by Yulia Moskaleva on 16/03/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import Foundation
import UIKit

enum ElementType: String {
    case Text = "hz"
    case Picture = "picture"
    case Selector = "selector"
    
    func getCellType() -> String {
        switch self {
        case .Text:
            return "SelectorCell"
        case .Picture:
            return "PictureCell"
        case .Selector:
            return "SelectorCell"
        }
    }
    
    
    func getCellHeight() -> CGFloat {
         switch self {
         case .Text:
            return 55.0
         case .Picture:
            return 130.0
         case .Selector:
            return 55.0
         }
     }
    
    static func cell(for type: ElementType, tableView: UITableView, indexPath: IndexPath, elementData: ElementData?, vc: UIViewController? ) -> UITableViewCell {
        switch type {
        case .Text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as! TextCell
            if let elementData = elementData {
                cell.txtLabel.text = elementData.text
            }
            return cell
        case .Picture:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as! PictureCell
            if let elementData = elementData {
                cell.titleLabel.text = elementData.text
                cell.pictureView.load(string: elementData.url)
            }
            return cell
        case .Selector:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectorCell", for: indexPath) as! SelectorCell
            cell.vc = vc
            cell.index = indexPath
            cell.updateCellHeight = { (factor, index) in
                if let index = index, index == indexPath {
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            }
            if let elementData = elementData {
                cell.selectedId = elementData.selectedId ?? 0
                if let variants = elementData.variants {
                    var texts = [String]()
                    for variant in variants {
                        texts.append(variant.text)
                    }
                    cell.sectionItems = texts
                }
            }
            return cell
        }
    }
    
    static func cellRegistration(tableView: UITableView){
        tableView.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "TextCell")
        tableView.register(UINib(nibName: "PictureCell", bundle: nil), forCellReuseIdentifier: "PictureCell")
        tableView.register(UINib(nibName: "SelectorCell", bundle: nil), forCellReuseIdentifier: "SelectorCell")
    }
}



