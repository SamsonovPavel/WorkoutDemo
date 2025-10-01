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
    
    private var progressButtonPublisher: AnyPublisher<Void, Never> {
        progressButton.publisher(for: .touchUpInside)
            .mapToVoid()
            .eraseToAnyPublisher()
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
    
    private lazy var progressButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stop", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 32)
        button.backgroundColor = .clear
        
        return button
    }()
    
    private var timeInterval: TimeInterval
    private var timer = Timer.publish(every: 1, on: .main, in: .common)
    
    private var isProgress: Bool = false {
        didSet {
            refreshProgressButton()
        }
    }
    
    private var bindings = Set<AnyCancellable>()

    init(timeInterval: TimeInterval = 0) {
        self.timeInterval = timeInterval
        super.init(frame: .zero)
        
        setupViews()
        bind()
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
        
        trackShapeLayer.transform = CATransform3DMakeRotation(-.pi/2, 0, 0, 1)
        trackShapeLayer.strokeEnd = 0

        addSubview(progressButton)
        
        progressButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func bind() {
        progressButtonPublisher
            .receive(on: .mainQueue)
            .sink { [unowned self] in
                isProgress.toggle()

                if isProgress {
                    startTimer()
                    startAnimatePulse()
                    
                } else {
                    
                    stopTimer()
                    stopAnimatePulse()
                }
                
            }.store(in: &bindings)
    }
    
    private func refreshPosition() {
        shapeLayer.position = center
        pulseShapeLayer.position = center
        trackShapeLayer.position = center
    }
    
    private func refreshProgressButton() {
        progressButton.setTitle(
            isProgress ? "Start" : "Stop",
            for: .normal
        )
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
    
    private func startAnimatePulse() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.2
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        
        pulseShapeLayer.add(animation, forKey: "pulsing")
    }
    
    private func stopAnimatePulse() {
        pulseShapeLayer.removeAnimation(forKey: "pulsing")
    }
    
    func startTimer() {
        timer
            .autoconnect()
            .receive(on: .mainQueue)
            .sink { [unowned self] time in
                timeInterval += 1/60
                trackShapeLayer.strokeEnd = timeInterval
                
            }.store(in: &bindings)
    }
    
    func stopTimer() {
        timer
            .connect()
            .cancel()
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
        timeInterval = trackShapeLayer.strokeEnd
    }
}

// MARK: - Preview

#if DEBUG
extension CircleProgressView {
    
    convenience init() {
        self.init(timeInterval: 0)
//        startTimer()
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
