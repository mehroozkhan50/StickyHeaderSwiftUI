//
//  ScrollDetector.swift
//  stickyHeader
//
//  Created by Emblem Technologies on 4/24/24.
//

import Foundation
import SwiftUI

struct ScrollDetector: UIViewRepresentable{
    var onScroll: (CGFloat) -> ()
    
    var onDraggingEnd: (CGFloat, CGFloat) -> ()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent : self)
    }
    
    func makeUIView(context : Context) -> UIView{
        return UIView()
    }
    
    func updateUIView(_ uiView : UIView, context : Context){
        DispatchQueue.main.async {
            if let scrollview = uiView.superview?.superview?.superview as? UIScrollView, !context.coordinator.isDelegateAdded{
                print(scrollview)
                scrollview.delegate = context.coordinator
                context.coordinator.isDelegateAdded = true
            }
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate{
        var parent : ScrollDetector
        init(parent: ScrollDetector) {
            self.parent = parent
        }
        var isDelegateAdded: Bool = false
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.onScroll(scrollView.contentOffset.y)
        }
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            parent.onDraggingEnd(targetContentOffset.pointee.y, velocity.y)
        }
        
    }
}
