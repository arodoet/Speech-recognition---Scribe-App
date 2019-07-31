//
//  CircleButton.swift
//  Scribe
//
//  Created by Teodora Knezevic on 7/10/19.
//  Copyright © 2019 Teodora Knezevic. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius:CGFloat = 30.0{
        didSet{
            setUpView()
        }
    }
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    func setUpView(){
        layer.cornerRadius = cornerRadius
    }

}
