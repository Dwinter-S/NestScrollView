//
//  NestTableView.swift
//  NestScrollView
//
//  Created by Mac mini on 2022/8/1.
//

import UIKit

class NestTableView: UITableView, UIGestureRecognizerDelegate {
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

