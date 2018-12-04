////
////  CustomLabel.swift
////  newmusic
////
////  Created by Joe Langenderfer on 12/4/18.
////  Copyright © 2018 Joe Langenderfer. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class CustomLabel: UILabel {
//
//    let padding: CGFloat
//    let height: CGFloat
//
//    init(padding: CGFloat, height: CGFloat) {
//        self.padding = padding
//        self.height = height
//        super.init(frame: .zero)
//        layer.cornerRadius = 20
//    }
//
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: padding, dy: 0)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: padding, dy: 0)
//    }
//
//    override var intrinsicContentSize: CGSize {
//        return .init(width: 0, height: height)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
