//
//  TDIndicator.swift
//  jlpt-ios-release
//
//  Created by Nguyen Trong Tung on 2017/11/11.
//  Copyright © 2017 Nguyen Trong Tung. All rights reserved.
//

import UIKit
import Lottie

class TDIndicator: UIView {
    var nibName: String = "TDIndicator"
    var contentView: UIView!
    @IBOutlet weak var parentIndicatorView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpIndicatorView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpIndicatorView()
    }

    func setUpIndicatorView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let parentView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        self.contentView = parentView
        self.addSubview(contentView)
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.alpha = 0.0
        guard let url = URL(string: Env.animationLink) else { return }
        let animationView = LOTAnimationView(contentsOf: url)
        animationView.frame = parentIndicatorView.bounds
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        parentIndicatorView.addSubview(animationView)
        animationView.play()
    }

    override func didMoveToSuperview() {
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = .identity
            self.parentIndicatorView.clipsToBounds = true
            self.parentIndicatorView.layer.cornerRadius = 5
        })
    }

    public func stopIndicatorLoading() {
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0.0
            self.removeFromSuperview()
        })
    }
}
