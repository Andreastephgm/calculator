//
//  ViewController.swift
//  calculator
//
//  Created by Andrea Stefanny Garcia Mejia on 16/01/23.


import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView = {
        let calculatorIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        calculatorIcon.image = UIImage(named: "logo")
        return calculatorIcon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        DispatchQueue.main.asyncAfter(deadline: .now()+8){
            self.performSegue(withIdentifier: "segue", sender: self)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+5){
            self.animation()
        }
    }
    func animation(){
        UIView.animate(withDuration: 1){
            let size = self.view.frame.size.width * 2
            let xPosition = size - self.view.frame.width
            let yPosition = self.view.frame.height - size
            
            self.imageView.frame = CGRect(x: -(xPosition/2), y: yPosition/2, width: size, height: size)
            self.imageView.alpha = 0
        }
    }
}

