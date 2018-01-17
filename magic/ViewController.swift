//
//  ViewController.swift
//  magic
//
//  Created by Nikola Milenkovic on 4/17/17.
//  Copyright © 2017 Nikola Milenkovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        size = view.frame.size.width / CGFloat(horNumber)
        buttonSize = view.frame.size.width / 6
        verNumber = Int((view.frame.size.height) / size)
        makeVV()
        makeView()
        makeVV()
        makeButtons()
        napraviLab()
        
        
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan(_:))))
        let swipe = UITapGestureRecognizer(target: self, action: #selector(ViewController.swipe(_:)))
        swipe.numberOfTouchesRequired = 2
        
        view.addGestureRecognizer(swipe)
    }

    var buttonSize: CGFloat!
    var size: CGFloat!
    var horNumber = 50
    var verNumber: Int!
    var numering = [String:UIView]()
    
    func pan(_ sender: UIPanGestureRecognizer){
        
        let location = sender.location(in: view)
        
        let x = Int(location.x / size)
        let y = Int(location.y / size)
        let key = "\(x)|\(y)"
        let newView = numering[key]
        newView?.backgroundColor = bojica
        
    }
    
    func makeView(){
    
        for j in 0...verNumber  {
        
            for i in 0...horNumber - 1 {
            
                let newView = UIView()
                newView.frame = CGRect(x: CGFloat(i) * size , y: CGFloat(j) * size, width: size, height: size)
                newView.backgroundColor = .white
                newView.layer.borderColor = UIColor.gray.cgColor
                newView.layer.borderWidth = 0.5
                let key = "\(i)|\(j)"
                numering[key] = newView
                
                view.addSubview(newView)
            
            }
        
        }
        
    }
   
    func randomColor() -> UIColor{
    
        let red = CGFloat(drand48())
        let blue = CGFloat(drand48())
        let green = CGFloat(drand48())
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        return color
    
    }
    
    var bojica = UIColor.black
    
    let boje = [UIColor.white,UIColor.black,UIColor.blue,UIColor.red,UIColor.orange,UIColor.yellow]
    let imeBoje = ["white","black","blue","red","orange","yellow"]
    
    func makeButtons(){
        
        for i in 0...5 {
        
        let button = UIView()
        button.frame = CGRect(x: CGFloat(i) * buttonSize , y: 0 , width: buttonSize, height: buttonSize)
        button.backgroundColor = boje[i]
        button.tag = i
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(_:))))
        vv.addSubview(button)
        
        }
        
    }
    
    let vv = UIView()
    
    func makeVV(){
        
    vv.frame = CGRect(x: 0 , y: view.frame.size.height - buttonSize , width: view.frame.size.width , height: buttonSize)
    vv.backgroundColor = .gray
    view.addSubview(vv)
            
    }


    let labela = UILabel()
    
    func napraviLab(){
        
        
        labela.frame.size = CGSize(width: 400, height: 400)
        labela.center.x = view.frame.size.width / 2
        labela.center.y = view.frame.size.height / 2 - 100
        labela.text = "YELLOW"
        labela.textColor = .yellow
        labela.textAlignment = .center
        labela.font = UIFont.boldSystemFont(ofSize: 90)
        labela.alpha = 0
        
        view.addSubview(labela)
        
    }
    
    
    
    func tap(_ sender: UITapGestureRecognizer){
        
        if let tag = sender.view?.tag {
        
            labela.text = imeBoje[tag].capitalized
            labela.transform = CGAffineTransform(scaleX:0 ,y:0)
            labela.textColor = boje[tag]
            bojica = boje[tag]
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                self.labela.alpha = 1
                self.labela.transform = CGAffineTransform(scaleX:1 ,y:1)
                
            }, completion: { (true) in
                
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                    
                    self.labela.alpha = 0
                    
                    
                })
                
            })
            
            
        
        }
    }

    var x = 1

    func swipe(_ sender: UITapGestureRecognizer){
    
        if x == 1 {
        
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut , animations: {
                
                self.vv.frame.origin.y += self.buttonSize
                
                
                
            })
            
            x = 0
            
        }else if x == 0 {
        
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut , animations: {
                
                self.vv.frame.origin.y -= self.buttonSize
                
                
                
            })
            
            x = 1
        }
        
    }

}

