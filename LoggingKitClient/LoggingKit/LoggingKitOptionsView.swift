//
//  LoggingKitOptionsView.swift
//  LoggingKitClient
//
//  Created by ramon.pineda on 3/6/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

protocol LoggingKitOptionsDelegate {
    func all(view: UIView)
    func allAfterMid(view: UIView)
    func allBeforerMid(view: UIView)
    func custom(view: UIView)
}

class LoggingKitOptionsView: UIView {
    
    var delegate: LoggingKitOptionsDelegate! = nil
    
    var customView = UIView()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        self.setup()
    }
    
    func setup()
    {
        customView.frame = CGRect.init(x: 0, y: 0, width: 350, height: 320)
        customView.backgroundColor = UIColor.clear
        customView.center = self.center
        
        let option_1 = UIView()
        option_1.frame = CGRect.init(x: 0, y: 0, width: 350, height: 63)
        option_1.backgroundColor = UIColor.white
        
        let button1 = UIButton()
        button1.frame = CGRect.init(x: 0, y: 0, width: 350, height: 62.5)
        button1.setTitle("All", for: UIControlState.normal)
        button1.titleColor(for: UIControlState.normal)
        button1.backgroundColor = UIColor.orange
        button1.addTarget(self, action: #selector(all), for: UIControlEvents.touchUpInside)
        option_1.addSubview(button1)
        
        customView.addSubview(option_1) //First option
        
        let option_2 = UIView()
        option_2.frame = CGRect.init(x: 0, y: 63, width: 350, height: 63)
        option_2.backgroundColor = UIColor.white
        
        let button2 = UIButton()
        button2.frame = CGRect.init(x: 0, y: 0, width: 350, height: 62.5)
        button2.setTitle("After midnight", for: UIControlState.normal)
        button2.titleColor(for: UIControlState.normal)
        button2.backgroundColor = UIColor.orange
        button2.addTarget(self, action: #selector(allAfterMid), for: UIControlEvents.touchUpInside)
        option_2.addSubview(button2)
        
        customView.addSubview(option_2) //Second option
        
        let option_3 = UIView()
        option_3.frame = CGRect.init(x: 0, y: 126, width: 350, height: 63)
        option_3.backgroundColor = UIColor.white
        
        let button3 = UIButton()
        button3.frame = CGRect.init(x: 0, y: 0, width: 350, height: 62.5)
        button3.setTitle("Before midnight", for: UIControlState.normal)
        button3.titleColor(for: UIControlState.normal)
        button3.backgroundColor = UIColor.orange
        button3.addTarget(self, action: #selector(allBeforerMid), for: UIControlEvents.touchUpInside)
        option_3.addSubview(button3)
        
        customView.addSubview(option_3) //Third option
        
        let option_4 = UIView()
        option_4.frame = CGRect.init(x: 0, y: 189, width: 350, height: 63)
        option_4.backgroundColor = UIColor.white
        
        let button4 = UIButton()
        button4.frame = CGRect.init(x: 0, y: 0, width: 350, height: 62.5)
        button4.setTitle("Custom dates", for: UIControlState.normal)
        button4.titleColor(for: UIControlState.normal)
        button4.backgroundColor = UIColor.orange
        button4.addTarget(self, action: #selector(custom), for: UIControlEvents.touchUpInside)
        option_4.addSubview(button4)
        
        customView.addSubview(option_4) //Fourth option
        
        let button = UIButton()
        button.frame = CGRect.init(x: 0, y: 257, width: 350, height: 63)
        button.setTitle("Cancelar", for: UIControlState.normal)
        button.titleColor(for: UIControlState.normal)
        button.backgroundColor = UIColor.orange
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(closeWindow), for: UIControlEvents.touchUpInside)
        button.layer.cornerRadius = customView.frame.width / 60.0
        customView.addSubview(button) //Cancel option
        self.addSubview(customView)

    }
    
    func closeWindow (sender: UIButton!) {
        self.removeFromSuperview();
    }
    
    func all (sender: UIButton!)
    {
        delegate.all(view: self)
    }
    
    func allAfterMid (sender: UIButton!)
    {
        delegate.allAfterMid(view: self)
    }
    
    func allBeforerMid (sender: UIButton!)
    {
        delegate.allBeforerMid(view: self)
    }
    
    func custom (sender: UIButton!)
    {
        delegate.custom(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
