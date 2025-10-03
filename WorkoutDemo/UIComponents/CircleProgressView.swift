//
//  CircleProgressView.swift
//  WorkoutDemo
//
//  Created by Pavel Samsonov on 01.10.2025.
//

import SwiftUI
import Combine
import SnapKit

class CircleProgressView: UIView {
    
    private let completeSubject = PassthroughSubject<Void, Never>()
    
    var completePublisher: AnyPublisher<Void, Never> {
        completeSubject.eraseToAnyPublisher()
    }
    
    private lazy var shapeLayer = createCircle(
        strokeColor: .clear,
        fillColor: .systemBlue
    )
    
    private lazy var pulseShapeLayer = createCircle(
        strokeColor: .systemPurple.withAlphaComponent(0.1),
        fillColor: .systemPurple.withAlphaComponent(0.15)
    )
    
    private lazy var trackShapeLayer = createCircle(
        strokeColor: .systemPurple,
        fillColor: .clear
    )
    
    private lazy var progressTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = timeFormattedString(timeInterval)
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private var timer = Timer.publish(every: 1, on: .main, in: .common)
    private var timeInterval: TimeInterval
    private var strokeInterval: TimeInterval = 0
    
    private var bindings = Set<AnyCancellable>()

    init(timeInterval: TimeInterval) {
        let timeInterval = timeInterval * 60
        
        self.timeInterval = timeInterval
        super.init(frame: .zero)
        
        setupViews()
        startTimer(interval: timeInterval)
        startAnimatePulse()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        refreshPosition()
    }
    
    private func setupViews() {
        layer.addSublayer(pulseShapeLayer)
        layer.addSublayer(shapeLayer)
        layer.addSublayer(trackShapeLayer)
        
        addSubviews(progressTimeLabel)
        
        trackShapeLayer.transform = CATransform3DMakeRotation(-.pi/2, 0, 0, 1)
        trackShapeLayer.strokeEnd = 0
        
        progressTimeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func refreshPosition() {
        shapeLayer.position = center
        pulseShapeLayer.position = center
        trackShapeLayer.position = center
    }
    
    private func createCircle(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        let circularPath = UIBezierPath(
            arcCenter: .zero,
            radius: 100,
            startAngle: 0,
            endAngle: 2 * CGFloat.pi,
            clockwise: true
        )
        
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.position = center
        layer.lineCap = .round
        layer.lineWidth = 12
        
        return layer
    }
    
    private func timeFormattedString(_ timeInterval: TimeInterval) -> String {
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 3600) / 60)
        
        return String(format: "%.2d:%.2d", minutes, seconds)
    }
    
    private func startAnimatePulse() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.1
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        
        pulseShapeLayer.add(animation, forKey: "pulsing")
    }
    
    private func stopAnimatePulse() {
        pulseShapeLayer.removeAnimation(forKey: "pulsing")
    }

    func startTimer(interval: TimeInterval) {
        timer
            .autoconnect()
            .receive(on: .mainQueue)
            .sink { [unowned self] time in
                timeInterval -= 1
                strokeInterval += 1/interval
                
                if timeInterval < 1 {
                    trackShapeLayer.strokeEnd = 0
                    progressTimeLabel.text = "0"
                    
                    timeInterval = 0
                    strokeInterval = 0
                    
                    stopTimer()
                    stopAnimatePulse()
                    
                    completeSubject.send()
                    
                } else {
                    
                    progressTimeLabel.text = timeFormattedString(timeInterval)
                    trackShapeLayer.strokeEnd = strokeInterval
                }
                
            }.store(in: &bindings)
    }
    
    func startTimer() {
        startTimer(interval: timeInterval)
    }
    
    func stopTimer() {
        timer
            .connect()
            .cancel()
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
//        timeInterval = trackShapeLayer.strokeEnd
    }
}

// MARK: - Preview

#if DEBUG
extension CircleProgressView {
    
    convenience init() {
        self.init(timeInterval: 60)
    }
}

struct CircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressView()
            .preview()
            .frame(width: 250, height: 250)
    }
}
#endif
