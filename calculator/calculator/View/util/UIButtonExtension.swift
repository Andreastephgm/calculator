//
//  UIButtonExtension.swift
//  calculator
//
//  Created by Andrea Stefanny Garcia Mejia on 2/02/23.
//

import UIKit

private let orange = UIColor(red: 254, green: 148, blue: 0, alpha: 1)

extension UIButton {
    
    func round() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    
    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }
    
    func pressed(_ click: Bool) {
        backgroundColor = click ? .white : orange
        setTitleColor(click ? orange : .white, for: .normal)
        
    }
    
}
