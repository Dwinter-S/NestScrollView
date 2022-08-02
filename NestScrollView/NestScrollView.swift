//
//  NestScrollView.swift
//  NestScrollView
//
//  Created by Mac mini on 2022/8/1.
//

import UIKit

class NestScrollView: UIScrollView, UIGestureRecognizerDelegate {
    
    var isSimultaneously = true
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return isSimultaneously
    }
}
