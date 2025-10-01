//
//  UIControl+Publisher.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 02.10.2025.
//

import UIKit
import Combine

extension UIControl {
    
    func publisher(for event: UIControl.Event) -> UIControl.Publisher<UIControl> {
        UIControl.Publisher<UIControl>(output: self, event: event)
    }
}

extension UIControl {
    
    class Subscription<SubscriberType: Subscriber, Control: UIControl>: Combine.Subscription where SubscriberType.Input == Control {
        
        private var subscriber: SubscriberType?
        private let input: Control
        
        init(subscriber: SubscriberType, input: Control, event: UIControl.Event) {
            self.subscriber = subscriber
            self.input = input
            
            addTarget(for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
        }
        
        private func addTarget(for event: UIControl.Event) {
            input.addTarget(self, action: #selector(eventHandler), for: event)
        }
        
        @objc private func eventHandler() {
            if let subscriber = subscriber {
                _ = subscriber.receive(input)
            }
        }
    }
}

extension UIControl {
    
    struct Publisher<Output: UIControl>: Combine.Publisher {
        
        typealias Output = Output
        typealias Failure = Never
        
        let output: Output
        let event: UIControl.Event
        
        init(output: Output, event: UIControl.Event) {
            self.output = output
            self.event = event
        }
        
        func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription(
                subscriber: subscriber,
                input: output,
                event: event
            )
            
            subscriber.receive(subscription: subscription)
        }
    }
}
