//
//  Extension.swift
//  SearchCocktail
//
//  Created by ErrorV9 on 31.10.2021.
//

import UIKit

extension UIView {
    
    func addBackground() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 20, y: -20, width: width, height: height))
        imageViewBackground.image = UIImage(named: "cocktails")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}
