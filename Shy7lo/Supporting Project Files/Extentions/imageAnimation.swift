//
//  imageAnimation.swift
//  idol
//
//  Created by Sajjad Yousaf on 5/15/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
   public func mySetImage(image:UIImage)
    {
        guard let currentImage = self.image, currentImage != image else { return }
        let animation = CATransition()
        animation.duration = 0.3
        animation.type = kCATransitionFade
        layer.add(animation, forKey: "ImageFade")
        self.image = image
    }
}
