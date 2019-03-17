//
//  PopupController.swift
//  Example
//
//  Created by Yulia Moskaleva on 17/03/2019.
//  Copyright © 2019 Yulia Moskaleva. All rights reserved.
//

import UIKit

struct PopupAction {
    let title: String
    let handler: (() -> Void)?
}

class PopupController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var stackViewButtons: UIStackView!
    private var popupActions: [PopupAction] = []
    
    public convenience init(message: String, actions: [PopupAction]) {
        self.init(nibName: nil, bundle: nil)
        
        loadViewIfNeeded()
        
        labelTitle.text = message
        
        for (index, action) in actions.enumerated() {
            let button = UIButton.popupButton(with: action.title.uppercased())
            button.tag = index
            
            button.addTarget(
                self, action: #selector(handleActionButton), for: .touchUpInside
            )
            stackViewButtons.addArrangedSubview(button)
        }
        popupActions.append(contentsOf: actions)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func handleActionButton(_ sender: UIButton) {
        let action = popupActions[sender.tag]
        self.dismiss(animated: true) {
            if let handler = action.handler {
                handler()
                
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}

extension PopupController {
    class func showPopup(message: String, actions: [PopupAction],on: UIViewController){
        let controller = PopupController.init(message: message,actions: actions)
        controller.modalPresentationStyle = .overCurrentContext
        on.present(controller,animated: true,completion: nil)
    }
}
