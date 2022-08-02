//
//  TableViewController.swift
//  NestScrollView
//
//  Created by Mac mini on 2022/8/1.
//

import UIKit

class TableViewController: UIViewController {
    lazy var tableView = NestTableView()
    
    var scrollOffsetY: CGFloat = 0
    var canScroll = false
    var scrollBlock: ((Bool) -> Void)?
    
    var lastOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("tableViewCanScroll"), object: nil, queue: nil) { _ in
            self.canScroll = true
        }
    }

}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let maxOffset = scrollView.contentSize.height - scrollView.bounds.height
//        if scrollView.contentOffset.y == maxOffset {
//            scrollView.contentOffset.y = maxOffset - 0.2
//        }
//    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("delegate tableViewWillBeginDecelerating")
        
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("delegate tableViewDidEndDecelerating")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("delegate tableViewWillEndDragging")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("delegate tableViewDidEndDragging willDecelerate: \(decelerate)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("tableViewDidScroll \(scrollView.contentOffset.y)")
        if !canScroll {
            scrollView.contentOffset.y = 0
        } else if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = 0
            canScroll = false
            tableView.bounces = false
            NotificationCenter.default.post(name: NSNotification.Name("scrollViewCanScroll"), object: nil)
        } else {
            let maxOffset = scrollView.contentSize.height - scrollView.bounds.height
            if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < maxOffset {
                if scrollView.contentOffset.y > lastOffsetY {
                    // 向下滑动
                    scrollBlock?(true)
                } else {
                    // 向上滑动
                    scrollBlock?(false)
                }
                lastOffsetY = scrollView.contentOffset.y
            }
            if scrollView.contentOffset.y > 10, !tableView.bounces {
                tableView.bounces = true
            }
            
        }
    }
    
}

