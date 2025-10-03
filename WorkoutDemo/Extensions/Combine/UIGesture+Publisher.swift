//
//  UIGesture+Publisher.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 03.10.2025.
//

import UIKit
import Combine

extension UIView {
    
    var tapGesturePublisher: UIGestureRecognizer.Publisher<UITapGestureRecognizer> {
        UIGestureRecognizer.Publisher(
            gestureRecognizer: UITapGestureRecognizer(),
            view: self
        )
    }
    
    var panGesturePublisher: UIGestureRecognizer.Publisher<UIPanGestureRecognizer> {
        UIGestureRecognizer.Publisher(
            gestureRecognizer: UIPanGestureRecognizer(),
            view: self
        )
    }
}

extension UIGestureRecognizer {
     
    struct Publisher<T>: Combine.Publisher where T: UIGestureRecognizer {
        
        typealias Output = T
        typealias Failure = Never
        
        let gestureRecognizer: T
        let view: UIView
        
        func receive<S>(subscriber: S) where S : Subscriber, Output == S.Input, Failure == S.Failure {
            subscriber.receive(
                subscription: Subscription(
                    subscriber: subscriber,
                    gestureRecognizer: gestureRecognizer,
                    on: view
                )
            )
        }
    }
    
    class Subscription<T: UIGestureRecognizer, S: Subscriber>: Combine.Subscription where S.Input == T, S.Failure == Never {
        
        var subscriber: S?
        let gestureRecognizer: T
        let view: UIView
        
        init(subscriber: S, gestureRecognizer: T, on view: UIView) {
            self.subscriber = subscriber
            self.gestureRecognizer = gestureRecognizer
            self.view = view
            
            gestureRecognizer.addTarget(self, action: #selector(handleGesture))
            view.addGestureRecognizer(gestureRecognizer)
        }

        func cancel() {
            view.removeGestureRecognizer(
                gestureRecognizer
            )
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        @objc private func handleGesture(_ gesture: UIGestureRecognizer) {
            if let subscriber = subscriber {
                _ = subscriber.receive(gestureRecognizer)
            }
        }
    }
}
