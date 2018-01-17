//
//  Icons.swift
//  Pinpoint
//
//  Created by Harjap Uppal on 11/23/17.
//  Copyright © 2017 Harjap Uppal. All rights reserved.
//

import Foundation
import UIKit
public class Icons{

   public let car = "🚙".emojiToImage()
    public let smallCar = "🚙".emojiToImageSmall()
  //  let work = "💼".emojiToImage()
}
extension String {
    func emojiToImage() -> UIImage? {
        let size = CGSize(width: 230, height: 240)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(CGRect(origin: CGPoint(), size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 200)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func emojiToImageSmall() -> UIImage? {
        let size = CGSize(width: 130, height: 140)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(CGRect(origin: CGPoint(), size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 100)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
