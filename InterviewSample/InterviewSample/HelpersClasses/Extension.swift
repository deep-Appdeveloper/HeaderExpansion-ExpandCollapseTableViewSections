//
//  Extension.swift
//  InterviewSample
//
//  Created by Deepak on 26/12/20.
//

import Foundation
import UIKit

extension UIView {
    func layoutShadowView() {
        layer.shadowRadius = 20
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.masksToBounds = false
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIImage {
func getImageRatio() -> CGFloat {
let imageRatio = CGFloat(self.size.width / self.size.height)
return imageRatio
}
}

