//
//  InfoMessageView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import UIKit

class InfoMessageView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        var view = UILabel()

        view.frame = CGRect(x: 0, y: 0, width: 137, height: 53)

        view.backgroundColor = .white


        var shadows = UIView()

        shadows.frame = view.frame

        shadows.clipsToBounds = false

        view.addSubview(shadows)


        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 10)

        let layer0 = CALayer()

        layer0.shadowPath = shadowPath0.cgPath

        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor

        layer0.shadowOpacity = 1

        layer0.shadowRadius = 5

        layer0.shadowOffset = CGSize(width: 0, height: 1)

        layer0.bounds = shadows.bounds

        layer0.position = shadows.center

        shadows.layer.addSublayer(layer0)


        var shapes = UIView()

        shapes.frame = view.frame

        shapes.clipsToBounds = true

        view.addSubview(shapes)


        let layer1 = CALayer()

        layer1.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor

        layer1.bounds = shapes.bounds

        layer1.position = shapes.center

        shapes.layer.addSublayer(layer1)


        shapes.layer.cornerRadius = 10
        
        self.addSubview(view)
        
        view.snp.makeConstraints{ make in
            make.width.equalTo(137)
            make.height.equalTo(53)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
