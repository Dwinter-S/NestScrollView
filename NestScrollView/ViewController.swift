//
//  ViewController.swift
//  NestScrollView
//
//  Created by 苏冬冬 on 2022/7/27.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let scrollView = NestScrollView()
    let topView = UIView()
    let tableVC = TableViewController()
    let maxOffsetY: CGFloat = 200
    var canScroll = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        topView.backgroundColor = .red
        scrollView.delegate = self
        scrollView.addSubview(topView)
        scrollView.addSubview(tableVC.view)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(30)
            $0.left.right.bottom.equalToSuperview()
        }
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(200)
        }
        tableVC.view.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(scrollView)
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("scrollViewCanScroll"), object: nil, queue: nil) { _ in
            self.canScroll = true
            self.scrollView.bounces = true
        }
    }


}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        print("scrollViewDidScroll \(contentOffsetY)")
        if !canScroll {
            scrollView.contentOffset.y = maxOffsetY
        } else if contentOffsetY >= maxOffsetY {
            scrollView.contentOffset.y = maxOffsetY
            self.canScroll = false
            self.scrollView.bounces = false
            NotificationCenter.default.post(name: NSNotification.Name("tableViewCanScroll"), object: nil)
//            scrollView.isScrollEnabled = false
        }
    }
    
}

